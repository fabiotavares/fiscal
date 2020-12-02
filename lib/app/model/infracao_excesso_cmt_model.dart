import 'package:fiscal/app/components/text_with_copy_button.dart';
import 'package:fiscal/app/model/infracao_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfracaoExcessoCmtModel extends InfracaoModel {
  TipoFiscalizacaoPeso tipo;
  double cmt;
  double pbtcConstatado;
  double tara;
  double pesoDeclarado;
  String pbtcLabel;
  String classificacao;
  String carga;
  String afericaoInmetro;
  String afericaoValidade;

  InfracaoExcessoCmtModel({
    this.tipo,
    this.cmt,
    this.pbtcConstatado,
    this.tara,
    this.pesoDeclarado,
    this.pbtcLabel,
    this.classificacao,
    this.carga,
    this.afericaoInmetro,
    this.afericaoValidade,
  }) : super(
          artigoCtb: 'Art. 231 X',
          amparoLegal: 'Res 210/211, 290, 803 CONTRAN',
          medidaAdministrativa: 'Retenção do veículo e transbordo de carga excedente',
          responsavel: ResponsavelInfracao.proprietario,
        );

  double get excessoVerificado {
    if (cmt > 0) {
      return pbtcConstatado - cmt;
    }
    return 0.0;
  }

  String get codigo {
    // descobre o código certo de acordo com o tamano do excesso
    if (excessoVerificado <= 0) {
      // retorna null se não há excesso de cmt
      return null;
    }

    if (excessoVerificado <= 600) {
      super.gravidade = GravidadeInfracao.media;
      return '688-20';
    }
    if (excessoVerificado <= 1000) {
      super.gravidade = GravidadeInfracao.grave;
      return '689-00';
    }
    super.gravidade = GravidadeInfracao.gravissima;
    return '689-40';
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
    // retorna uma representação pra ser exibida na tela
    return Container(
      padding: EdgeInsets.only(top: 8.0, bottom: 12.0),
      width: ScreenUtil().screenWidth,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: cmt == 0.0
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'CMT não informada',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            : excessoVerificado <= 0.0
                ? Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Não há infração por excesso na CMT',
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
                              'Infração por excesso na CMT',
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

    // sobre placas dos tracionados
    var obsPlacas = '';
    if (super.placasTracionados.isNotEmpty) {
      obsPlacas = '- Tracionados: ${super.placasTracionados};\n';
    }

    // sobre o PBTC (aferido ou tara + lotação)
    var obsPbtc = '';
    if (tipo == TipoFiscalizacaoPeso.nota_fiscal) {
      obsPbtc = '- Tara: ${getValorQuilosFormatado(tara)};\n' + '- Lotação: ${getValorQuilosFormatado(pesoDeclarado)};\n';
    } else {
      obsPbtc = '- $pbtcLabel: ${getValorQuilosFormatado(pbtcConstatado)};\n';
    }

    return [
      '- Classif. $classificacao (Port. 63/09 DENATRAN);\n' +
          '- CMT: ${getValorQuilosFormatado(cmt)} (plac. fabricante);\n' +
          '$obsPbtc' +
          '$balancaAfericao' +
          '$obsCarga' +
          '$obsPlacas' +
          '- $amparoLegal;\n' +
          '- Retido para transbordo.'
    ];
  }

  Widget getDadosInfracao() {
    // retorna uma apresentação dos dados consolidados da infração
    if (excessoVerificado <= 0.0) {
      return Text('- Tipo de fiscalização: ${this.tipoFiscalizacao}\n' +
          '- CMT: ${getValorQuilosFormatado(cmt)}\n' +
          '- $pbtcLabel constatado: ${getValorQuilosFormatado(pbtcConstatado)}\n' +
          '- Excesso verificado: ${getValorQuilosFormatado(excessoVerificado)}\n' +
          '- ${super.amparoLegal}');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWithCopyButton(
          title: 'Código: ${this.codigo}',
          toCopy: '${this.codigo}',
          backgoundColor: Colors.grey[200],
          margin: EdgeInsets.symmetric(vertical: 2),
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0, left: 9.0),
        ),
        Text('- CTB: ${super.artigoCtb}'),
        Text('- Tipo de fiscalização: ${this.tipoFiscalizacao}'),
        TextWithCopyButton(
          title: '- CMT: ${getValorQuilosFormatado(cmt)} (plac. fabricante)',
          toCopy: '$cmt',
          backgoundColor: Colors.grey[200],
          margin: EdgeInsets.symmetric(vertical: 2),
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0, left: 9.0),
        ),
        TextWithCopyButton(
          title: '- $pbtcLabel constatado: ${getValorQuilosFormatado(pbtcConstatado)}',
          toCopy: '$pbtcConstatado',
          backgoundColor: Colors.grey[200],
          margin: EdgeInsets.symmetric(vertical: 2),
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0, left: 9.0),
        ),
        Text('- Excesso verificado: ${getValorQuilosFormatado(excessoVerificado)}'),
        Text('- Gravidade: ${super.getGravidade()}'),
        Text('- Responsável: ${super.getResponsavel()}'),
        Text('- ${super.amparoLegal}'),
        Text('- Medida administrativa: ${super.medidaAdministrativa}'),
      ],
    );
  }
}
