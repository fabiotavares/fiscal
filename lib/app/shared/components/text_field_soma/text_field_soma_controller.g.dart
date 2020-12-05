// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_field_soma_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $TextFieldSomaController = BindInject(
  (i) => TextFieldSomaController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TextFieldSomaController on _TextFieldSomaControllerBase, Store {
  final _$valoresSomaAtom =
      Atom(name: '_TextFieldSomaControllerBase.valoresSoma');

  @override
  List<double> get valoresSoma {
    _$valoresSomaAtom.reportRead();
    return super.valoresSoma;
  }

  @override
  set valoresSoma(List<double> value) {
    _$valoresSomaAtom.reportWrite(value, super.valoresSoma, () {
      super.valoresSoma = value;
    });
  }

  final _$contaMontadaAtom =
      Atom(name: '_TextFieldSomaControllerBase.contaMontada');

  @override
  String get contaMontada {
    _$contaMontadaAtom.reportRead();
    return super.contaMontada;
  }

  @override
  set contaMontada(String value) {
    _$contaMontadaAtom.reportWrite(value, super.contaMontada, () {
      super.contaMontada = value;
    });
  }

  final _$_TextFieldSomaControllerBaseActionController =
      ActionController(name: '_TextFieldSomaControllerBase');

  @override
  void remove(TextEditingController controller) {
    final _$actionInfo = _$_TextFieldSomaControllerBaseActionController
        .startAction(name: '_TextFieldSomaControllerBase.remove');
    try {
      return super.remove(controller);
    } finally {
      _$_TextFieldSomaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void add(TextEditingController controller, double value) {
    final _$actionInfo = _$_TextFieldSomaControllerBaseActionController
        .startAction(name: '_TextFieldSomaControllerBase.add');
    try {
      return super.add(controller, value);
    } finally {
      _$_TextFieldSomaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void atualizaTotalSoma(TextEditingController controller) {
    final _$actionInfo = _$_TextFieldSomaControllerBaseActionController
        .startAction(name: '_TextFieldSomaControllerBase.atualizaTotalSoma');
    try {
      return super.atualizaTotalSoma(controller);
    } finally {
      _$_TextFieldSomaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
valoresSoma: ${valoresSoma},
contaMontada: ${contaMontada}
    ''';
  }
}
