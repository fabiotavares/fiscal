class SugestaoModel {
  String id;
  final String titulo;
  final String corpo;

  SugestaoModel({
    this.id,
    this.titulo,
    this.corpo,
  });

  factory SugestaoModel.fromMap(Map<String, dynamic> map) {
    return SugestaoModel(
      // id: map['id'],
      titulo: map['titulo'],
      corpo: map['corpo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'titulo': titulo,
      'corpo': corpo,
    };
  }
}
