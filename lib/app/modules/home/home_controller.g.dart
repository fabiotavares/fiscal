// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $HomeController = BindInject(
  (i) => HomeController(
      i<GravidadeService>(), i<InfracaoService>(), i<AutoService>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$infracoesFutureAtom =
      Atom(name: '_HomeControllerBase.infracoesFuture');

  @override
  ObservableFuture<List<InfracaoModel>> get infracoesFuture {
    _$infracoesFutureAtom.reportRead();
    return super.infracoesFuture;
  }

  @override
  set infracoesFuture(ObservableFuture<List<InfracaoModel>> value) {
    _$infracoesFutureAtom.reportWrite(value, super.infracoesFuture, () {
      super.infracoesFuture = value;
    });
  }

  final _$autosUsuarioFutureAtom =
      Atom(name: '_HomeControllerBase.autosUsuarioFuture');

  @override
  ObservableFuture<List<AutoModel>> get autosUsuarioFuture {
    _$autosUsuarioFutureAtom.reportRead();
    return super.autosUsuarioFuture;
  }

  @override
  set autosUsuarioFuture(ObservableFuture<List<AutoModel>> value) {
    _$autosUsuarioFutureAtom.reportWrite(value, super.autosUsuarioFuture, () {
      super.autosUsuarioFuture = value;
    });
  }

  final _$autosCompartilhadosFutureAtom =
      Atom(name: '_HomeControllerBase.autosCompartilhadosFuture');

  @override
  ObservableFuture<List<AutoModel>> get autosCompartilhadosFuture {
    _$autosCompartilhadosFutureAtom.reportRead();
    return super.autosCompartilhadosFuture;
  }

  @override
  set autosCompartilhadosFuture(ObservableFuture<List<AutoModel>> value) {
    _$autosCompartilhadosFutureAtom
        .reportWrite(value, super.autosCompartilhadosFuture, () {
      super.autosCompartilhadosFuture = value;
    });
  }

  final _$buscarGravidadesAsyncAction =
      AsyncAction('_HomeControllerBase.buscarGravidades');

  @override
  Future buscarGravidades() {
    return _$buscarGravidadesAsyncAction.run(() => super.buscarGravidades());
  }

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  dynamic buscarInfracoes() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.buscarInfracoes');
    try {
      return super.buscarInfracoes();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic buscarAutosUsuario() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.buscarAutosUsuario');
    try {
      return super.buscarAutosUsuario();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic buscarAutosCompartilhados() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.buscarAutosCompartilhados');
    try {
      return super.buscarAutosCompartilhados();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
infracoesFuture: ${infracoesFuture},
autosUsuarioFuture: ${autosUsuarioFuture},
autosCompartilhadosFuture: ${autosCompartilhadosFuture}
    ''';
  }
}
