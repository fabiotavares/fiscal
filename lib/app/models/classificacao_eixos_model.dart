import 'package:firebase_storage/firebase_storage.dart';

class ClassificacaoEixosModel {
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
  String url;

  ClassificacaoEixosModel({
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

  String get pbtc {
    if (tipo == 'Caminhão') {
      return 'PBT';
    }
    return 'PBTC';
  }

  String get idTrim {
    return '${this.id.replaceFirst('-', '').toLowerCase()}.png';
  }

  Future<void> setUrl() async {
    url = await FirebaseStorage.instance.ref('eixos/$idTrim').getDownloadURL();
  }
}
