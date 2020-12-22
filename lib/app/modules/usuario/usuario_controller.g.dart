// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $UsuarioController = BindInject(
  (i) => UsuarioController(i<UsuarioService>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UsuarioController on _UsuarioControllerBase, Store {
  final _$urlValidaAtom = Atom(name: '_UsuarioControllerBase.urlValida');

  @override
  bool get urlValida {
    _$urlValidaAtom.reportRead();
    return super.urlValida;
  }

  @override
  set urlValida(bool value) {
    _$urlValidaAtom.reportWrite(value, super.urlValida, () {
      super.urlValida = value;
    });
  }

  final _$atualizarProfileAsyncAction =
      AsyncAction('_UsuarioControllerBase.atualizarProfile');

  @override
  Future<void> atualizarProfile() {
    return _$atualizarProfileAsyncAction.run(() => super.atualizarProfile());
  }

  final _$_UsuarioControllerBaseActionController =
      ActionController(name: '_UsuarioControllerBase');

  @override
  void setUrlValida(bool value) {
    final _$actionInfo = _$_UsuarioControllerBaseActionController.startAction(
        name: '_UsuarioControllerBase.setUrlValida');
    try {
      return super.setUrlValida(value);
    } finally {
      _$_UsuarioControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
urlValida: ${urlValida}
    ''';
  }
}
