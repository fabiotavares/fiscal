import 'dart:math';

import 'package:fiscal/app/models/gravidade_model.dart';
import 'package:fiscal/app/models/sugestao_model.dart';
import 'package:fiscal/app/shared/utils/numbers.dart';
import 'package:flutter/material.dart';

enum ResponsavelInfracao {
  condutor,
  proprietario,
  transportador,
  embarcador,
  embarcador_transportador,
}

enum TipoFiscalizacaoPeso {
  balanca,
  nota_fiscal,
}

enum OpcaoNotaFiscal {
  nao_possui,
  varios_remetentes,
  unico_remetente,
}

class AutoModel {
  String usuario;
  String id;
  String titulo;
  String subtitulo;
  String codigo;
  String artigo;
  String amparo;
  String medidaAdm;
  ResponsavelInfracao responsavel;
  GravidadeModel gravidade;
  double valorAgravado;
  String orientacoes;
  List<SugestaoModel> sugestoes;
  DateTime ultimaEdicao;
  bool compartilhado;

  AutoModel({
    this.usuario,
    this.id,
    this.titulo,
    this.subtitulo,
    this.codigo,
    this.artigo,
    this.amparo,
    this.medidaAdm,
    this.responsavel,
    this.gravidade,
    this.valorAgravado,
    this.orientacoes,
    this.sugestoes,
    this.ultimaEdicao,
    this.compartilhado,
  });

  factory AutoModel.fromJson(Map<String, dynamic> map) {
    return AutoModel(
      usuario: map['usuario'] as String,
      titulo: map['titulo'] as String,
      subtitulo: map['subtitulo'] as String,
      codigo: map['codigo'] as String,
      artigo: map['artigo'] as String,
      amparo: map['amparo'] as String,
      medidaAdm: map['medida_adm'] as String,
      responsavel: getResponsavelModel(map['responsavel']),
      gravidade: GravidadeModel.fromId(map['gravidade']),
      valorAgravado: double.tryParse(map['valor_agravado']) ?? 0.0,
      orientacoes: map['orientacoes'] as String,
      ultimaEdicao: DateTime.tryParse(map['ultima_edicao']),
      compartilhado: map['compartilado'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'usuario': usuario,
      'titulo': titulo,
      'subtitulo': subtitulo,
      'codigo': codigo,
      'artigo': artigo,
      'amparo': amparo,
      'medida_adm': medidaAdm,
      'responsavel': getResponsavelLabel(),
      'gravidade': gravidade.id,
      'valor_agravado': valorAgravado,
      'orientacoes': orientacoes,
      'ultima_edicao': ultimaEdicao?.toIso8601String(),
      'compartilhado': compartilhado,
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

  Widget getAutoWidget() {
    // retorna um widget para apresentação dos dados do auto
    return Container();
  }

  double get valor {
    // retorna o valor correto do auto
    double val1 = valorAgravado ?? 0.0;
    double val2 = gravidade.valor ?? 0.0;
    return max(val1, val2);
  }

  String get valorFormatado {
    // retorna o valor correto do auto
    return Numbers.getMoneyFormatado(valor);
  }
}
