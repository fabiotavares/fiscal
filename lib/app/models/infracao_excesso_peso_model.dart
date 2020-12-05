import 'package:fiscal/app/shared/components/text_with_copy_button.dart';
import 'package:fiscal/app/shared/utils/constants.dart';
import 'package:fiscal/app/shared/utils/numbers.dart';
import 'package:fiscal/app/models/gravidade_infracao_model.dart';
import 'package:fiscal/app/models/infracao_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfracaoExcessoPesoModel extends InfracaoModel {
  TipoFiscalizacaoPeso tipo;
  double pbtcPermitido;
  double pbtcConstatado;
  double tara;
  double pesoDeclarado;
  String pbtcLabel;
  String classificacao;
  String carga;
  String afericaoInmetro;
  String afericaoValidade;
  String cnpjEmbarcador;
  String placasTracionados;

  InfracaoExcessoPesoModel({
    @required this.tipo,
    @required this.pbtcPermitido,
    @required this.pbtcConstatado,
    this.tara,
    this.pesoDeclarado,
    this.pbtcLabel,
    this.classificacao,
    this.carga,
    this.afericaoInmetro,
    this.afericaoValidade,
    this.cnpjEmbarcador,
    this.placasTracionados,
  }) : super(
          codigo: '683-11',
          artigoCtb: 'Art. 231 V',
          amparoLegal: 'Res 210, 290, 803 CONTRAN',
          medidaAdministrativa: 'Retenção do veículo e transbordo de carga excedente',
        ) {
    // Definindo a gravidade da infração...
    // peso a ser considerado no acréscimo da multa
    double peso;
    if (excessoVerificado >= 5001.0) {
      peso = 53.20;
    } else if (excessoVerificado >= 3001.0) {
      peso = 42.56;
    } else if (excessoVerificado >= 1001.0) {
      peso = 31.92;
    } else if (excessoVerificado >= 801.0) {
      peso = 21.28;
    } else if (excessoVerificado >= 601.0) {
      peso = 10.64;
    } else {
      peso = 5.32;
    }

    // valor será a multa média acrescida do peso determinado a cada fração de 200 kg
    super.gravidade =
        GravidadeInfracaoModel.media(valor: VALOR_INFRACAO_MEDIA + (excessoVerificado / 200.0).ceil() * peso);
  }

  double get excessoVerificado {
    return pbtcConstatado - pbtcPermitido - tolerancia;
  }

  double get tolerancia {
    if (tipo == TipoFiscalizacaoPeso.balanca) {
      return pbtcPermitido * TOLERANCIA_PBTC_BALANCA;
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
                          'Infração por excesso no $pbtcLabel',
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
    // sobre embarcador
    var obsEmbarcador = '';
    if (cnpjEmbarcador.isNotEmpty) {
      obsEmbarcador = '- Embarcador: $cnpjEmbarcador';
    }

    // sobre tolerância
    var obsTolerancia = 'Tolerância (não aplicável)';
    if (tolerancia > 0.0) {
      obsTolerancia = 'Tolerância (${(TOLERANCIA_PBTC_BALANCA * 100.0).toStringAsFixed(0)}%)';
    }

    if (excessoVerificado <= 0.0) {
      return Text('Tipo de fiscalização: ${this.tipoFiscalizacao}\n' +
          '- $pbtcLabel permitido: ${Numbers.getPesoFormatado(this.pbtcPermitido)}\n' +
          '- $obsTolerancia: ${Numbers.getPesoFormatado(this.tolerancia)}\n' +
          '- Total permitido: ${Numbers.getPesoFormatado(this.pbtcPermitido + this.tolerancia)}\n' +
          '- $pbtcLabel constatado: ${Numbers.getPesoFormatado(this.pbtcConstatado)}\n' +
          '- Excesso verificado: ${Numbers.getPesoFormatado(excessoVerificado)}\n' +
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
        Text('- $pbtcLabel permitido: ${Numbers.getPesoFormatado(this.pbtcPermitido)}'),
        Text('- $obsTolerancia: ${Numbers.getPesoFormatado(this.tolerancia)}'),
        TextWithCopyButton(
          title: 'Total permitido: ${Numbers.getPesoFormatado(this.pbtcPermitido + this.tolerancia)}',
          toCopy: '${this.pbtcPermitido + this.tolerancia}',
          backgoundColor: Colors.grey[200],
          margin: EdgeInsets.symmetric(vertical: 2),
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0, left: 9.0),
        ),
        TextWithCopyButton(
          title: '$pbtcLabel constatado: ${Numbers.getPesoFormatado(this.pbtcConstatado)}',
          toCopy: '${this.pbtcConstatado}',
          backgoundColor: Colors.grey[200],
          margin: EdgeInsets.symmetric(vertical: 2),
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0, left: 9.0),
        ),
        Text('- Excesso verificado: ${Numbers.getPesoFormatado(excessoVerificado)}'),
        Text('- Gravidade: ${super.gravidade.gravidade}'),
        Text('- Pontos perdidos: ${super.gravidade.pontos}'),
        Text('- Valor: ${super.gravidade.getValorFormatado()}'),
        Text('- Responsável: ${super.getResponsavel()}'),
        if (obsEmbarcador.isNotEmpty) Text('$obsEmbarcador'),
        Text('- ${super.amparoLegal}'),
        Text('- Medida administrativa: ${super.medidaAdministrativa}'),
      ],
    );
  }

  String getSugestao() {
    // sobre tolerância
    var obsTolerancia = '';
    if (tolerancia > 0.0) {
      obsTolerancia = ' (c/ ${(TOLERANCIA_PBTC_BALANCA * 100.0).toStringAsFixed(0)}% tolerância)';
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
    if (placasTracionados.isNotEmpty) {
      obsPlacas = '- Tracionados: $placasTracionados;\n';
    }

    // sobre tara e peso da carga no caso de nota fiscal
    var obsTaraCarga = '';
    if (tipo == TipoFiscalizacaoPeso.nota_fiscal) {
      obsTaraCarga =
          '- Tara: ${Numbers.getPesoFormatado(tara)};\n' + '- Lotação: ${Numbers.getPesoFormatado(pesoDeclarado)};\n';
    }

    return '- Classif. $classificacao (Port. 63/09 DENATRAN);\n' +
        '- $pbtcLabel: ${Numbers.getPesoFormatado(pbtcPermitido + tolerancia)}$obsTolerancia;\n' +
        '$obsTaraCarga' +
        '$balancaAfericao' +
        '$obsCarga' +
        '$obsEmbarcador' +
        '$obsPlacas' +
        '- $amparoLegal;\n' +
        '- Retido para transbordo.';
  }
}
