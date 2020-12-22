import 'package:fiscal/app/models/auto_peso_model.dart';

class FiscalizacaoPesoModel {
  final String classificacao;
  final double pbtcLegal;
  final double pbtcTecnico;
  final double tara;
  final double cmt;
  final String placas;
  final String tipoCarga;
  final OpcaoNotaFiscal opcaoNotaFiscal;
  final String cnpj;
  final double pesoDeclarado;
  final double pesoAferido;
  final String afericaoInmetro;
  final String afericaoValidade;
  final String pbtcLabel;

  FiscalizacaoPesoModel({
    this.classificacao,
    this.pbtcLegal,
    this.pbtcTecnico,
    this.tara,
    this.cmt,
    this.placas,
    this.tipoCarga,
    this.opcaoNotaFiscal,
    this.cnpj,
    this.pesoDeclarado,
    this.pesoAferido,
    this.afericaoInmetro,
    this.afericaoValidade,
    this.pbtcLabel,
  });

  // @override
  // String toString() {
  //   return '''
  //   pbtcLegal: $pbtcLegal
  //   pbtcTecnico: $pbtcTecnico
  //   tara: $tara
  //   cmt: $cmt
  //   placas: $placas
  //   tipoCarga: $tipoCarga
  //   opcaoNotaFiscal: $opcaoNotaFiscal
  //   cnpj: $cnpj
  //   pesoDeclarado: $pesoDeclarado
  //   pesoAferido: $pesoAferido
  //   inmetro: $afericaoInmetro
  //   validadeAfericao: $afericaoValidade
  //   ''';
  // }
}
