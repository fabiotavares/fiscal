import 'package:fiscal/app/model/infracao_model.dart';

class InfracaoExcessoCmtModel extends InfracaoModel {
  TipoFiscalizacaoPeso tipo;
  double cmt;
  double pbtcConstatado;
  String pbtcLabel;

  InfracaoExcessoCmtModel({
    this.tipo,
    this.cmt,
    this.pbtcConstatado,
    this.pbtcLabel,
  }) : super(
          artigoCtb: 'Art. 231 X',
          amparoLegal: 'Res 210/211, 290, 803 CONTRAN',
          medidaAdministrativa: 'Retenção do veículo e transbordo de carga excedente',
          responsavel: ResponsavelInfracao.proprietario,
        );

  double get excessoCmt => pbtcConstatado - cmt;

  String get codigo {
    // descobre o código certo de acordo com o tamano do excesso
    // retorna null se não há excesso de cmt
    if (excessoCmt <= 0) {
      return null;
    }

    if (excessoCmt <= 600) {
      super.gravidade = GravidadeInfracao.media;
      return '688-20';
    }

    if (excessoCmt <= 1000) {
      super.gravidade = GravidadeInfracao.grave;
      return '689-00';
    }
    super.gravidade = GravidadeInfracao.gravissima;
    return '689-40';
  }

  String get getTipoFiscalizacao {
    if (tipo == TipoFiscalizacaoPeso.balanca) {
      return 'Balança';
    }
    return 'Nota Fiscal';
  }

  @override
  String toString() {
    if (excessoCmt <= 0.0) {
      return 'Não há infração de excesso sobre a CMT';
    }

    return '\nInfração por excesso sobre a CMT\n\n' +
        '- Código: ${this.codigo}\n' +
        '- Artigo: ${super.artigoCtb}\n' +
        '- Amparo legal: ${super.amparoLegal}\n' +
        '- Tipo de fiscalização: ${this.getTipoFiscalizacao}\n' +
        '- CMT: ${this.cmt}\n' +
        '- $pbtcLabel constatado: ${this.pbtcConstatado}\n' +
        '- Excesso verificado: $excessoCmt\n' +
        '- Medida administrativa: ${super.medidaAdministrativa}\n' +
        '- Gravidade: ${super.gravidade}\n' +
        '- Responsável: ${super.responsavel}';
  }
}
