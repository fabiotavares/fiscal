import 'package:fiscal/app/shared/utils/constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gravidade_model.g.dart';

@JsonSerializable()
class GravidadeModel {
  final String nivel;
  final int pontos;
  final double valor;

  GravidadeModel({
    this.nivel,
    this.valor,
    this.pontos,
  });

  GravidadeModel.leve({this.valor = VALOR_INFRACAO_LEVE})
      : nivel = 'Leve',
        pontos = 3;

  GravidadeModel.media({this.valor = VALOR_INFRACAO_MEDIA})
      : nivel = 'Média',
        pontos = 4;

  GravidadeModel.grave({this.valor = VALOR_INFRACAO_GRAVE})
      : nivel = 'Grave',
        pontos = 5;

  GravidadeModel.gravissima({this.valor = VALOR_INFRACAO_GRAVISSIMA})
      : nivel = 'Gravíssima',
        pontos = 7;

  factory GravidadeModel.fromJson(Map<String, dynamic> json) => _$GravidadeModelFromJson(json);
  Map<String, dynamic> toJson() => _$GravidadeModelToJson(this);
}
