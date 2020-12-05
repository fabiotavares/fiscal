import 'package:fiscal/app/shared/utils/constants.dart';
import 'package:fiscal/app/shared/utils/numbers.dart';

class GravidadeInfracaoModel {
  String gravidade;
  double valor;
  int pontos;

  GravidadeInfracaoModel.leve({this.valor = VALOR_INFRACAO_LEVE})
      : gravidade = 'Leve',
        pontos = 3;

  GravidadeInfracaoModel.media({this.valor = VALOR_INFRACAO_MEDIA})
      : gravidade = 'Média',
        pontos = 4;

  GravidadeInfracaoModel.grave({this.valor = VALOR_INFRACAO_GRAVE})
      : gravidade = 'Grave',
        pontos = 5;

  GravidadeInfracaoModel.gravissima({this.valor = VALOR_INFRACAO_GRAVISSIMA})
      : gravidade = 'Gravíssima',
        pontos = 7;

  String getValorFormatado() {
    return Numbers.getMoneyFormatado(valor);
  }
}
