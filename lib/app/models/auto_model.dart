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

  factory AutoModel.fromMap(Map<String, dynamic> map) {
    return AutoModel(
      usuario: map['usuario'],
      // id: map['id'],
      titulo: map['titulo'],
      subtitulo: map['subtitulo'],
      codigo: map['codigo'],
      artigo: map['artigo'],
      amparo: map['amparo'],
      medidaAdm: map['medida_adm'],
      responsavel: map['responsavel'],
      gravidade: map['gravidade'],
      valorAgravado: map['valor_agravado'],
      orientacoes: map['orientacoes'],
      // sugestoes: map['sugestoes'],
      ultimaEdicao: map['ultima_edicao'],
      compartilhado: map['compartilado'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'usuario': usuario,
      // 'id': id,
      'titulo': titulo,
      'subtitulo': subtitulo,
      'codigo': codigo,
      'artigo': artigo,
      'amparo': amparo,
      'medida_adm': medidaAdm,
      'responsavel': getResponsavel(),
      'gravidade': gravidade.nivel,
      'valor_agravado': valorAgravado,
      'orientacoes': orientacoes,
      // 'sugestoes': sugestoes.map((s) => s.toMap()).toList(),
      'ultima_edicao': ultimaEdicao,
      'compartilhado': compartilhado,
    };
  }

  String getResponsavel() {
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
