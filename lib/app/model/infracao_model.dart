import 'package:flutter/material.dart';

enum ResponsavelInfracao {
  condutor,
  proprietario,
  transportador,
  embarcador,
  embarcador_transportador,
}

enum GravidadeInfracao {
  leve,
  media,
  grave,
  gravissima,
}

enum TipoFiscalizacaoPeso {
  balanca,
  nota_fiscal,
}

class InfracaoModel {
  String codigo;
  String artigoCtb;
  String amparoLegal;
  String observacaoAuto;
  String medidaAdministrativa;
  ResponsavelInfracao responsavel;
  double valor;
  String observacoes;
  GravidadeInfracao gravidade;
  String placasTracionados;

  InfracaoModel({
    this.codigo,
    this.artigoCtb,
    this.amparoLegal,
    this.observacaoAuto,
    this.medidaAdministrativa,
    this.responsavel,
    this.valor,
    this.observacoes,
    this.gravidade,
    this.placasTracionados,
  });

  String getResponsavel() {
    switch (responsavel.index) {
      case 0:
        return 'Condutor';
        break;
      case 1:
        return 'Proprietário';
        break;
      case 2:
        return 'Transportador';
        break;
      case 3:
        return 'Embarcador';
        break;
      case 4:
        return 'Embarcador/Transportador';
        break;
      default:
        return null;
    }
  }

  String getGravidade() {
    switch (gravidade.index) {
      case 0:
        return 'Leve';
        break;
      case 1:
        return 'Média';
        break;
      case 2:
        return 'Grave';
        break;
      case 3:
        return 'Gravíssima';
        break;
      default:
        return null;
    }
  }

  Widget getInfracaoWidget() {
    // retorna uma representação pra ser exibida na tela
    return Container();
  }

  List<String> get sugestoesAuto {
    return ['Em Breve'];
  }
}
