import 'package:json_annotation/json_annotation.dart';

part 'avaliacao_model.g.dart';

@JsonSerializable()
class AvaliacaoModel {
  final String id;
  final String usuario;
  final String auto;
  final int nota;
  final String comentario;

  AvaliacaoModel({
    this.id,
    this.usuario,
    this.auto,
    this.nota,
    this.comentario,
  });

  factory AvaliacaoModel.fromJson(Map<String, dynamic> json) => _$AvaliacaoModelFromJson(json);
  Map<String, dynamic> toJson() => _$AvaliacaoModelToJson(this);
}
