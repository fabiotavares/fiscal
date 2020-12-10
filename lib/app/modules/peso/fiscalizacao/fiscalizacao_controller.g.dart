// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fiscalizacao_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $FiscalizacaoController = BindInject(
  (i) => FiscalizacaoController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FiscalizacaoController on _FiscalizacaoControllerBase, Store {
  final _$autosAtom = Atom(name: '_FiscalizacaoControllerBase.autos');

  @override
  List<AutoPesoModel> get autos {
    _$autosAtom.reportRead();
    return super.autos;
  }

  @override
  set autos(List<AutoPesoModel> value) {
    _$autosAtom.reportWrite(value, super.autos, () {
      super.autos = value;
    });
  }

  final _$_FiscalizacaoControllerBaseActionController =
      ActionController(name: '_FiscalizacaoControllerBase');

  @override
  void getAutos(FiscalizacaoPesoModel f) {
    final _$actionInfo = _$_FiscalizacaoControllerBaseActionController
        .startAction(name: '_FiscalizacaoControllerBase.getAutos');
    try {
      return super.getAutos(f);
    } finally {
      _$_FiscalizacaoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
autos: ${autos}
    ''';
  }
}
