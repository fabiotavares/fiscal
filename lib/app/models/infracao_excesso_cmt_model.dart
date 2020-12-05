import 'package:fiscal/app/shared/components/text_with_copy_button.dart';
import 'package:fiscal/app/shared/utils/constants.dart';
import 'package:fiscal/app/shared/utils/numbers.dart';
import 'package:fiscal/app/models/gravidade_infracao_model.dart';
import 'package:fiscal/app/models/infracao_model.dart';
import 'package:flutter/material.dart';
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
  String placasTracionados;

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
    this.placasTracionados,
  }) : super(
          artigoCtb: 'Art. 231 X',
          amparoLegal: 'Res 210/211, 290, 803 CONTRAN',
          medidaAdministrativa: 'Retenção do veículo e transbordo de carga excedente',
          responsavel: ResponsavelInfracao.proprietario,
        ) {
    // determinando o código e gravidade da infração
    if (excessoVerificado > 1000.0) {
      var valor = (excessoVerificado / 500.0).ceil() * VALOR_INFRACAO_GRAVISSIMA;
      super.gravidade = GravidadeInfracaoModel.gravissima(valor: valor);
      super.codigo = '689-40';
    } else if (excessoVerificado > 600.0) {
      super.gravidade = GravidadeInfracaoModel.grave();
      super.codigo = '689-00';
    } else if (excessoVerificado > 0.0) {
      super.gravidade = GravidadeInfracaoModel.media();
      super.codigo = '688-20';
    }
  }

  double get excessoVerificado {
    if (cmt > 0) {
      return pbtcConstatado - cmt;
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

  @override
  Widget getInfracaoView() {
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
                        getInfracaoDetalhes(),
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
                            getInfracaoDetalhes(),
                          ],
                        ),
                      ),
                      TextWithCopyButton(
                        title: 'Sugestão para o auto:',
                        body: '${getSugestao()}',
                        toCopy: '${getSugestao()}',
                        backgoundColor: Colors.grey[200],
                        margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                        padding: EdgeInsets.only(left: 16.0, right: 8.0, bottom: 16.0, top: 16.0),
                      ),
                    ],
                  ),
      ),
    );
  }

  Widget getInfracaoDetalhes() {
    // retorna uma apresentação dos dados consolidados da infração
    if (excessoVerificado <= 0.0) {
      return Text('- Tipo de fiscalização: ${this.tipoFiscalizacao}\n' +
          '- CMT: ${Numbers.getPesoFormatado(cmt)}\n' +
          '- $pbtcLabel constatado: ${Numbers.getPesoFormatado(pbtcConstatado)}\n' +
          '- Excesso verificado: ${Numbers.getPesoFormatado(excessoVerificado)}\n' +
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
          title: '- CMT: ${Numbers.getPesoFormatado(cmt)}',
          toCopy: '$cmt',
          backgoundColor: Colors.grey[200],
          margin: EdgeInsets.symmetric(vertical: 2),
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0, left: 9.0),
        ),
        TextWithCopyButton(
          title: '- $pbtcLabel constatado: ${Numbers.getPesoFormatado(pbtcConstatado)}',
          toCopy: '$pbtcConstatado',
          backgoundColor: Colors.grey[200],
          margin: EdgeInsets.symmetric(vertical: 2),
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0, left: 9.0),
        ),
        Text('- Excesso verificado: ${Numbers.getPesoFormatado(excessoVerificado)}'),
        Text('- Gravidade: ${super.gravidade.gravidade}'),
        Text('- Pontos perdidos: ${super.gravidade.pontos}'),
        Text('- Valor: ${super.gravidade.getValorFormatado()}'),
        Text('- Responsável: ${super.getResponsavel()}'),
        Text('- ${super.amparoLegal}'),
        Text('- Medida administrativa: ${super.medidaAdministrativa}'),
      ],
    );
  }

  String getSugestao() {
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
    if (placasTracionados.isNotEmpty) {
      obsPlacas = '- Tracionados: $placasTracionados;\n';
    }

    // sobre o PBTC (aferido ou tara + lotação)
    var obsPbtc = '';
    if (tipo == TipoFiscalizacaoPeso.nota_fiscal) {
      obsPbtc =
          '- Tara: ${Numbers.getPesoFormatado(tara)};\n' + '- Lotação: ${Numbers.getPesoFormatado(pesoDeclarado)};\n';
    } else {
      obsPbtc = '- $pbtcLabel: ${Numbers.getPesoFormatado(pbtcConstatado)};\n';
    }

    return '- Classif. $classificacao (Port. 63/09 DENATRAN);\n' +
        '- CMT: ${Numbers.getPesoFormatado(cmt)} (plac. fabricante);\n' +
        '$obsPbtc' +
        '$balancaAfericao' +
        '$obsCarga' +
        '$obsPlacas' +
        '- $amparoLegal;\n' +
        '- Retido para transbordo.';
  }
}
