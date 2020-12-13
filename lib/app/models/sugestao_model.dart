class SugestaoModel {
  String id;
  final String titulo;
  final String corpo;

  SugestaoModel({
    this.id,
    this.titulo,
    this.corpo,
  });

  factory SugestaoModel.fromJson(Map<String, dynamic> map) {
    return SugestaoModel(
      titulo: map['titulo'] as String,
      corpo: map['corpo'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'corpo': corpo,
    };
  }
}
