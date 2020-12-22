import 'package:fiscal/app/models/auto_model.dart';
import 'package:fiscal/app/models/infracao_model.dart';
import 'package:fiscal/app/shared/components/text_with_copy_button.dart';
import 'package:fiscal/app/shared/utils/constants.dart';
import 'package:fiscal/app/shared/utils/numbers.dart';
import 'package:fiscal/app/models/gravidade_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TipoFiscalizacaoPeso {
  balanca,
  nota_fiscal,
}

enum OpcaoNotaFiscal {
  nao_possui,
  varios_remetentes,
  unico_remetente,
}

class AutoPesoModel extends AutoModel {
  final bool isCmt;
  TipoFiscalizacaoPeso tipo;
  double pesoPermitido;
  double pesoConstatado;
  double tara;
  double pesoDeclarado;
  String pbtcLabel;
  String classificacao;
  String carga;
  String afericaoInmetro;
  String afericaoValidade;
  String cnpjEmbarcador;
  String placasTracionados;

  AutoPesoModel({
    this.isCmt = false,
    @required this.tipo,
    @required this.pesoPermitido,
    @required this.pesoConstatado,
    this.tara,
    this.pesoDeclarado,
    this.pbtcLabel,
    this.classificacao,
    this.carga,
    this.afericaoInmetro,
    this.afericaoValidade,
    this.cnpjEmbarcador,
    this.placasTracionados,
  }) {
    // configure argumentos da super conforme o caso (cmt ou pbtc)
    super.infracao = InfracaoModel();
    super.infracao.medidaAdm = 'Retenção do veículo e transbordo de carga excedente';
    if (isCmt) {
      // é infração de excesso na cmt
      super.infracao.artigo = 'Art. 231 X';
      super.infracao.amparo = 'Res 210/211, 290, 803 CONTRAN';
      super.infracao.responsavel = ResponsavelInfracao.proprietario;

      // sobre gravidade
      if (_excessoVerificado > 1000.0) {
        super.infracao.gravidade = GravidadeModel.fromId('gravissima');
        final valor = super.infracao.gravidade.valor;
        super.infracao.valorAgravado = (_excessoVerificado / 500.0).ceil() * valor;
        super.infracao.codigo = '689-40';
      } else if (_excessoVerificado > 600.0) {
        super.infracao.gravidade = GravidadeModel.fromId('grave');
        super.infracao.codigo = '689-00';
      } else if (_excessoVerificado > 0.0) {
        super.infracao.gravidade = GravidadeModel.fromId('media');
        super.infracao.codigo = '688-20';
      }
      //
    } else {
      // é infração de excesso no pbtc
      super.infracao.codigo = '683-11';
      super.infracao.artigo = 'Art. 231 V';
      super.infracao.amparo = 'Res 210, 290, 803 CONTRAN';

      // sobre gravidade
      double fator;
      if (_excessoVerificado >= 5001.0) {
        fator = 53.20;
      } else if (_excessoVerificado >= 3001.0) {
        fator = 42.56;
      } else if (_excessoVerificado >= 1001.0) {
        fator = 31.92;
      } else if (_excessoVerificado >= 801.0) {
        fator = 21.28;
      } else if (_excessoVerificado >= 601.0) {
        fator = 10.64;
      } else {
        fator = 5.32;
      }
      // valor será a multa média acrescida do peso determinado a cada fração de 200 kg
      super.infracao.gravidade = GravidadeModel.fromId('media');
      final valor = super.infracao.gravidade.valor;
      super.infracao.valorAgravado = valor + (_excessoVerificado / 200.0).ceil() * fator;
    }
  }

  double get _excessoVerificado {
    return pesoConstatado - (pesoPermitido + _tolerancia);
  }

  double get _tolerancia {
    if (!isCmt && tipo == TipoFiscalizacaoPeso.balanca) {
      return pesoPermitido * TOLERANCIA_PBTC_BALANCA;
    }
    return 0.0;
  }

  String get _tipoFiscalizacao {
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
  Widget getAutoWidget() {
    // retorna uma representação gráfica da infração pra ser exibida na tela
    return Container(
      padding: EdgeInsets.only(top: 8.0),
      margin: isCmt ? EdgeInsets.only(bottom: 8.0) : null,
      width: ScreenUtil().screenWidth,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: isCmt && pesoPermitido == 0
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'CMT não informada',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            : _excessoVerificado <= 0.0
                ? Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isCmt ? 'Não há infração por excesso na CMT' : 'Não há infração por excesso no $pbtcLabel',
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
                              isCmt ? 'Infração por excesso na CMT' : 'Infração por excesso no $pbtcLabel',
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

    // sobre tolerância
    var obsTolerancia = 'Tolerância (não aplicável)';
    if (_tolerancia > 0.0) {
      obsTolerancia = 'Tolerância (${(TOLERANCIA_PBTC_BALANCA * 100.0).toStringAsFixed(0)}%)';
    }

    // caso de não haver excesso...
    if (_excessoVerificado <= 0.0) {
      if (isCmt) {
        return Text('- Fiscalização por ${_tipoFiscalizacao.toLowerCase()};\n' +
            '- CMT: ${Numbers.getPesoFormatado(pesoPermitido)};\n' +
            '- $pbtcLabel constatado: ${Numbers.getPesoFormatado(pesoConstatado)};\n' +
            '- Excesso verificado: ${Numbers.getPesoFormatado(_excessoVerificado)};\n' +
            '- ${super.infracao.amparo}.');
      } else {
        return Text('- Fiscalização por ${_tipoFiscalizacao.toLowerCase()};\n' +
            '- $pbtcLabel permitido: ${Numbers.getPesoFormatado(this.pesoPermitido)};\n' +
            '- $obsTolerancia: ${Numbers.getPesoFormatado(_tolerancia)};\n' +
            '- Total permitido: ${Numbers.getPesoFormatado(this.pesoPermitido + this._tolerancia)};\n' +
            '- $pbtcLabel constatado: ${Numbers.getPesoFormatado(this.pesoConstatado)};\n' +
            '- Excesso verificado: ${Numbers.getPesoFormatado(_excessoVerificado)};\n' +
            '- ${super.infracao.amparo}.');
      }
    }

    // sobre embarcador: mostra apenas se existir e não for auto de cmt
    var obsEmbarcador = '';
    if (!isCmt && cnpjEmbarcador.isNotEmpty) {
      obsEmbarcador = '- Embarcador: $cnpjEmbarcador';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWithCopyButton(
          title: 'Código: ${infracao.codigo}',
          toCopy: '${infracao.codigo}',
          backgoundColor: Colors.grey[200],
          margin: EdgeInsets.symmetric(vertical: 2),
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0, left: 9.0),
        ),
        Text('- CTB: ${infracao.artigo}'),
        Text('- Fiscalização por ${this._tipoFiscalizacao.toLowerCase()}'),
        if (!isCmt) Text('- $pbtcLabel permitido: ${Numbers.getPesoFormatado(this.pesoPermitido)}'),
        if (!isCmt) Text('- $obsTolerancia: ${Numbers.getPesoFormatado(this._tolerancia)}'),
        TextWithCopyButton(
          title: 'Total permitido: ${Numbers.getPesoFormatado(this.pesoPermitido + this._tolerancia)}',
          toCopy: '${this.pesoPermitido + this._tolerancia}',
          backgoundColor: Colors.grey[200],
          margin: EdgeInsets.symmetric(vertical: 2),
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0, left: 9.0),
        ),
        TextWithCopyButton(
          title: '$pbtcLabel constatado: ${Numbers.getPesoFormatado(pesoConstatado)}',
          toCopy: '$pesoConstatado',
          backgoundColor: Colors.grey[200],
          margin: EdgeInsets.symmetric(vertical: 2),
          padding: EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0, left: 9.0),
        ),
        Text('- Excesso verificado: ${Numbers.getPesoFormatado(_excessoVerificado)}'),
        Text('- Gravidade: ${super.infracao.gravidade.nivel}'),
        Text('- Pontos perdidos: ${super.infracao.gravidade.pontuacao}'),
        Text('- Valor: ${super.infracao.valorFormatado}'),
        Text('- Responsável: ${super.infracao.getResponsavelLabel()}'),
        if (obsEmbarcador.isNotEmpty) Text('$obsEmbarcador'),
        Text('- ${super.infracao.amparo}'),
        Text('- Medida administrativa: ${super.infracao.medidaAdm}'),
      ],
    );
  }

  String getSugestao() {
    // sobre tolerância
    var obsTolerancia = '';
    if (_tolerancia > 0.0) {
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
    if (!isCmt && cnpjEmbarcador.isNotEmpty) {
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

    var obsPermitido = '';
    if (isCmt) {
      obsPermitido = '- CMT: ${Numbers.getPesoFormatado(pesoPermitido)} (plac. fabricante);\n';
    } else {
      obsPermitido = '- $pbtcLabel: ${Numbers.getPesoFormatado(pesoPermitido + _tolerancia)}$obsTolerancia;\n';
    }

    return '- Classif. $classificacao (Port. 63/09 DENATRAN);\n' +
        '$obsPermitido' +
        '$obsTaraCarga' +
        '$balancaAfericao' +
        '$obsCarga' +
        '$obsEmbarcador' +
        '$obsPlacas' +
        '- ${infracao.amparo};\n' +
        '- Retido para transbordo.';
  }
}
