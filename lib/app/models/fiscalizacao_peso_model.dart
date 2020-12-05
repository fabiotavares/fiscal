import 'package:fiscal/app/models/infracao_excesso_peso_model.dart';
import 'package:fiscal/app/models/infracao_excesso_cmt_model.dart';
import 'package:fiscal/app/models/infracao_model.dart';

enum OpcaoNotaFiscal {
  nao_possui,
  varios_remetentes,
  unico_remetente,
}

class FiscalizacaoPesoModel {
  final String classificacao;
  final double pbtcLegal;
  final double pbtcTecnico;
  final double tara;
  final double cmt;
  final String placas;
  final String tipoCarga;
  final OpcaoNotaFiscal opcaoNotaFiscal;
  final String cnpj;
  final double pesoDeclarado;
  final double pesoAferido;
  final String afericaoInmetro;
  final String afericaoValidade;
  final String pbtcLabel;

  FiscalizacaoPesoModel({
    this.classificacao,
    this.pbtcLegal,
    this.pbtcTecnico,
    this.tara,
    this.cmt,
    this.placas,
    this.tipoCarga,
    this.opcaoNotaFiscal,
    this.cnpj,
    this.pesoDeclarado,
    this.pesoAferido,
    this.afericaoInmetro,
    this.afericaoValidade,
    this.pbtcLabel,
  });

  @override
  String toString() {
    return '''
    pbtcLegal: $pbtcLegal
    pbtcTecnico: $pbtcTecnico
    tara: $tara
    cmt: $cmt
    placas: $placas
    tipoCarga: $tipoCarga
    opcaoNotaFiscal: $opcaoNotaFiscal
    cnpj: $cnpj
    pesoDeclarado: $pesoDeclarado
    pesoAferido: $pesoAferido
    inmetro: $afericaoInmetro
    validadeAfericao: $afericaoValidade
    ''';
  }

  List<InfracaoModel> getInfracoes() {
    // se não há peso declarado ou aferido, retorne nulo
    if (pesoAferido <= 0.0 && (pesoDeclarado <= 0.0 || tara <= 0.0)) {
      return null;
    }

    // pbtc considerado deve ser o menor entre os valores legal e técnico
    double pbtcPermitido = pbtcLegal;
    if (pbtcTecnico > 0.0 && pbtcTecnico < pbtcLegal) {
      pbtcPermitido = pbtcTecnico;
    }

    // cria a infração de excesso de peso...
    var excessoPeso = InfracaoExcessoPesoModel(
      tipo: pesoAferido > 0.0 ? TipoFiscalizacaoPeso.balanca : TipoFiscalizacaoPeso.nota_fiscal,
      pbtcPermitido: pbtcPermitido,
      pbtcConstatado: pesoAferido > 0.0 ? pesoAferido : pesoDeclarado + tara,
      tara: tara,
      pesoDeclarado: pesoDeclarado,
      pbtcLabel: pbtcLabel,
      classificacao: classificacao,
      carga: tipoCarga ?? '',
      afericaoInmetro: afericaoInmetro ?? '',
      afericaoValidade: afericaoValidade ?? '',
      placasTracionados: placas ?? '',
    );

    // complemento condicional no amparo legal
    if (pbtcPermitido != pbtcLegal) {
      // usando o limite do fabricante
      excessoPeso.amparoLegal += ', Art. 100 CTB';
    }

    // Define o responsavel
    ResponsavelInfracao responsavel = ResponsavelInfracao.transportador;
    var cnpj = '';
    if (opcaoNotaFiscal == OpcaoNotaFiscal.unico_remetente && pesoDeclarado > 0.0 && tara > 0.0) {
      if ((pesoDeclarado + tara) > pbtcPermitido) {
        responsavel = ResponsavelInfracao.embarcador_transportador;
        cnpj = this.cnpj;
      } else if ((pesoDeclarado + tara) < pesoAferido) {
        responsavel = ResponsavelInfracao.embarcador;
        cnpj = this.cnpj;
      }
    }
    // Atribuindo valores calculados
    excessoPeso.responsavel = responsavel;
    excessoPeso.cnpjEmbarcador = cnpj;

    // cria a infração de excesso na cmt...
    var excessoCmt = InfracaoExcessoCmtModel(
      tipo: excessoPeso.tipo,
      classificacao: classificacao,
      carga: tipoCarga,
      afericaoInmetro: afericaoInmetro,
      afericaoValidade: afericaoValidade,
      pbtcLabel: pbtcLabel,
      pbtcConstatado: excessoPeso.pbtcConstatado,
      cmt: cmt,
      tara: tara,
      pesoDeclarado: pesoDeclarado,
      placasTracionados: excessoPeso.placasTracionados,
    );

    // complemento condicional no amparo legal
    if (pbtcTecnico > 0.0 && pbtcTecnico < pbtcLegal) {
      // atualiza o amparo legal...
      excessoCmt.amparoLegal += ', Art. 100 CTB';
    }

    // retorne as duas infrações
    return [excessoPeso, excessoCmt];
  }
}
