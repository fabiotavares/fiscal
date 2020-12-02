import 'package:fiscal/app/components/text_with_copy_button.dart';
import 'package:fiscal/app/model/infracao_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfracaoExcessoPesoModel extends InfracaoModel {
  TipoFiscalizacaoPeso tipo;
  double pbtcPermitido;
  double pbtcConstatado;
  double porcentagemTolerancia;
  double tara;
  double pesoDeclarado;
  String pbtcLabel;
  String classificacao;
  String carga;
  String afericaoInmetro;
  String afericaoValidade;
  String cnpjEmbarcador;

  InfracaoExcessoPesoModel({
    this.tipo,
    this.pbtcPermitido,
    this.pbtcConstatado,
    this.porcentagemTolerancia = 0.0,
    this.tara,
    this.pesoDeclarado,
    this.pbtcLabel,
    this.classificacao,
    this.carga,
    this.afericaoInmetro,
    this.afericaoValidade,
    this.cnpjEmbarcador,
  }) : super(
          codigo: '683-11',
          artigoCtb: 'Art. 231 V',
          amparoLegal: 'Res 210, 290, 803 CONTRAN',
          medidaAdministrativa: 'Retenção do veículo e transbordo de carga excedente',
          gravidade: GravidadeInfracao.media,
        );

  double get excessoVerificado {
    return pbtcConstatado - pbtcPermitido - tolerancia;
  }

  double get tolerancia {
    if (tipo == TipoFiscalizacaoPeso.balanca && porcentagemTolerancia > 0.0) {
      return pbtcPermitido * porcentagemTolerancia;
    }
    return 0.0;
  }

  String get tipoFiscalizacao {
    switch (tipo.index) {
      case 0:
        return 'Balança';
        break;
      case 1:
        return 'Nota Fiscal';
        break;
      default:
        return null;
    }
  }

  String getValorQuilosFormatado(double value) {
    final num = FlutterMoneyFormatter(
        amount: value,
        settings: MoneyFormatterSettings(
          symbol: 'kg',
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: ' ',
          fractionDigits: 2,
        ));

    return num.output.symbolOnRight;
  }

  @override
  Widget getInfracaoWidget() {
    // retorna uma representação gráfica da infração pra ser exibida na tela
    return Container(
      padding: EdgeInsets.only(top: 12.0),
      width: ScreenUtil().screenWidth,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: excessoVerificado <= 0.0
            ? Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Não há infração por excesso no $pbtcLabel',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    getDadosInfracao(),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Infração por excesso no $pbtcLabel',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        getDadosInfracao(),
                      ],
                    ),
                  ),
                  TextWithCopyButton(
                    title: 'Sugestão para o auto:',
                    body: '${sugestoesAuto[0]}',
                    toCopy: '${sugestoesAuto[0]}',
                    backgoundColor: Colors.grey[200],
                    margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                    padding: EdgeInsets.only(left: 16.0, right: 8.0, bottom: 16.0, top: 16.0),
                  ),
                ],
              ),
      ),
    );
  }

  @override
  List<String> get sugestoesAuto {
    // sobre tolerância
    var obsTolerancia = '';
    if (tolerancia > 0.0) {
      obsTolerancia = ' (c/ ${(porcentagemTolerancia * 100.0).toStringAsFixed(0)}% tolerância)';
    }

    //sobre aferição da balança
    var balancaAfericao = '';
    if (tipo == TipoFiscalizacaoPeso.balanca) {
      var obsInmetro = '';
      var obsValidade = '';

      if (afericaoInmetro.isNotEmpty) {
        obsInmetro = '- INMETRO: $afericaoInmetro, ';
      } else {
        obsInmetro = '- INMETRO: XXX, ';
      }

      if (afericaoValidade.isNotEmpty) {
        obsValidade = 'val. $afericaoValidade;\n';
      } else {
        obsValidade = 'val. XXX;\n';
      }

      balancaAfericao = '$obsInmetro$obsValidade';
    }

    // sobre a carga
    var obsCarga = '';
    if (carga.isNotEmpty) {
      obsCarga = '- Carga: $carga;\n';
    }

    // sobre embarcador
    var obsEmbarcador = '';
    if (cnpjEmbarcador.isNotEmpty) {
      obsEmbarcador = '- Embarcador: $cnpjEmbarcador;\n';
    }

    // sobre placas dos tracionados
    var obsPlacas = '';
    if (super.placasTracionados.isNotEmpty) {
      obsPlacas = '- Tracionados: ${super.placasTracionados};\n';
    }

    // sobre tara e peso da carga no caso de nota fiscal
    var obsTaraCarga = '';
    if (tipo == TipoFiscalizacaoPeso.nota_fiscal) {
      obsTaraCarga = '- Tara: ${getValorQuilosFormatado(tara)};\n' + '- Lotação: ${getValorQuilosFormatado(pesoDeclarado)};\n';
    }

    return [
      '- Classif. $classificacao (Port. 63/09 DENATRAN);\n' +
          '- $pbtcLabel: ${getValorQuilosFormatado(pbtcPermitido + tolerancia)}$obsTolerancia;\n' +
          '$obsTaraCarga' +
          '$balancaAfericao' +
          '$obsCarga' +
          '$obsEmbarcador' +
          '$obsPlacas' +
          '- $amparoLegal;\n' +
          '- Retido para transbordo.'
    ];
  }

  Widget getDadosInfracao() {
    // retorna uma apresentação dos dados consolidados da infração
    // sobre embarcador
    var obsEmbarcador = '';
    if (cnpjEmbarcador.isNotEmpty) {
      obsEmbarcador = '- Embarcador: $cnpjEmbarcador';
    }

    // sobre tolerância
    var obsTolerancia = 'Tolerância (não aplicável)';
    if (tolerancia > 0.0) {
      obsTolerancia = 'Tolerância (${(porcentagemTolerancia * 100.0).toStringAsFixed(0)}%)';
    }

    if (excessoVerificado <= 0.0) {
      return Text('Tipo de fiscalização: ${this.tipoFiscalizacao}\n' +
          '- $pbtcLabel permitido: ${getValorQuilosFormatado(this.pbtcPermitido)}\n' +
          '- $obsTolerancia: ${getValorQuilosFormatado(this.tolerancia)}\n' +
          '- $pbtcLabel constatado: ${getValorQuilosFormatado(this.pbtcConstatado)}\n' +
          '- Excesso verificado: ${getValorQuilosFormatado(excessoVerificado)}\n' +
          '- ${super.amparoLegal}');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWithCopyButton(
          title: 'Código: ${super.codigo}',
          toCopy: '${super.codigo}',
          backgoundColor: Colors.grey[200],
          margin: EdgeInsets.symmetric(vertical: 2),
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0, left: 9.0),
        ),
        Text('- CTB: ${super.artigoCtb}'),
        Text('- Tipo de fiscalização: ${this.tipoFiscalizacao}'),
        Text('- $pbtcLabel permitido: ${getValorQuilosFormatado(this.pbtcPermitido)}'),
        Text('- $obsTolerancia: ${getValorQuilosFormatado(this.tolerancia)}'),
        TextWithCopyButton(
          title: 'Total permitido: ${getValorQuilosFormatado(this.pbtcPermitido + this.tolerancia)}',
          toCopy: '${this.pbtcPermitido + this.tolerancia}',
          backgoundColor: Colors.grey[200],
          margin: EdgeInsets.symmetric(vertical: 2),
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0, left: 9.0),
        ),
        TextWithCopyButton(
          title: '$pbtcLabel constatado: ${getValorQuilosFormatado(this.pbtcConstatado)}',
          toCopy: '${this.pbtcConstatado}',
          backgoundColor: Colors.grey[200],
          margin: EdgeInsets.symmetric(vertical: 2),
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0, left: 9.0),
        ),
        Text('- Excesso verificado: ${getValorQuilosFormatado(excessoVerificado)}'),
        Text('- Gravidade: ${super.getGravidade()}'),
        Text('- Responsável: ${super.getResponsavel()}'),
        if (obsEmbarcador.isNotEmpty) Text('$obsEmbarcador'),
        Text('- ${super.amparoLegal}'),
        Text('- Medida administrativa: ${super.medidaAdministrativa}'),
      ],
    );
  }
}
