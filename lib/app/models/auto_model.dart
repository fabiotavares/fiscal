import 'package:fiscal/app/models/sugestao_model.dart';
import 'package:fiscal/app/models/infracao_model.dart';
import 'package:flutter/material.dart';

class AutoModel {
  String id;
  String usuario;
  String titulo;
  InfracaoModel infracao;
  String orientacoes;
  List<SugestaoModel> sugestoes;
  DateTime ultimaEdicao;
  bool compartilhado;

  AutoModel({
    this.id,
    this.usuario,
    this.titulo,
    this.infracao,
    this.orientacoes,
    this.sugestoes,
    this.ultimaEdicao,
    this.compartilhado,
  });

  factory AutoModel.fromJson(Map<String, dynamic> map) {
    return AutoModel(
      usuario: map['usuario'] as String,
      titulo: map['titulo'] as String,
      infracao: InfracaoModel(id: map['infracao']),
      orientacoes: map['orientacoes'] as String,
      ultimaEdicao: DateTime.tryParse(map['ultima_edicao']),
      compartilhado: map['compartilado'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'usuario': usuario,
      'titulo': titulo,
      'infracao': infracao.id, // vou salvar no BD apenas o id da infração
      'orientacoes': orientacoes,
      'ultima_edicao': ultimaEdicao?.toIso8601String(),
      'compartilhado': compartilhado,
    };
  }

  Widget getAutoWidget() {
    // retorna um widget para apresentação dos dados do auto
    return Container();
  }
}
