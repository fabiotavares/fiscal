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

  factory AvaliacaoModel.fromJson(Map<String, dynamic> map) {
    return AvaliacaoModel(
      usuario: map['usuario'] as String,
      auto: map['auto'] as String,
      nota: int.tryParse(map['nota']) ?? 0,
      comentario: map['comentario'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'usuario': usuario,
      'auto': auto,
      'nota': nota,
      'comentario': comentario,
    };
  }
}
