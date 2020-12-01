import 'package:fiscal/app/model/infracao_model.dart';

class InfracaoExcessoPesoModel extends InfracaoModel {
  TipoFiscalizacaoPeso tipo;
  double pbtcPermitido;
  double pbtcConstatado;
  double tolerancia;
  double excessoVerificado;
  String pbtcLabel;

  InfracaoExcessoPesoModel({
    this.tipo,
    this.pbtcPermitido,
    this.pbtcConstatado,
    this.tolerancia,
    this.excessoVerificado,
    this.pbtcLabel,
  }) : super(
          codigo: '683-11',
          artigoCtb: 'Art. 231 V',
          amparoLegal: 'Res 210, 290, 803 CONTRAN',
          medidaAdministrativa: 'Retenção do veículo e transbordo de carga excedente',
          gravidade: GravidadeInfracao.media,
        );

  String get getTipoFiscalizacao {
    if (tipo == TipoFiscalizacaoPeso.balanca) {
      return 'Balança';
    }
    return 'Nota Fiscal';
  }

  @override
  String toString() {
    if (excessoVerificado <= 0.0) {
      return 'Não há infração de excesso de peso';
    }

    return 'Infração por excesso de peso no $pbtcLabel\n\n' +
        '- Código: ${super.codigo}\n' +
        '- Artigo: ${super.artigoCtb}\n' +
        '- Amparo legal: ${super.amparoLegal}\n' +
        '- Tipo de fiscalização: ${this.getTipoFiscalizacao}\n' +
        '- $pbtcLabel permitido: ${this.pbtcPermitido}\n' +
        '- $pbtcLabel constatado: ${this.pbtcConstatado}\n' +
        '- Tolerância sobre o $pbtcLabel permitido: ${this.tolerancia}\n' +
        '- Excesso verificado: $excessoVerificado\n' +
        '- Medida administrativa: ${super.medidaAdministrativa}\n' +
        '- Gravidade: ${super.gravidade}\n' +
        '- Responsável: ${super.responsavel}';
  }
}
