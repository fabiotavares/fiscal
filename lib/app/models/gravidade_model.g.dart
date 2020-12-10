// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gravidade_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GravidadeModel _$GravidadeModelFromJson(Map<String, dynamic> json) {
  return GravidadeModel(
    nivel: json['gravidade'] as String,
    valor: (json['valor'] as num)?.toDouble(),
    pontos: json['pontos'] as int,
  );
}

Map<String, dynamic> _$GravidadeModelToJson(GravidadeModel instance) => <String, dynamic>{
      'gravidade': instance.nivel,
      'valor': instance.valor,
      'pontos': instance.pontos,
    };
