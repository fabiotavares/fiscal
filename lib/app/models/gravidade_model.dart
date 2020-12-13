import 'package:fiscal/app/shared/utils/constants.dart';

class GravidadeModel {
  String id;
  final String nivel;
  final int pontuacao;
  final double valor;

  GravidadeModel({
    this.id,
    this.nivel,
    this.pontuacao,
    this.valor,
  });

  GravidadeModel.leve({this.valor = VALOR_INFRACAO_LEVE})
      : id = 'leve',
        nivel = 'Leve',
        pontuacao = 3;

  GravidadeModel.media({this.valor = VALOR_INFRACAO_MEDIA})
      : id = 'media',
        nivel = 'Média',
        pontuacao = 4;

  GravidadeModel.grave({this.valor = VALOR_INFRACAO_GRAVE})
      : id = 'grave',
        nivel = 'Grave',
        pontuacao = 5;

  GravidadeModel.gravissima({this.valor = VALOR_INFRACAO_GRAVISSIMA})
      : id = 'gravissima',
        nivel = 'Gravíssima',
        pontuacao = 7;

  factory GravidadeModel.fromJson(Map<String, dynamic> map) {
    return GravidadeModel(
      nivel: map['nivel'] as String,
      pontuacao: int.tryParse(map['pontuacao']) ?? 0,
      valor: double.tryParse(map['valor']) ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nivel': nivel,
      'pontuacao': pontuacao,
      'valor': valor,
    };
  }

  factory GravidadeModel.fromId(String id) {
    //todo: pendente... providenciar uma forma alternativa
    switch (id) {
      case 'media':
        return GravidadeModel.media();
        break;
      case 'grave':
        return GravidadeModel.grave();
        break;
      case 'gravissima':
        return GravidadeModel.gravissima();
        break;
      default:
        return GravidadeModel.leve();
    }
  }
}
