class FacebookModel {
  String token;
  String email;
  String picture;

  FacebookModel({
    this.email,
    this.picture,
  });

  factory FacebookModel.fromJson(Map<String, dynamic> map) {
    return FacebookModel(
      email: map['email'] as String,
      picture: _pictureFromJson(map['picture']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'picture': picture,
    };
  }

  static String _pictureFromJson(jsonData) {
    return jsonData['data']['url'];
  }
}
