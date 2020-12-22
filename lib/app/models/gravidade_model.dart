import 'package:fiscal/app/services/gravidade_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class GravidadeModel {
  String id;
  final String nivel;
  final int pontuacao;
  final double valor;

  GravidadeModel({
    this.id,
    this.nivel,
    this.pontuacao,
    this.valor,
  });

  factory GravidadeModel.fromJson(Map<String, dynamic> map) {
    return GravidadeModel(
      nivel: map['nivel'] as String,
      pontuacao: map['pontuacao'] ?? 0,
      // pontuacao: int.tryParse(map['pontuacao']) ?? 0,
      valor: map['valor'] ?? 0.0,
      // valor: double.tryParse(map['valor']) ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nivel': nivel,
      'pontuacao': pontuacao,
      'valor': valor,
    };
  }

  factory GravidadeModel.fromId(String id) {
    //todo: pendente... providenciar uma forma alternativa
    switch (id) {
      case 'media':
        return Modular.get<GravidadeService>().media;
        break;
      case 'grave':
        return Modular.get<GravidadeService>().grave;
        break;
      case 'gravissima':
        return Modular.get<GravidadeService>().gravissima;
        break;
      default:
        return Modular.get<GravidadeService>().leve;
    }
  }
}
