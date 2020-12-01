// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'infracoes_peso_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $InfracoesPesoController = BindInject(
  (i) => InfracoesPesoController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$InfracoesPesoController on _InfracoesPesoControllerBase, Store {
  final _$valueAtom = Atom(name: '_InfracoesPesoControllerBase.value');

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

  final _$_InfracoesPesoControllerBaseActionController =
      ActionController(name: '_InfracoesPesoControllerBase');

  @override
  void increment() {
    final _$actionInfo = _$_InfracoesPesoControllerBaseActionController
        .startAction(name: '_InfracoesPesoControllerBase.increment');
    try {
      return super.increment();
    } finally {
      _$_InfracoesPesoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
value: ${value}
    ''';
  }
}
