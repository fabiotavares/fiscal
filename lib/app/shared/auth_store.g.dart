// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthStore on _AuthStoreBase, Store {
  final _$usuarioLogadoAtom = Atom(name: '_AuthStoreBase.usuarioLogado');

  @override
  UsuarioModel get usuarioLogado {
    _$usuarioLogadoAtom.reportRead();
    return super.usuarioLogado;
  }

  @override
  set usuarioLogado(UsuarioModel value) {
    _$usuarioLogadoAtom.reportWrite(value, super.usuarioLogado, () {
      super.usuarioLogado = value;
    });
  }

  final _$updateUsuarioLogadoAsyncAction =
      AsyncAction('_AuthStoreBase.updateUsuarioLogado');

  @override
  Future<void> updateUsuarioLogado() {
    return _$updateUsuarioLogadoAsyncAction
        .run(() => super.updateUsuarioLogado());
  }

  final _$loadUsuarioDispositivoAsyncAction =
      AsyncAction('_AuthStoreBase.loadUsuarioDispositivo');

  @override
  Future<void> loadUsuarioDispositivo() {
    return _$loadUsuarioDispositivoAsyncAction
        .run(() => super.loadUsuarioDispositivo());
  }

  final _$isProviderFacebookAsyncAction =
      AsyncAction('_AuthStoreBase.isProviderFacebook');

  @override
  Future<bool> isProviderFacebook() {
    return _$isProviderFacebookAsyncAction
        .run(() => super.isProviderFacebook());
  }

  final _$isProviderPasswordAsyncAction =
      AsyncAction('_AuthStoreBase.isProviderPassword');

  @override
  Future<bool> isProviderPassword() {
    return _$isProviderPasswordAsyncAction
        .run(() => super.isProviderPassword());
  }

  final _$logoutAsyncAction = AsyncAction('_AuthStoreBase.logout');

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  final _$_AuthStoreBaseActionController =
      ActionController(name: '_AuthStoreBase');

  @override
  bool isLogged() {
    final _$actionInfo = _$_AuthStoreBaseActionController.startAction(
        name: '_AuthStoreBase.isLogged');
    try {
      return super.isLogged();
    } finally {
      _$_AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
usuarioLogado: ${usuarioLogado}
    ''';
  }
}
