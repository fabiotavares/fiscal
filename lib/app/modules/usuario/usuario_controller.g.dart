// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $UsuarioController = BindInject(
  (i) => UsuarioController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UsuarioController on _UsuarioControllerBase, Store {
  final _$valueAtom = Atom(name: '_UsuarioControllerBase.value');

  @override
  int get value {
    _$valueAtom.reportRead();
    return super.value;
  }

  @override
  set value(int value) {
    _$valueAtom.reportWrite(value, super.value, () {
      super.value = value;
    });
  }

  final _$_UsuarioControllerBaseActionController =
      ActionController(name: '_UsuarioControllerBase');

  @override
  void increment() {
    final _$actionInfo = _$_UsuarioControllerBaseActionController.startAction(
        name: '_UsuarioControllerBase.increment');
    try {
      return super.increment();
    } finally {
      _$_UsuarioControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
value: ${value}
    ''';
  }
}
