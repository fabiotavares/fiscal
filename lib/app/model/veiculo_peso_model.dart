class VeiculoPesoModel {
  final String id;
  final String tipo;
  final String limiteEixos;
  final String comprimentoMaximo;
  final String limiteComprimento1;
  final String limiteComprimento2;
  final double valorComprimento1;
  final double valorComprimento2;
  final bool precisaAet;
  final String obs;

  VeiculoPesoModel({
    this.id,
    this.tipo,
    this.limiteEixos,
    this.comprimentoMaximo,
    this.limiteComprimento1,
    this.limiteComprimento2,
    this.valorComprimento1,
    this.valorComprimento2,
    this.precisaAet,
    this.obs,
  });
}
