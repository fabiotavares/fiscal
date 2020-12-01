import 'package:fiscal/app/model/infracao_excesso_peso_model.dart';
import 'package:fiscal/app/model/infracao_excesso_cmt_model.dart';
import 'package:fiscal/app/model/infracao_model.dart';
import 'dart:math';

enum OpcaoNotaFiscal {
  nao_possui,
  varios_remetentes,
  unico_remetente,
}

class FiscalizacaoPesoModel {
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
  final String inmetro;
  final String validadeAfericao;
  final String pbtcLabel;
  final toleranciaBalanca = 0.05;

  FiscalizacaoPesoModel({
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
    this.inmetro,
    this.validadeAfericao,
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
    inmetro: $inmetro
    validadeAfericao: $validadeAfericao
    ''';
  }

  List<InfracaoModel> getInfracoes() {
    var excessoPeso = InfracaoExcessoPesoModel();
    // considere o label correto para o tipo de veículo
    excessoPeso.pbtcLabel = pbtcLabel;
    // pbtc considerado deve ser o menor entre os valores legal e técnico
    excessoPeso.pbtcPermitido = pbtcLegal;
    if (pbtcTecnico > 0.0) {
      excessoPeso.pbtcPermitido = min(pbtcTecnico, pbtcLegal);
    }

    if (pesoAferido > 0.0) {
      // fiscalização por balança tem prioridade
      excessoPeso.tipo = TipoFiscalizacaoPeso.balanca;
      excessoPeso.pbtcConstatado = pesoAferido;
      // aplicar a tolerância prevista para balança (sobre o pbtc permitido)
      excessoPeso.tolerancia = excessoPeso.pbtcPermitido * toleranciaBalanca;
      //
    } else if (pesoDeclarado > 0.0) {
      // Fiscalização por nota fiscal (sem tolerância)
      excessoPeso.tipo = TipoFiscalizacaoPeso.nota_fiscal;
      excessoPeso.pbtcConstatado = pesoDeclarado + tara;
      // não há tolerância
      excessoPeso.tolerancia = 0.0;
    } else {
      // se não há peso calculado, então não há que se falar em infração
      return null;
    }
    // Calcula o excesso verificado (com possível tolerância) e o execesso sobre o cmt (sem tolerância)
    excessoPeso.excessoVerificado = excessoPeso.pbtcConstatado - (excessoPeso.pbtcPermitido + excessoPeso.tolerancia);

    // Define o responsavel
    if (opcaoNotaFiscal == OpcaoNotaFiscal.nao_possui ||
        opcaoNotaFiscal == OpcaoNotaFiscal.varios_remetentes ||
        (opcaoNotaFiscal == OpcaoNotaFiscal.unico_remetente && pesoDeclarado == 0.0)) {
      excessoPeso.responsavel = ResponsavelInfracao.transportador;
    } else if (opcaoNotaFiscal == OpcaoNotaFiscal.unico_remetente && pesoDeclarado < pesoAferido) {
      excessoPeso.responsavel = ResponsavelInfracao.embarcador;
    } else {
      excessoPeso.responsavel = ResponsavelInfracao.embarcador_transportador;
    }

    // verificando excesso sobre o cmt
    if (excessoPeso.pbtcConstatado > cmt && cmt > 0.0) {
      var excessoCmt = InfracaoExcessoCmtModel();
      excessoCmt.tipo = excessoPeso.tipo;
      excessoCmt.pbtcConstatado = excessoPeso.pbtcConstatado;
      excessoCmt.cmt = cmt;
      excessoCmt.pbtcLabel = pbtcLabel;

      // retorne as duas infrações
      return [excessoPeso, excessoCmt];
    }

    // retorne apenas uma infração
    return [excessoPeso];
  }
}
