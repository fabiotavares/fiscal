import 'package:fiscal/app/models/classificacao_eixos_model.dart';
import 'package:fiscal/app/shared/components/text_field_soma/text_field_soma_controller.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'peso_controller.g.dart';

@Injectable()
class PesoController = _PesoControllerBase with _$PesoController;

abstract class _PesoControllerBase with Store {
  var limiteTecnicoController = TextEditingController();
  var taraController = TextEditingController();
  var cmtController = TextEditingController();
  var placasTracionadosController = TextEditingController();
  var tipoCargaController = TextEditingController();
  var cnpjRemetenteController = TextEditingController();
  var inmetroController = TextEditingController();
  var validadeAfericaoController = TextEditingController();
  var pesoDeclaradoController = TextEditingController();
  var pesoAferidoController = TextEditingController();

  // atributos necessários para os componentes de somatório
  var limiteTecnicoSomaController = TextFieldSomaController();
  var taraSomaController = TextFieldSomaController();
  var cmtSomaController = TextFieldSomaController();
  var pesoDeclaradoSomaController = TextFieldSomaController();
  var pesoAferidoSomaController = TextFieldSomaController();

  @observable
  ClassificacaoEixosModel veiculoModel;

  @observable
  double valuePesoPorComprimento = 0.0;

  @observable
  int groupPesoPorComprimento = 0;

  @observable
  int opcaoNotaFiscal = 0;

  @observable
  int opcaoBalanca = 0;

  @observable
  PageController pageController = PageController(initialPage: 0);

  @observable
  int selectedTab = 0;

  @action
  void setVeiculoModel(ClassificacaoEixosModel value) {
    veiculoModel = value;
    changePesoPorComprimento(0);
  }

  @action
  void changePesoPorComprimento(int value) {
    groupPesoPorComprimento = value;
    // atualizar valor do pbtc legal
    valuePesoPorComprimento = (value == 0) ? veiculoModel?.valorComprimento1 : veiculoModel?.valorComprimento2 ?? 0.0;
  }

  @action
  void changeNotaFiscal(int value) {
    opcaoNotaFiscal = value;
  }

  @action
  void changeBalanca(int value) {
    opcaoBalanca = value;
  }

  @action
  void changeSelectedTab(int index) {
    selectedTab = index;
    pageController.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.ease);
  }

  @action
  void changeSelectedPage(int index) {
    selectedTab = index;
  }
}
