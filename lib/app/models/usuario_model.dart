class UsuarioModel {
  final String email;
  final String nome;
  final String avatar;
  final String token;

  UsuarioModel({
    this.email,
    this.nome,
    this.avatar,
    this.token,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> map) {
    return UsuarioModel(
      email: map['email'] as String,
      nome: map['apelido'] as String,
      avatar: map['avatar'] as String,
      token: map['token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'apelido': nome,
      'avatar': avatar,
      'token': token,
    };
  }

  Map<String, dynamic> toJsonFull() {
    // mapeia incluindo todos os campos (id) para armazenamento local apenas
    return {
      'email': email,
      'apelido': nome,
      'avatar': avatar,
      'token': token,
    };
  }
}
