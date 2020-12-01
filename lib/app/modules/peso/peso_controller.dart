import 'package:fiscal/app/model/veiculo_peso_model.dart';
import 'package:fiscal/app/components/text_field_soma/text_field_soma_controller.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'peso_controller.g.dart';

@Injectable()
class PesoController = _PesoControllerBase with _$PesoController;

abstract class _PesoControllerBase with Store {
  TextEditingController limiteTecnicoController = TextEditingController();
  TextEditingController taraController = TextEditingController();
  TextEditingController cmtController = TextEditingController();
  TextEditingController placasTracionadosController = TextEditingController();
  TextEditingController tipoCargaController = TextEditingController();
  TextEditingController cnpjRemetenteController = TextEditingController();
  TextEditingController inmetroController = TextEditingController();
  TextEditingController validadeAfericaoController = TextEditingController();
  TextEditingController pesoDeclaradoController = TextEditingController();
  TextEditingController pesoAferidoController = TextEditingController();

  // atributos necessários para os componentes de somatório
  TextFieldSomaController limiteTecnico = TextFieldSomaController();
  TextFieldSomaController tara = TextFieldSomaController();
  TextFieldSomaController pesoDeclarado = TextFieldSomaController();

  @observable
  VeiculoPesoModel veiculoModel;

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
  void setVeiculoModel(VeiculoPesoModel value) {
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
