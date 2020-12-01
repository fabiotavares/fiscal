// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'peso_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $PesoController = BindInject(
  (i) => PesoController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PesoController on _PesoControllerBase, Store {
  final _$veiculoModelAtom = Atom(name: '_PesoControllerBase.veiculoModel');

  @override
  VeiculoPesoModel get veiculoModel {
    _$veiculoModelAtom.reportRead();
    return super.veiculoModel;
  }

  @override
  set veiculoModel(VeiculoPesoModel value) {
    _$veiculoModelAtom.reportWrite(value, super.veiculoModel, () {
      super.veiculoModel = value;
    });
  }

  final _$valuePesoPorComprimentoAtom =
      Atom(name: '_PesoControllerBase.valuePesoPorComprimento');

  @override
  double get valuePesoPorComprimento {
    _$valuePesoPorComprimentoAtom.reportRead();
    return super.valuePesoPorComprimento;
  }

  @override
  set valuePesoPorComprimento(double value) {
    _$valuePesoPorComprimentoAtom
        .reportWrite(value, super.valuePesoPorComprimento, () {
      super.valuePesoPorComprimento = value;
    });
  }

  final _$groupPesoPorComprimentoAtom =
      Atom(name: '_PesoControllerBase.groupPesoPorComprimento');

  @override
  int get groupPesoPorComprimento {
    _$groupPesoPorComprimentoAtom.reportRead();
    return super.groupPesoPorComprimento;
  }

  @override
  set groupPesoPorComprimento(int value) {
    _$groupPesoPorComprimentoAtom
        .reportWrite(value, super.groupPesoPorComprimento, () {
      super.groupPesoPorComprimento = value;
    });
  }

  final _$opcaoNotaFiscalAtom =
      Atom(name: '_PesoControllerBase.opcaoNotaFiscal');

  @override
  int get opcaoNotaFiscal {
    _$opcaoNotaFiscalAtom.reportRead();
    return super.opcaoNotaFiscal;
  }

  @override
  set opcaoNotaFiscal(int value) {
    _$opcaoNotaFiscalAtom.reportWrite(value, super.opcaoNotaFiscal, () {
      super.opcaoNotaFiscal = value;
    });
  }

  final _$opcaoBalancaAtom = Atom(name: '_PesoControllerBase.opcaoBalanca');

  @override
  int get opcaoBalanca {
    _$opcaoBalancaAtom.reportRead();
    return super.opcaoBalanca;
  }

  @override
  set opcaoBalanca(int value) {
    _$opcaoBalancaAtom.reportWrite(value, super.opcaoBalanca, () {
      super.opcaoBalanca = value;
    });
  }

  final _$pageControllerAtom = Atom(name: '_PesoControllerBase.pageController');

  @override
  PageController get pageController {
    _$pageControllerAtom.reportRead();
    return super.pageController;
  }

  @override
  set pageController(PageController value) {
    _$pageControllerAtom.reportWrite(value, super.pageController, () {
      super.pageController = value;
    });
  }

  final _$selectedTabAtom = Atom(name: '_PesoControllerBase.selectedTab');

  @override
  int get selectedTab {
    _$selectedTabAtom.reportRead();
    return super.selectedTab;
  }

  @override
  set selectedTab(int value) {
    _$selectedTabAtom.reportWrite(value, super.selectedTab, () {
      super.selectedTab = value;
    });
  }

  final _$_PesoControllerBaseActionController =
      ActionController(name: '_PesoControllerBase');

  @override
  void setVeiculoModel(VeiculoPesoModel value) {
    final _$actionInfo = _$_PesoControllerBaseActionController.startAction(
        name: '_PesoControllerBase.setVeiculoModel');
    try {
      return super.setVeiculoModel(value);
    } finally {
      _$_PesoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changePesoPorComprimento(int value) {
    final _$actionInfo = _$_PesoControllerBaseActionController.startAction(
        name: '_PesoControllerBase.changePesoPorComprimento');
    try {
      return super.changePesoPorComprimento(value);
    } finally {
      _$_PesoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeNotaFiscal(int value) {
    final _$actionInfo = _$_PesoControllerBaseActionController.startAction(
        name: '_PesoControllerBase.changeNotaFiscal');
    try {
      return super.changeNotaFiscal(value);
    } finally {
      _$_PesoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeBalanca(int value) {
    final _$actionInfo = _$_PesoControllerBaseActionController.startAction(
        name: '_PesoControllerBase.changeBalanca');
    try {
      return super.changeBalanca(value);
    } finally {
      _$_PesoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeSelectedTab(int index) {
    final _$actionInfo = _$_PesoControllerBaseActionController.startAction(
        name: '_PesoControllerBase.changeSelectedTab');
    try {
      return super.changeSelectedTab(index);
    } finally {
      _$_PesoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeSelectedPage(int index) {
    final _$actionInfo = _$_PesoControllerBaseActionController.startAction(
        name: '_PesoControllerBase.changeSelectedPage');
    try {
      return super.changeSelectedPage(index);
    } finally {
      _$_PesoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
veiculoModel: ${veiculoModel},
valuePesoPorComprimento: ${valuePesoPorComprimento},
groupPesoPorComprimento: ${groupPesoPorComprimento},
opcaoNotaFiscal: ${opcaoNotaFiscal},
opcaoBalanca: ${opcaoBalanca},
pageController: ${pageController},
selectedTab: ${selectedTab}
    ''';
  }
}
