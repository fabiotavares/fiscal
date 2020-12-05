import 'package:fiscal/app/model/gravidade_infracao_model.dart';
import 'package:fiscal/app/model/sugestao_auto_model.dart';
import 'package:flutter/material.dart';

enum ResponsavelInfracao {
  condutor,
  proprietario,
  transportador,
  embarcador,
  embarcador_transportador,
}

enum TipoFiscalizacaoPeso {
  balanca,
  nota_fiscal,
}

class InfracaoModel {
  String codigo;
  String artigoCtb;
  GravidadeInfracaoModel gravidade;
  String medidaAdministrativa;
  String amparoLegal;
  ResponsavelInfracao responsavel;
  List<SugestaoAutoModel> sugestoes;
  // String observacoes;

  InfracaoModel({
    this.codigo,
    this.artigoCtb,
    this.amparoLegal,
    this.sugestoes,
    this.medidaAdministrativa,
    this.responsavel,
    this.gravidade,
    // this.observacoes,
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

  Widget getInfracaoView() {
    // retorna uma representação pra ser exibida na tela
    return Container();
  }
}
