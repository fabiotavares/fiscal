// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsuarioModel _$UsuarioModelFromJson(Map<String, dynamic> json) {
  return UsuarioModel(
    email: json['email'] as String,
    apelido: json['apelido'] as String,
    imgAvatar: json['imgAvatar'] as String,
    token: json['token'] as String,
  );
}

Map<String, dynamic> _$UsuarioModelToJson(UsuarioModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'apelido': instance.apelido,
      'imgAvatar': instance.imgAvatar,
      'token': instance.token,
    };
