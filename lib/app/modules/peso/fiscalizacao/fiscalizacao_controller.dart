import 'package:fiscal/app/models/auto_peso_model.dart';
import 'package:fiscal/app/models/fiscalizacao_peso_model.dart';
import 'package:fiscal/app/models/infracao_model.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'fiscalizacao_controller.g.dart';

@Injectable()
class FiscalizacaoController = _FiscalizacaoControllerBase with _$FiscalizacaoController;

abstract class _FiscalizacaoControllerBase with Store {
  @observable
  List<AutoPesoModel> autos = [];

  @action
  void getAutos(FiscalizacaoPesoModel f) {
    // se não há peso declarado ou aferido, retorne nulo
    if (f.pesoAferido <= 0.0 && (f.pesoDeclarado <= 0.0 || f.tara <= 0.0)) {
      return null;
    }

    // pbtc considerado deve ser o menor entre os valores legal e técnico
    double pbtcPermitido = f.pbtcLegal;
    if (f.pbtcTecnico > 0.0 && f.pbtcTecnico < f.pbtcLegal) {
      pbtcPermitido = f.pbtcTecnico;
    }

    // cria o auto para excesso de peso...
    var excessoPeso = AutoPesoModel(
      isCmt: false,
      tipo: f.pesoAferido > 0.0 ? TipoFiscalizacaoPeso.balanca : TipoFiscalizacaoPeso.nota_fiscal,
      pesoPermitido: pbtcPermitido,
      pesoConstatado: f.pesoAferido > 0.0 ? f.pesoAferido : f.pesoDeclarado + f.tara,
      tara: f.tara,
      pesoDeclarado: f.pesoDeclarado,
      pbtcLabel: f.pbtcLabel,
      classificacao: f.classificacao,
      carga: f.tipoCarga ?? '',
      afericaoInmetro: f.afericaoInmetro ?? '',
      afericaoValidade: f.afericaoValidade ?? '',
      placasTracionados: f.placas ?? '',
    );

    // complemento condicional no amparo legal
    if (pbtcPermitido != f.pbtcLegal) {
      // usando o limite do fabricante
      excessoPeso.infracao.amparo += ', Art. 100 CTB';
    }

    // Define o responsavel
    var responsavel = ResponsavelInfracao.transportador;
    var cnpj = '';
    if (f.opcaoNotaFiscal == OpcaoNotaFiscal.unico_remetente && f.pesoDeclarado > 0.0 && f.tara > 0.0) {
      if ((f.pesoDeclarado + f.tara) > pbtcPermitido) {
        responsavel = ResponsavelInfracao.embarcador_transportador;
        cnpj = f.cnpj;
      } else if ((f.pesoDeclarado + f.tara) < f.pesoAferido) {
        responsavel = ResponsavelInfracao.embarcador;
        cnpj = f.cnpj;
      }
    }
    // Atribuindo valores calculados
    excessoPeso.infracao.responsavel = responsavel;
    excessoPeso.cnpjEmbarcador = cnpj;

    // cria a infração de excesso na cmt...
    var excessoCmt = AutoPesoModel(
      isCmt: true,
      tipo: excessoPeso.tipo,
      pesoPermitido: f.cmt,
      pesoConstatado: excessoPeso.pesoConstatado,
      tara: f.tara,
      pesoDeclarado: f.pesoDeclarado,
      pbtcLabel: f.pbtcLabel,
      classificacao: f.classificacao,
      carga: f.tipoCarga,
      afericaoInmetro: f.afericaoInmetro,
      afericaoValidade: f.afericaoValidade,
      placasTracionados: excessoPeso.placasTracionados,
    );

    // complemento condicional no amparo legal
    if (f.pbtcTecnico > 0.0 && f.pbtcTecnico < f.pbtcLegal) {
      // atualiza o amparo legal...
      excessoCmt.infracao.amparo += ', Art. 100 CTB';
    }

    // atualiza lista de autos para esta fiscalização de peso
    autos = [excessoPeso, excessoCmt];
  }
}
