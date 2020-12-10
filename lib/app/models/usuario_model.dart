import 'package:json_annotation/json_annotation.dart';

part 'usuario_model.g.dart';

@JsonSerializable()
class UsuarioModel {
  final String email;
  final String apelido;
  final String imgAvatar;
  final String token;

  UsuarioModel({
    this.email,
    this.apelido,
    this.imgAvatar,
    this.token,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => _$UsuarioModelFromJson(json);
  Map<String, dynamic> toJson() => _$UsuarioModelToJson(this);
}
