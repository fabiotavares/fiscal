// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuracoes_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $ConfiguracoesController = BindInject(
  (i) => ConfiguracoesController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConfiguracoesController on _ConfiguracoesControllerBase, Store {
  final _$filtroSelecionadoAtom =
      Atom(name: '_ConfiguracoesControllerBase.filtroSelecionado');

  @override
  String get filtroSelecionado {
    _$filtroSelecionadoAtom.reportRead();
    return super.filtroSelecionado;
  }

  @override
  set filtroSelecionado(String value) {
    _$filtroSelecionadoAtom.reportWrite(value, super.filtroSelecionado, () {
      super.filtroSelecionado = value;
    });
  }

  final _$configuracoesFutureAtom =
      Atom(name: '_ConfiguracoesControllerBase.configuracoesFuture');

  @override
  ObservableFuture<List<VeiculoPesoModel>> get configuracoesFuture {
    _$configuracoesFutureAtom.reportRead();
    return super.configuracoesFuture;
  }

  @override
  set configuracoesFuture(ObservableFuture<List<VeiculoPesoModel>> value) {
    _$configuracoesFutureAtom.reportWrite(value, super.configuracoesFuture, () {
      super.configuracoesFuture = value;
    });
  }

  final _$initPageAsyncAction =
      AsyncAction('_ConfiguracoesControllerBase.initPage');

  @override
  Future<void> initPage() {
    return _$initPageAsyncAction.run(() => super.initPage());
  }

  final _$_ConfiguracoesControllerBaseActionController =
      ActionController(name: '_ConfiguracoesControllerBase');

  @override
  void changeFiltroSelecionado(String value) {
    final _$actionInfo =
        _$_ConfiguracoesControllerBaseActionController.startAction(
            name: '_ConfiguracoesControllerBase.changeFiltroSelecionado');
    try {
      return super.changeFiltroSelecionado(value);
    } finally {
      _$_ConfiguracoesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void buscarConfiguracoes() {
    final _$actionInfo = _$_ConfiguracoesControllerBaseActionController
        .startAction(name: '_ConfiguracoesControllerBase.buscarConfiguracoes');
    try {
      return super.buscarConfiguracoes();
    } finally {
      _$_ConfiguracoesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
filtroSelecionado: ${filtroSelecionado},
configuracoesFuture: ${configuracoesFuture}
    ''';
  }
}
