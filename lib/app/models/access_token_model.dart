class AccessTokenModel {
  // modelo para armazenar o token de autenticação do usuário
  String accessToken;

  AccessTokenModel({this.accessToken});

  factory AccessTokenModel.fromJson(Map<String, dynamic> map) {
    return AccessTokenModel(
      accessToken: map['access_token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
    };
  }
}
