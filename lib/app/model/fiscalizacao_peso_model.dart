import 'package:fiscal/app/model/infracao_excesso_peso_model.dart';
import 'package:fiscal/app/model/infracao_excesso_cmt_model.dart';
import 'package:fiscal/app/model/infracao_model.dart';

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
  final toleranciaBalanca = 0.05;

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
    // cria a infração de excesso de peso...
    var excessoPeso = InfracaoExcessoPesoModel(
      classificacao: classificacao,
      carga: tipoCarga ?? '',
      afericaoInmetro: afericaoInmetro ?? '',
      afericaoValidade: afericaoValidade ?? '',
      pbtcLabel: pbtcLabel,
      tara: tara,
      pesoDeclarado: pesoDeclarado,
    );

    // placas dos tracionados
    excessoPeso.placasTracionados = placas ?? '';

    // pbtc considerado deve ser o menor entre os valores legal e técnico
    if (pbtcTecnico > 0.0 && pbtcTecnico < pbtcLegal) {
      excessoPeso.pbtcPermitido = pbtcTecnico;
      // atualiza o amparo legal...
      excessoPeso.amparoLegal += ', Art. 100 CTB';
    } else {
      excessoPeso.pbtcPermitido = pbtcLegal;
    }

    if (pesoAferido > 0.0) {
      // fiscalização por balança tem prioridade
      excessoPeso.tipo = TipoFiscalizacaoPeso.balanca;
      excessoPeso.pbtcConstatado = pesoAferido;
      // aplicar a tolerância prevista para balança (sobre o pbtc permitido)
      excessoPeso.porcentagemTolerancia = toleranciaBalanca;
      //
    } else if (pesoDeclarado > 0.0) {
      // Fiscalização por nota fiscal (sem tolerância)
      excessoPeso.tipo = TipoFiscalizacaoPeso.nota_fiscal;
      excessoPeso.pbtcConstatado = pesoDeclarado + tara;

      // não há tolerância
      excessoPeso.porcentagemTolerancia = 0.0;
    } else {
      // se não há peso calculado, então não há que se falar em infração
      return null;
    }

    // Define o responsavel
    if (opcaoNotaFiscal == OpcaoNotaFiscal.nao_possui ||
        opcaoNotaFiscal == OpcaoNotaFiscal.varios_remetentes ||
        (opcaoNotaFiscal == OpcaoNotaFiscal.unico_remetente && pesoDeclarado == 0.0)) {
      excessoPeso.responsavel = ResponsavelInfracao.transportador;
      excessoPeso.cnpjEmbarcador = '';
    } else if (opcaoNotaFiscal == OpcaoNotaFiscal.unico_remetente && pesoDeclarado < pesoAferido) {
      excessoPeso.responsavel = ResponsavelInfracao.embarcador;
      excessoPeso.cnpjEmbarcador = cnpj;
    } else {
      excessoPeso.responsavel = ResponsavelInfracao.embarcador_transportador;
      excessoPeso.cnpjEmbarcador = cnpj;
    }

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
    );

    // complemento condicional no amparo legal
    if (pbtcTecnico > 0.0 && pbtcTecnico < pbtcLegal) {
      // atualiza o amparo legal...
      excessoCmt.amparoLegal += ', Art. 100 CTB';
    }

    // placas dos tracionados
    excessoCmt.placasTracionados = placas ?? '';

    // retorne as duas infrações
    return [excessoPeso, excessoCmt];
  }
}
