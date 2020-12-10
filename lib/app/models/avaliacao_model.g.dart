// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avaliacao_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvaliacaoModel _$AvaliacaoModelFromJson(Map<String, dynamic> json) {
  return AvaliacaoModel(
    id: json['id'] as String,
    usuario: json['usuario'] as String,
    auto: json['auto'] as String,
    nota: json['nota'] as int,
    comentario: json['comentario'] as String,
  );
}

Map<String, dynamic> _$AvaliacaoModelToJson(AvaliacaoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'usuario': instance.usuario,
      'auto': instance.auto,
      'nota': instance.nota,
      'comentario': instance.comentario,
    };
