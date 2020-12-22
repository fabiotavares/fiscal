import 'dart:math';

import 'package:fiscal/app/shared/utils/numbers.dart';

import 'gravidade_model.dart';

enum ResponsavelInfracao {
  condutor,
  proprietario,
  transportador,
  embarcador,
  embarcador_transportador,
}

class InfracaoModel {
  String id;
  String artigo;
  String codigo;
  String descricao;
  String amparo;
  String medidaAdm;
  ResponsavelInfracao responsavel;
  GravidadeModel gravidade;
  double valorAgravado;

  InfracaoModel({
    this.id,
    this.artigo,
    this.codigo,
    this.descricao,
    this.amparo,
    this.medidaAdm,
    this.responsavel,
    this.gravidade,
    this.valorAgravado,
  });

  factory InfracaoModel.fromJson(Map<String, dynamic> map) {
    return InfracaoModel(
      artigo: map['artigo'] as String,
      codigo: map['codigo'] as String,
      descricao: map['descricao'] as String,
      amparo: map['amparo'] as String,
      medidaAdm: map['medida_adm'] as String,
      responsavel: getResponsavelModel(map['responsavel']),
      gravidade: GravidadeModel.fromId(map['gravidade']),
      valorAgravado: double.tryParse(map['valor_agravado']) ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'artigo': artigo,
      'codigo': codigo,
      'descricao': descricao,
      'amparo': amparo,
      'medida_adm': medidaAdm,
      'responsavel': getResponsavelLabel(),
      'gravidade': gravidade.id,
      'valor_agravado': valorAgravado,
    };
  }

  String getResponsavelLabel() {
    switch (responsavel.index) {
      case 0:
        return 'Condutor';
        break;
      case 1:
        return 'Proprietário';
        break;
      case 2:
        return 'Transportador';
        break;
      case 3:
        return 'Embarcador';
        break;
      case 4:
        return 'Embarcador/Transportador';
        break;
      default:
        return null;
    }
  }

  static ResponsavelInfracao getResponsavelModel(String value) {
    switch (value) {
      case 'Proprietário':
        return ResponsavelInfracao.proprietario;
        break;
      case 'Transportador':
        return ResponsavelInfracao.transportador;
        break;
      case 'Embarcador':
        return ResponsavelInfracao.embarcador;
        break;
      case 'Embarcador/Transportador':
        return ResponsavelInfracao.embarcador_transportador;
        break;
      default:
        return ResponsavelInfracao.condutor;
    }
  }

  double get valorReal {
    // retorna o valor correto do auto
    double val1 = valorAgravado ?? 0.0;
    double val2 = gravidade.valor ?? 0.0;
    return max(val1, val2);
  }

  String get valorFormatado {
    // retorna o valor correto do auto
    return Numbers.getMoneyFormatado(valorReal);
  }
}
