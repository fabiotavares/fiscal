import 'package:fiscal/app/model/veiculo_peso_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'configuracoes_controller.g.dart';

@Injectable()
class ConfiguracoesController = _ConfiguracoesControllerBase with _$ConfiguracoesController;

abstract class _ConfiguracoesControllerBase with Store {
  final scrollController = ScrollController();

  @observable
  bool scrollToTopVisible = false;
  bool scrollToTopVisibleLock = false;

  @observable
  String filtroSelecionado = 'Todos';

  @observable
  ObservableFuture<List<VeiculoPesoModel>> configuracoesFuture;

  @action
  void changeFiltroSelecionado(String value) {
    filtroSelecionado = value;
    buscarConfiguracoes();
  }

  @action
  Future<void> initPage() async {
    scrollController.addListener(() {
      if (!scrollToTopVisible) {
        scrollToTopVisible = true;
        hideScrollToTopVisible();
      }
    });

    buscarConfiguracoes();
  }

  void hideScrollToTopVisible() {
    Future.delayed(Duration(seconds: 3)).then((_) {
      scrollToTopVisible = false;
    });
  }

  @action
  void buscarConfiguracoes() {
    try {
      configuracoesFuture = ObservableFuture(_criarListaConfiguracoes());
    } catch (e) {
      Get.snackbar('Erro', 'Erro ao buscar as configurações de veículos');
    }
  }

  Future<List<VeiculoPesoModel>> _criarListaConfiguracoes() {
    // gera a lista de configurações
    List<VeiculoPesoModel> configs = [];

    configs.add(VeiculoPesoModel(
      id: 'I-1',
      tipo: 'Caminhão',
      limiteEixos: '6 + 6 = 12',
      comprimentoMaximo: '14m',
      limiteComprimento1: '<=14m',
      limiteComprimento2: '',
      valorComprimento1: 12.0,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-2',
      tipo: 'Caminhão',
      limiteEixos: '6 + 10 = 16',
      comprimentoMaximo: '14m',
      limiteComprimento1: '<=14m',
      limiteComprimento2: '',
      valorComprimento1: 16.0,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-3',
      tipo: 'Caminhão',
      limiteEixos: '6 + 17 = 23',
      comprimentoMaximo: '14m',
      limiteComprimento1: '<=14m',
      limiteComprimento2: '',
      valorComprimento1: 23.0,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-4',
      tipo: 'Caminhão',
      limiteEixos: '6 + 13,5 = 19,5',
      comprimentoMaximo: '14m',
      limiteComprimento1: '<=14m',
      limiteComprimento2: '',
      valorComprimento1: 19.5,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-5',
      tipo: 'Caminhão',
      limiteEixos: '6 + 13,5 = 19,5',
      comprimentoMaximo: '14m',
      limiteComprimento1: '<=14m',
      limiteComprimento2: '',
      valorComprimento1: 19.5,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-6',
      tipo: 'Caminhão',
      limiteEixos: '12 + 17 = 29',
      comprimentoMaximo: '14m',
      limiteComprimento1: '<=14m',
      limiteComprimento2: '',
      valorComprimento1: 29.0,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-7',
      tipo: 'Caminhão',
      limiteEixos: '12 + 13,5 = 25,5',
      comprimentoMaximo: '14m',
      limiteComprimento1: '<=14m',
      limiteComprimento2: '',
      valorComprimento1: 25.5,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-8',
      tipo: 'Caminhão',
      limiteEixos: '12 + 13,5 = 25,5',
      comprimentoMaximo: '14m',
      limiteComprimento1: '<=14m',
      limiteComprimento2: '',
      valorComprimento1: 25.5,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-37',
      tipo: 'Caminhão + Reboque',
      limiteEixos: '6 + 10 + 10 + 10 = 36',
      comprimentoMaximo: '19,8m',
      limiteComprimento1: '<17,5m',
      limiteComprimento2: '>=17,5m',
      valorComprimento1: 36.0,
      valorComprimento2: 36.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-38',
      tipo: 'Caminhão + Reboque',
      limiteEixos: '6 + 10 + 10 + 17 = 43',
      comprimentoMaximo: '19,8m',
      limiteComprimento1: '<17,5m',
      limiteComprimento2: '>=17,5m',
      valorComprimento1: 43.0,
      valorComprimento2: 43.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-39',
      tipo: 'Caminhão + Reboque',
      limiteEixos: '6 + 10 + 17 + 17 = 50',
      comprimentoMaximo: '19,8m',
      limiteComprimento1: '<17,5m',
      limiteComprimento2: '>=17,5m',
      valorComprimento1: 45.0,
      valorComprimento2: 50.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-40',
      tipo: 'Caminhão + Reboque',
      limiteEixos: '6 + 17 + 10 + 10 = 43',
      comprimentoMaximo: '19,8m',
      limiteComprimento1: '<17,5m',
      limiteComprimento2: '>=17,5m',
      valorComprimento1: 43.0,
      valorComprimento2: 43.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-41',
      tipo: 'Caminhão + Reboque',
      limiteEixos: '6 + 17 + 10 + 17 = 50',
      comprimentoMaximo: '19,8m',
      limiteComprimento1: '<17,5m',
      limiteComprimento2: '>=17,5m',
      valorComprimento1: 45.0,
      valorComprimento2: 50.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-42',
      tipo: 'Caminhão + Reboque',
      limiteEixos: '6 + 17 + 17 + 17 = 57',
      comprimentoMaximo: '19,8m',
      limiteComprimento1: '<17,5m',
      limiteComprimento2: '>=17,5m',
      valorComprimento1: 45.0,
      valorComprimento2: 57.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-43',
      tipo: 'Caminhão + Reboque',
      limiteEixos: '6 + 13,5 + 10 + 10 = 39,5',
      comprimentoMaximo: '19,8m',
      limiteComprimento1: '<17,5m',
      limiteComprimento2: '>=17,5m',
      valorComprimento1: 39.5,
      valorComprimento2: 39.5,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-44',
      tipo: 'Caminhão + Reboque',
      limiteEixos: '6 + 13,5 + 10 + 17 = 46,5',
      comprimentoMaximo: '19,8m',
      limiteComprimento1: '<17,5m',
      limiteComprimento2: '>=17,5m',
      valorComprimento1: 45.0,
      valorComprimento2: 46.5,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-45',
      tipo: 'Caminhão + Reboque',
      limiteEixos: '6 + 13,5 + 17 + 17 = 53,5',
      comprimentoMaximo: '19,8m',
      limiteComprimento1: '<17,5m',
      limiteComprimento2: '>=17,5m',
      valorComprimento1: 45.0,
      valorComprimento2: 53.5,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-46',
      tipo: 'Caminhão + Reboque',
      limiteEixos: '12 + 17 + 10 + 10 = 49',
      comprimentoMaximo: '19,8m',
      limiteComprimento1: '<17,5m',
      limiteComprimento2: '>=17,5m',
      valorComprimento1: 45.0,
      valorComprimento2: 49.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-47',
      tipo: 'Caminhão + Reboque',
      limiteEixos: '12 + 17 + 10 + 17 = 56',
      comprimentoMaximo: '19,8m',
      limiteComprimento1: '<17,5m',
      limiteComprimento2: '>=17,5m',
      valorComprimento1: 45.0,
      valorComprimento2: 56.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-48',
      tipo: 'Caminhão + Reboque',
      limiteEixos: '12 + 13,5 + 10 + 10 = 45,5',
      comprimentoMaximo: '19,8m',
      limiteComprimento1: '<17,5m',
      limiteComprimento2: '>=17,5m',
      valorComprimento1: 45.0,
      valorComprimento2: 45.5,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-49',
      tipo: 'Caminhão + Reboque',
      limiteEixos: '12 + 13,5 + 10 + 17 = 52,5',
      comprimentoMaximo: '19,8m',
      limiteComprimento1: '<17,5m',
      limiteComprimento2: '>=17,5m',
      valorComprimento1: 45.0,
      valorComprimento2: 52.5,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-32',
      tipo: 'Caminhão + Reboque',
      limiteEixos: '6 + 10 + 10 + 10 = 36',
      comprimentoMaximo: '25m',
      limiteComprimento1: '>19,8m',
      limiteComprimento2: '',
      valorComprimento1: 36.0,
      valorComprimento2: 0.0,
      precisaAet: false,
      obs: 'Só reboques registrados até 01.05.09',
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-33',
      tipo: 'Caminhão + Reboque',
      limiteEixos: '6 + 10 + 10 + 17 = 43',
      comprimentoMaximo: '25m',
      limiteComprimento1: '>19,8m',
      limiteComprimento2: '',
      valorComprimento1: 43.0,
      valorComprimento2: 0.0,
      precisaAet: false,
      obs: 'Só reboques registrados até 01.05.09',
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-34',
      tipo: 'Caminhão + Reboque',
      limiteEixos: '6 + 10 + 17 + 17 = 50',
      comprimentoMaximo: '25m',
      limiteComprimento1: '>19,8m',
      limiteComprimento2: '',
      valorComprimento1: 50.0,
      valorComprimento2: 0.0,
      precisaAet: false,
      obs: 'Só reboques registrados até 01.05.09',
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-35',
      tipo: 'Caminhão + Reboque',
      limiteEixos: '6 + 17 + 10 + 10 = 43',
      comprimentoMaximo: '25m',
      limiteComprimento1: '>19,8m',
      limiteComprimento2: '',
      valorComprimento1: 43.0,
      valorComprimento2: 0.0,
      precisaAet: false,
      obs: 'Só reboques registrados até 01.05.09',
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-36',
      tipo: 'Caminhão + Reboque',
      limiteEixos: '6 + 17 + 10 + 17 = 50',
      comprimentoMaximo: '25m',
      limiteComprimento1: '>19,8m',
      limiteComprimento2: '',
      valorComprimento1: 50.0,
      valorComprimento2: 0.0,
      precisaAet: false,
      obs: 'Só reboques registrados até 01.05.09',
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-37',
      tipo: 'Caminhão + Reboque',
      limiteEixos: '6 + 17 + 17 + 17 = 57',
      comprimentoMaximo: '25m',
      limiteComprimento1: '>19,8m',
      limiteComprimento2: '',
      valorComprimento1: 57.0,
      valorComprimento2: 0.0,
      precisaAet: false,
      obs: 'Só reboques registrados até 01.05.09',
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-38',
      tipo: 'Caminhão + Reboque',
      limiteEixos: '6 + 13,5 + 10 + 10 = 39,5',
      comprimentoMaximo: '25m',
      limiteComprimento1: '>19,8m',
      limiteComprimento2: '',
      valorComprimento1: 39.5,
      valorComprimento2: 0.0,
      precisaAet: false,
      obs: 'Só reboques registrados até 01.05.09',
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-39',
      tipo: 'Caminhão + Reboque',
      limiteEixos: '6 + 13,5 + 10 + 17 = 46,5',
      comprimentoMaximo: '25m',
      limiteComprimento1: '>19,8m',
      limiteComprimento2: '',
      valorComprimento1: 46.5,
      valorComprimento2: 0.0,
      precisaAet: false,
      obs: 'Só reboques registrados até 01.05.09',
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-40',
      tipo: 'Caminhão + Reboque',
      limiteEixos: '6 + 13,5 + 17 + 17 = 53,5',
      comprimentoMaximo: '25m',
      limiteComprimento1: '>19,8m',
      limiteComprimento2: '',
      valorComprimento1: 53.5,
      valorComprimento2: 0.0,
      precisaAet: false,
      obs: 'Só reboques registrados até 01.05.09',
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-41',
      tipo: 'Caminhão + Reboque',
      limiteEixos: '12 + 17 + 10 + 10 = 49',
      comprimentoMaximo: '25m',
      limiteComprimento1: '>19,8m',
      limiteComprimento2: '',
      valorComprimento1: 49.0,
      valorComprimento2: 0.0,
      precisaAet: false,
      obs: 'Só reboques registrados até 01.05.09',
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-42',
      tipo: 'Caminhão + Reboque',
      limiteEixos: '12 + 17 + 10 + 17 = 56',
      comprimentoMaximo: '25m',
      limiteComprimento1: '>19,8m',
      limiteComprimento2: '',
      valorComprimento1: 56.0,
      valorComprimento2: 0.0,
      precisaAet: false,
      obs: 'Só reboques registrados até 01.05.09',
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-43',
      tipo: 'Caminhão + Reboque',
      limiteEixos: '12 + 13,5 + 10 + 10 = 45,5',
      comprimentoMaximo: '25m',
      limiteComprimento1: '>19,8m',
      limiteComprimento2: '',
      valorComprimento1: 45.5,
      valorComprimento2: 0.0,
      precisaAet: false,
      obs: 'Só reboques registrados até 01.05.09',
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-44',
      tipo: 'Caminhão + Reboque',
      limiteEixos: '12 + 13,5 + 10 + 17 = 52,5',
      comprimentoMaximo: '25m',
      limiteComprimento1: '>19,8m',
      limiteComprimento2: '',
      valorComprimento1: 52.5,
      valorComprimento2: 0.0,
      precisaAet: false,
      obs: 'Só reboques registrados até 01.05.09',
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-21',
      tipo: 'Caminhão + 2 Reboques',
      limiteEixos: '6 + 17 + 10 + 10 + 10 + 10 = 63',
      comprimentoMaximo: '30m',
      limiteComprimento1: '>=25m',
      limiteComprimento2: '',
      valorComprimento1: 63.0,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-22',
      tipo: 'Caminhão + 2 Reboques',
      limiteEixos: '6 + 17 + 10 + 10 + 10 + 17 = 70',
      comprimentoMaximo: '30m',
      limiteComprimento1: '>=25m',
      limiteComprimento2: '',
      valorComprimento1: 70.0,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-23',
      tipo: 'Caminhão + 2 Reboques',
      limiteEixos: '12 + 17 + 10 + 10 + 10 + 10 = 69',
      comprimentoMaximo: '30m',
      limiteComprimento1: '>=25m',
      limiteComprimento2: '',
      valorComprimento1: 69.0,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-9',
      tipo: 'C. Trator + Semirreboque',
      limiteEixos: '6 + 10 + 10 = 26',
      comprimentoMaximo: '18,6m',
      limiteComprimento1: '<16m',
      limiteComprimento2: '>=16m',
      valorComprimento1: 26.0,
      valorComprimento2: 26.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-10',
      tipo: 'C. Trator + Semirreboque',
      limiteEixos: '6 + 10 + 17 = 33',
      comprimentoMaximo: '18,6m',
      limiteComprimento1: '<16m',
      limiteComprimento2: '>=16m',
      valorComprimento1: 33.0,
      valorComprimento2: 33.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-11',
      tipo: 'C. Trator + Semirreboque',
      limiteEixos: '6 + 10 + 10 + 10 = 36',
      comprimentoMaximo: '18,6m',
      limiteComprimento1: '<16m',
      limiteComprimento2: '>=16m',
      valorComprimento1: 36.0,
      valorComprimento2: 36.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-12',
      tipo: 'C. Trator + Semirreboque',
      limiteEixos: '6 + 10 + 25,5 = 41,5',
      comprimentoMaximo: '18,6m',
      limiteComprimento1: '<16m',
      limiteComprimento2: '>=16m',
      valorComprimento1: 41.5,
      valorComprimento2: 41.5,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-13',
      tipo: 'C. Trator + Semirreboque',
      limiteEixos: '6 + 10 + 10 + 17 = 43',
      comprimentoMaximo: '18,6m',
      limiteComprimento1: '<16m',
      limiteComprimento2: '>=16m',
      valorComprimento1: 43.0,
      valorComprimento2: 43.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-14',
      tipo: 'C. Trator + Semirreboque',
      limiteEixos: '6 + 10 + 10 + 10 + 10 = 46',
      comprimentoMaximo: '18,6m',
      limiteComprimento1: '<16m',
      limiteComprimento2: '>=16m',
      valorComprimento1: 46.0,
      valorComprimento2: 46.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-15',
      tipo: 'C. Trator + Semirreboque',
      limiteEixos: '6 + 17 + 10 = 33',
      comprimentoMaximo: '18,6m',
      limiteComprimento1: '<16m',
      limiteComprimento2: '>=16m',
      valorComprimento1: 33.0,
      valorComprimento2: 33.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-16',
      tipo: 'C. Trator + Semirreboque',
      limiteEixos: '6 + 17 + 10 + 10 = 43',
      comprimentoMaximo: '18,6m',
      limiteComprimento1: '<16m',
      limiteComprimento2: '>=16m',
      valorComprimento1: 43.0,
      valorComprimento2: 43.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-17',
      tipo: 'C. Trator + Semirreboque',
      limiteEixos: '6 + 13,5 + 10 + 10 = 39,5',
      comprimentoMaximo: '18,6m',
      limiteComprimento1: '<16m',
      limiteComprimento2: '>=16m',
      valorComprimento1: 39.5,
      valorComprimento2: 39.5,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-18',
      tipo: 'C. Trator + Semirreboque',
      limiteEixos: '6 + 17 + 25,5 = 48,5',
      comprimentoMaximo: '18,6m',
      limiteComprimento1: '<16m',
      limiteComprimento2: '>=16m',
      valorComprimento1: 45.0,
      valorComprimento2: 48.5,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-19',
      tipo: 'C. Trator + Semirreboque',
      limiteEixos: '6 + 13,5 + 25,5 = 45',
      comprimentoMaximo: '18,6m',
      limiteComprimento1: '<16m',
      limiteComprimento2: '>=16m',
      valorComprimento1: 45.0,
      valorComprimento2: 45.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-20',
      tipo: 'C. Trator + Semirreboque',
      limiteEixos: '6 + 17 + 10 + 17 = 50',
      comprimentoMaximo: '18,6m',
      limiteComprimento1: '<16m',
      limiteComprimento2: '>=16m',
      valorComprimento1: 45.0,
      valorComprimento2: 50.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-21',
      tipo: 'C. Trator + Semirreboque',
      limiteEixos: '6 + 13,5 + 10 + 17 = 46,5',
      comprimentoMaximo: '18,6m',
      limiteComprimento1: '<16m',
      limiteComprimento2: '>=16m',
      valorComprimento1: 45.0,
      valorComprimento2: 46.5,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-22',
      tipo: 'C. Trator + Semirreboque',
      limiteEixos: '6 + 17 + 10 + 10 + 10 = 53',
      comprimentoMaximo: '18,6m',
      limiteComprimento1: '<16m',
      limiteComprimento2: '>=16m',
      valorComprimento1: 45.0,
      valorComprimento2: 53.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-23',
      tipo: 'C. Trator + Semirreboque',
      limiteEixos: '6 + 13,5 + 10 + 10 + 10 = 49,5',
      comprimentoMaximo: '18,6m',
      limiteComprimento1: '<16m',
      limiteComprimento2: '>=16m',
      valorComprimento1: 45.0,
      valorComprimento2: 49.5,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-24',
      tipo: 'C. Trator + Semirreboque',
      limiteEixos: '6 + 13,5 + 10 = 29,5',
      comprimentoMaximo: '18,6m',
      limiteComprimento1: '<16m',
      limiteComprimento2: '>=16m',
      valorComprimento1: 29.5,
      valorComprimento2: 29.5,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-25',
      tipo: 'C. Trator + Semirreboque',
      limiteEixos: '6 + 13,5 + 17 = 36,5',
      comprimentoMaximo: '18,6m',
      limiteComprimento1: '<16m',
      limiteComprimento2: '>=16m',
      valorComprimento1: 36.5,
      valorComprimento2: 36.5,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-26',
      tipo: 'C. Trator + Semirreboque',
      limiteEixos: '6 + 17 + 17 = 40',
      comprimentoMaximo: '18,6m',
      limiteComprimento1: '<16m',
      limiteComprimento2: '>=16m',
      valorComprimento1: 40.0,
      valorComprimento2: 40.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-27',
      tipo: 'C. Trator + Semirreboque',
      limiteEixos: '12 + 13,5 + 10 + 17 = 52,5',
      comprimentoMaximo: '18,6m',
      limiteComprimento1: '<16m',
      limiteComprimento2: '>=16m',
      valorComprimento1: 45.0,
      valorComprimento2: 52.5,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-28',
      tipo: 'C. Trator + Semirreboque',
      limiteEixos: '12 + 10 + 25,5 = 47,5',
      comprimentoMaximo: '18,6m',
      limiteComprimento1: '<16m',
      limiteComprimento2: '>=16m',
      valorComprimento1: 45.0,
      valorComprimento2: 47.5,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-29',
      tipo: 'C. Trator + Semirreboque',
      limiteEixos: '12 + 17 + 25,5 = 54,5',
      comprimentoMaximo: '18,6m',
      limiteComprimento1: '<16m',
      limiteComprimento2: '>=16m',
      valorComprimento1: 45.0,
      valorComprimento2: 54.5,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-30',
      tipo: 'C. Trator + Semirreboque',
      limiteEixos: '12 + 13,5 + 25,5 = 51',
      comprimentoMaximo: '18,6m',
      limiteComprimento1: '<16m',
      limiteComprimento2: '>=16m',
      valorComprimento1: 45.0,
      valorComprimento2: 51.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-31',
      tipo: 'C. Trator + Semirreboque',
      limiteEixos: '12 + 17 + 10 = 39',
      comprimentoMaximo: '18,6m',
      limiteComprimento1: '<16m',
      limiteComprimento2: '>=16m',
      valorComprimento1: 39.0,
      valorComprimento2: 39.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-32',
      tipo: 'C. Trator + Semirreboque',
      limiteEixos: '12 + 13,5 + 10 = 35,5',
      comprimentoMaximo: '18,6m',
      limiteComprimento1: '<16m',
      limiteComprimento2: '>=16m',
      valorComprimento1: 35.5,
      valorComprimento2: 35.5,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-33',
      tipo: 'C. Trator + Semirreboque',
      limiteEixos: '12 + 17 + 17 = 46',
      comprimentoMaximo: '18,6m',
      limiteComprimento1: '<16m',
      limiteComprimento2: '>=16m',
      valorComprimento1: 45.0,
      valorComprimento2: 46.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-34',
      tipo: 'C. Trator + Semirreboque',
      limiteEixos: '12 + 13,5 + 17 = 42,5',
      comprimentoMaximo: '18,6m',
      limiteComprimento1: '<16m',
      limiteComprimento2: '>=16m',
      valorComprimento1: 42.5,
      valorComprimento2: 42.5,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-35',
      tipo: 'C. Trator + Semirreboque',
      limiteEixos: '12 + 17 + 10 + 10 = 49',
      comprimentoMaximo: '18,6m',
      limiteComprimento1: '<16m',
      limiteComprimento2: '>=16m',
      valorComprimento1: 45.0,
      valorComprimento2: 49.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-36',
      tipo: 'C. Trator + Semirreboque',
      limiteEixos: '12 + 13,5 + 10 + 10 = 45,5',
      comprimentoMaximo: '18,6m',
      limiteComprimento1: '<16m',
      limiteComprimento2: '>=16m',
      valorComprimento1: 45.0,
      valorComprimento2: 45.5,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-50',
      tipo: 'C. Trator + Semirreboque + Reboque',
      limiteEixos: '6 + 10 + 10 + 10 + 10 = 46',
      comprimentoMaximo: '19,8m',
      limiteComprimento1: '<17,5m',
      limiteComprimento2: '>=17,5m',
      valorComprimento1: 45.0,
      valorComprimento2: 46.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-51',
      tipo: 'C. Trator + Semirreboque + Reboque',
      limiteEixos: '6 + 10 + 17 + 10 + 10 = 53',
      comprimentoMaximo: '19,8m',
      limiteComprimento1: '<17,5m',
      limiteComprimento2: '>=17,5m',
      valorComprimento1: 45.0,
      valorComprimento2: 53.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-52',
      tipo: 'C. Trator + Semirreboque + Reboque',
      limiteEixos: '6 + 10 + 10 + 10 + 17 = 53',
      comprimentoMaximo: '19,8m',
      limiteComprimento1: '<17,5m',
      limiteComprimento2: '>=17,5m',
      valorComprimento1: 45.0,
      valorComprimento2: 53.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-53',
      tipo: 'C. Trator + Semirreboque + Reboque',
      limiteEixos: '6 + 17 + 10 + 10 + 10 = 53',
      comprimentoMaximo: '19,8m',
      limiteComprimento1: '<17,5m',
      limiteComprimento2: '>=17,5m',
      valorComprimento1: 45.0,
      valorComprimento2: 53.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-54',
      tipo: 'C. Trator + Semirreboque + Reboque',
      limiteEixos: '6 + 13,5 + 10 + 10 + 10 = 49,5',
      comprimentoMaximo: '19,8m',
      limiteComprimento1: '<17,5m',
      limiteComprimento2: '>=17,5m',
      valorComprimento1: 45.0,
      valorComprimento2: 49.5,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-55',
      tipo: 'C. Trator + Semirreboque + Reboque',
      limiteEixos: '6 + 13,5 + 17 + 10 + 10 = 56,5',
      comprimentoMaximo: '19,8m',
      limiteComprimento1: '<17,5m',
      limiteComprimento2: '>=17,5m',
      valorComprimento1: 45.0,
      valorComprimento2: 56.5,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-56',
      tipo: 'C. Trator + Semirreboque + Reboque',
      limiteEixos: '6 + 13,5 + 10 + 10 + 17 = 56,5',
      comprimentoMaximo: '19,8m',
      limiteComprimento1: '<17,5m',
      limiteComprimento2: '>=17,5m',
      valorComprimento1: 45.0,
      valorComprimento2: 56.5,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-1',
      tipo: 'C. Trator + Semirreboque + Reboque',
      limiteEixos: '6 + 10 + 10 + 10 + 10 = 46',
      comprimentoMaximo: '30m',
      limiteComprimento1: '>19,8m',
      limiteComprimento2: '',
      valorComprimento1: 46.0,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-2',
      tipo: 'C. Trator + Semirreboque + Reboque',
      limiteEixos: '6 + 17 + 10 + 10 + 10 = 53',
      comprimentoMaximo: '30m',
      limiteComprimento1: '>19,8m',
      limiteComprimento2: '',
      valorComprimento1: 53.0,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-3',
      tipo: 'C. Trator + Semirreboque + Reboque',
      limiteEixos: '6 + 10 + 10 + 10 + 17 = 53',
      comprimentoMaximo: '30m',
      limiteComprimento1: '>19,8m',
      limiteComprimento2: '',
      valorComprimento1: 53.0,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-4',
      tipo: 'C. Trator + Semirreboque + Reboque',
      limiteEixos: '6 + 17 + 17 + 10 + 10 = 60',
      comprimentoMaximo: '30m',
      limiteComprimento1: '>=25m',
      limiteComprimento2: '',
      valorComprimento1: 60.0,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-5',
      tipo: 'C. Trator + Semirreboque + Reboque',
      limiteEixos: '6 + 17 + 17 + 10 + 17 = 67',
      comprimentoMaximo: '30m',
      limiteComprimento1: '>=25m',
      limiteComprimento2: '',
      valorComprimento1: 67.0,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-6',
      tipo: 'C. Trator + Semirreboque + Reboque',
      limiteEixos: '6 + 17 + 17 + 17 + 17 = 74',
      comprimentoMaximo: '30m',
      limiteComprimento1: '>=25m',
      limiteComprimento2: '',
      valorComprimento1: 74.0,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-7',
      tipo: 'C. Trator + Semirreboque + Reboque',
      limiteEixos: '12 + 17 + 17 + 10 + 10 = 66',
      comprimentoMaximo: '30m',
      limiteComprimento1: '>=25m',
      limiteComprimento2: '',
      valorComprimento1: 66.0,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-8',
      tipo: 'C. Trator + Semirreboque + Reboque',
      limiteEixos: '12 + 17 + 17 + 10 + 17 = 73',
      comprimentoMaximo: '30m',
      limiteComprimento1: '>=25m',
      limiteComprimento2: '',
      valorComprimento1: 73.0,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-57',
      tipo: 'C. Trator + 2 Semirreboques',
      limiteEixos: '6 + 10 + 10 + 10 = 36',
      comprimentoMaximo: '19,8m',
      limiteComprimento1: '<17,5m',
      limiteComprimento2: '>=17,5m',
      valorComprimento1: 36.0,
      valorComprimento2: 36.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-58',
      tipo: 'C. Trator + 2 Semirreboques',
      limiteEixos: '6 + 17 + 10 + 10 = 43',
      comprimentoMaximo: '19,8m',
      limiteComprimento1: '<17,5m',
      limiteComprimento2: '>=17,5m',
      valorComprimento1: 43.0,
      valorComprimento2: 43.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-59',
      tipo: 'C. Trator + 2 Semirreboques',
      limiteEixos: '6 + 13,5 + 10 + 10 = 39,5',
      comprimentoMaximo: '19,8m',
      limiteComprimento1: '<17,5m',
      limiteComprimento2: '>=17,5m',
      valorComprimento1: 39.5,
      valorComprimento2: 39.5,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-60',
      tipo: 'C. Trator + 2 Semirreboques',
      limiteEixos: '6 + 10 + 17 + 10 = 43',
      comprimentoMaximo: '19,8m',
      limiteComprimento1: '<17,5m',
      limiteComprimento2: '>=17,5m',
      valorComprimento1: 43.0,
      valorComprimento2: 43.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-61',
      tipo: 'C. Trator + 2 Semirreboques',
      limiteEixos: '6 + 17 + 17 + 10 = 50',
      comprimentoMaximo: '19,8m',
      limiteComprimento1: '<17,5m',
      limiteComprimento2: '>=17,5m',
      valorComprimento1: 45.0,
      valorComprimento2: 50.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-62',
      tipo: 'C. Trator + 2 Semirreboques',
      limiteEixos: '6 + 13,5 + 17 + 10 = 46,5',
      comprimentoMaximo: '19,8m',
      limiteComprimento1: '<17,5m',
      limiteComprimento2: '>=17,5m',
      valorComprimento1: 45.0,
      valorComprimento2: 46.5,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-63',
      tipo: 'C. Trator + 2 Semirreboques',
      limiteEixos: '6 + 10 + 17 + 17 = 50',
      comprimentoMaximo: '19,8m',
      limiteComprimento1: '<17,5m',
      limiteComprimento2: '>=17,5m',
      valorComprimento1: 45.0,
      valorComprimento2: 50.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-64',
      tipo: 'C. Trator + 2 Semirreboques',
      limiteEixos: '6 + 17 + 17 + 17 = 57',
      comprimentoMaximo: '19,8m',
      limiteComprimento1: '<17,5m',
      limiteComprimento2: '>=17,5m',
      valorComprimento1: 45.0,
      valorComprimento2: 57.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-65',
      tipo: 'C. Trator + 2 Semirreboques',
      limiteEixos: '6 + 13,5 + 17 + 17 = 53,5',
      comprimentoMaximo: '19,8m',
      limiteComprimento1: '<17,5m',
      limiteComprimento2: '>=17,5m',
      valorComprimento1: 45.0,
      valorComprimento2: 53.5,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'I-i9',
      tipo: 'C. Trator + 2 Semirreboques',
      limiteEixos: '6 + 10 + 10 + 10 = 36',
      comprimentoMaximo: '30m',
      limiteComprimento1: '>19,8m',
      limiteComprimento2: '',
      valorComprimento1: 36.0,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-10',
      tipo: 'C. Trator + 2 Semirreboques',
      limiteEixos: '6 + 17 + 10 + 10 = 43',
      comprimentoMaximo: '30m',
      limiteComprimento1: '>19,8m',
      limiteComprimento2: '',
      valorComprimento1: 43.0,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-11',
      tipo: 'C. Trator + 2 Semirreboques',
      limiteEixos: '6 + 13,5 + 10 + 10 = 39,5',
      comprimentoMaximo: '30m',
      limiteComprimento1: '>19,8m',
      limiteComprimento2: '',
      valorComprimento1: 39.5,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-12',
      tipo: 'C. Trator + 2 Semirreboques',
      limiteEixos: '6 + 10 + 17 + 10 = 43',
      comprimentoMaximo: '30m',
      limiteComprimento1: '>19,8m',
      limiteComprimento2: '',
      valorComprimento1: 43.0,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-13',
      tipo: 'C. Trator + 2 Semirreboques',
      limiteEixos: '6 + 17 + 17 + 10 = 50',
      comprimentoMaximo: '30m',
      limiteComprimento1: '>19,8m',
      limiteComprimento2: '',
      valorComprimento1: 50.0,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-14',
      tipo: 'C. Trator + 2 Semirreboques',
      limiteEixos: '6 + 13,5 + 17 + 10 = 46,5',
      comprimentoMaximo: '30m',
      limiteComprimento1: '>19,8m',
      limiteComprimento2: '',
      valorComprimento1: 46.5,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-15',
      tipo: 'C. Trator + 2 Semirreboques',
      limiteEixos: '6 + 10 + 17 + 17 = 50',
      comprimentoMaximo: '30m',
      limiteComprimento1: '>19,8m',
      limiteComprimento2: '',
      valorComprimento1: 50.0,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-16',
      tipo: 'C. Trator + 2 Semirreboques',
      limiteEixos: '6 + 17 + 17 + 17 = 57',
      comprimentoMaximo: '30m',
      limiteComprimento1: '>19,8m',
      limiteComprimento2: '',
      valorComprimento1: 57.0,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-17',
      tipo: 'C. Trator + 2 Semirreboques',
      limiteEixos: '6 + 13,5 + 17 + 17 = 53,5',
      comprimentoMaximo: '30m',
      limiteComprimento1: '>19,8m',
      limiteComprimento2: '',
      valorComprimento1: 53.5,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-18',
      tipo: 'C. Trator + 2 Semirreboques',
      limiteEixos: '6 + 17 + 17 + 25,5 = 65,5',
      comprimentoMaximo: '30m',
      limiteComprimento1: '>=25m',
      limiteComprimento2: '',
      valorComprimento1: 65.5,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-19',
      tipo: 'C. Trator + 2 Semirreboques',
      limiteEixos: '6 + 17 + 25,5 + 25,5 = 74',
      comprimentoMaximo: '30m',
      limiteComprimento1: '>=25m',
      limiteComprimento2: '',
      valorComprimento1: 74.0,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-20',
      tipo: 'C. Trator + 2 Semirreboques',
      limiteEixos: '12 + 17 + 17 + 17 = 63',
      comprimentoMaximo: '30m',
      limiteComprimento1: '>=25m',
      limiteComprimento2: '',
      valorComprimento1: 63.0,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-24',
      tipo: 'C. Trator + 3 Semirreboques',
      limiteEixos: '6 + 17 + 17 + 10 + 10 = 60',
      comprimentoMaximo: '30m',
      limiteComprimento1: '>=25m',
      limiteComprimento2: '',
      valorComprimento1: 60.0,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-25',
      tipo: 'C. Trator + 3 Semirreboques',
      limiteEixos: '6 + 17 + 10 + 17 + 10 = 60',
      comprimentoMaximo: '30m',
      limiteComprimento1: '>=25m',
      limiteComprimento2: '',
      valorComprimento1: 60.0,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-26',
      tipo: 'C. Trator + 3 Semirreboques',
      limiteEixos: '6 + 17 + 10 + 10 + 17 = 60',
      comprimentoMaximo: '30m',
      limiteComprimento1: '>=25m',
      limiteComprimento2: '',
      valorComprimento1: 60.0,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-27',
      tipo: 'C. Trator + 3 Semirreboques',
      limiteEixos: '6 + 17 + 17 + 17 + 10 = 67',
      comprimentoMaximo: '30m',
      limiteComprimento1: '>=25m',
      limiteComprimento2: '',
      valorComprimento1: 67.0,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-28',
      tipo: 'C. Trator + 3 Semirreboques',
      limiteEixos: '6 + 17 + 17 + 10 + 17 = 67',
      comprimentoMaximo: '30m',
      limiteComprimento1: '>=25m',
      limiteComprimento2: '',
      valorComprimento1: 67.0,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-29',
      tipo: 'C. Trator + 3 Semirreboques',
      limiteEixos: '6 + 17 + 10 + 17 + 17 = 67',
      comprimentoMaximo: '30m',
      limiteComprimento1: '>=25m',
      limiteComprimento2: '',
      valorComprimento1: 67.0,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-30',
      tipo: 'C. Trator + 3 Semirreboques',
      limiteEixos: '6 + 17 + 17 + 17 + 17 = 74',
      comprimentoMaximo: '30m',
      limiteComprimento1: '>=25m',
      limiteComprimento2: '',
      valorComprimento1: 74.0,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'II-31',
      tipo: 'C. Trator + 3 Semirreboques',
      limiteEixos: '6 + 13,5 + 17 + 10 + 10 = 56,5',
      comprimentoMaximo: '30m',
      limiteComprimento1: '>19,8m',
      limiteComprimento2: '',
      valorComprimento1: 56.5,
      valorComprimento2: 0.0,
      precisaAet: false,
    ));

    configs.add(VeiculoPesoModel(
      id: 'IV-1',
      tipo: 'C. Trator + SR + Dolly + SR',
      limiteEixos: '6 + 17 + 25,5 + 17 + 25,5 = 91',
      comprimentoMaximo: '30m',
      limiteComprimento1: '>=28m',
      limiteComprimento2: '',
      valorComprimento1: 91.0,
      valorComprimento2: 0.0,
      precisaAet: true,
    ));

    configs.add(VeiculoPesoModel(
      id: 'IV-2',
      tipo: 'C. Trator + SR + Dolly + SR',
      limiteEixos: '6 + 17 + 17 + 17 + 25,5 = 82,5',
      comprimentoMaximo: '30m',
      limiteComprimento1: '>=28m',
      limiteComprimento2: '',
      valorComprimento1: 82.5,
      valorComprimento2: 0.0,
      precisaAet: true,
    ));

    configs.add(VeiculoPesoModel(
      id: 'IV-3',
      tipo: 'C. Trator + SR + Dolly + SR',
      limiteEixos: '6 + 17 + 25,5 + 17 + 17 = 82,5',
      comprimentoMaximo: '30m',
      limiteComprimento1: '>=28m',
      limiteComprimento2: '',
      valorComprimento1: 82.5,
      valorComprimento2: 0.0,
      precisaAet: true,
    ));

    if (filtroSelecionado == 'Todos') {
      return Future.value(configs);
    } else {
      return Future.value(configs.where((element) => element.tipo == filtroSelecionado).toList());
    }
  }
}
