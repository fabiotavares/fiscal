import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:fiscal/app/components/configuracao_peso_item.dart';
import 'package:fiscal/app/components/sim_ou_nao_dialog.dart';
import 'package:fiscal/app/components/text_field_soma/text_field_soma_widget.dart';
import 'package:fiscal/app/model/veiculo_peso_model.dart';
import 'package:fiscal/app/model/fiscalizacao_peso_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'peso_controller.dart';

class PesoPage extends StatefulWidget {
  final String title;
  const PesoPage({Key key, this.title = "Fiscalização de Peso"}) : super(key: key);

  @override
  _PesoPageState createState() => _PesoPageState();
}

class _PesoPageState extends ModularState<PesoPage, PesoController> {
  //use 'controller' variable to access controller
  final espacamento = 16.0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // confirma com o usuário de deseja descartar a fiscalização atual
        var resposta = await SimOuNaoDialog.show(
          context: context,
          msg: 'Deseja descartar a fiscalização atual e voltar pra tela inicial?',
        );
        return resposta;
      },
      child: Observer(
        builder: (context) => Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            title: Text(widget.title),
            actions: [
              IconButton(
                icon: Icon(Icons.check),
                onPressed: () {
                  final dados = validaDados();
                  if (dados != null) {
                    Modular.to.pushNamed('/peso/infracoes_peso', arguments: dados);
                  }
                },
              )
            ],
          ),
          body: Observer(builder: (_) {
            return PageView(
              controller: controller.pageController,
              children: [
                _veiculoPage(),
                _notaFiscalPage(),
                _balancaPage(),
              ],
              onPageChanged: controller.changeSelectedPage,
              // physics: NeverScrollableScrollPhysics(),
            );
          }),
          bottomNavigationBar: FFNavigationBar(
            selectedIndex: controller.selectedTab,
            theme: FFNavigationBarTheme(
              itemWidth: 55,
              barHeight: 65,
              barBackgroundColor: Theme.of(context).primaryColor,
              unselectedItemIconColor: Colors.white,
              unselectedItemLabelColor: Colors.white,
              selectedItemBorderColor: Colors.white,
              selectedItemIconColor: Colors.white,
              selectedItemBackgroundColor: Theme.of(context).accentColor,
              selectedItemLabelColor: Colors.white,
            ),
            items: [
              FFNavigationBarItem(
                iconData: FontAwesome.truck,
                label: 'Veículo',
              ),
              FFNavigationBarItem(
                iconData: FontAwesome.files_o,
                label: 'Nota Fiscal',
              ),
              FFNavigationBarItem(
                iconData: FontAwesome.balance_scale,
                label: 'Balança',
              ),
            ],
            onSelectTab: (index) {
              controller.changeSelectedTab(index);
            },
          ),
        ),
      ),
    );
  }

  Widget _veiculoPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          // key: controller.veiculoFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Configuração de eixos do veículo fiscalizado
              InkWell(
                onTap: () async {
                  var veiculoModel = await Modular.to.pushNamed('/peso/configuracoes') as VeiculoPesoModel;
                  if (veiculoModel != null) {
                    controller.setVeiculoModel(veiculoModel);
                  }
                },
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0),
                    child: controller.veiculoModel != null
                        ? ConfiguracaoPesoItem(veiculoModel: controller.veiculoModel, controller: controller)
                        : Container(
                            width: double.infinity,
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search,
                                  size: 30,
                                ),
                                SizedBox(height: 10),
                                Text('Configuração de Eixos')
                              ],
                            ),
                          ),
                  ),
                ),
              ),

              // Limite técnico
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0, bottom: 4.0),
                  child: TextFieldSomaWidget(
                    textFieldSomaController: controller.limiteTecnicoSomaController,
                    textEditingController: controller.limiteTecnicoController,
                    label: 'Limite técnico (kg)',
                  ),
                ),
              ),

              // Tara total do veículo fiscalizado
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0, bottom: 4.0),
                  child: TextFieldSomaWidget(
                    textFieldSomaController: controller.taraSomaController,
                    textEditingController: controller.taraController,
                    label: 'Tara (kg)',
                  ),
                ),
              ),

              // Capacidade máxima de tração
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0, bottom: 4.0),
                  child: TextFieldSomaWidget(
                    textFieldSomaController: controller.cmtSomaController,
                    textEditingController: controller.cmtController,
                    label: 'CMT (kg)',
                  ),
                ),
              ),

              // Placas dos tracionados
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0, bottom: 32.0),
                  child: TextFormField(
                    controller: controller.placasTracionadosController,
                    textCapitalization: TextCapitalization.characters,
                    decoration: const InputDecoration(
                      labelText: 'Placas dos tracionados',
                      labelStyle: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _notaFiscalPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          // key: controller.notaFiscalFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tipo de carga
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0, bottom: 32.0),
                  child: TextFormField(
                    controller: controller.tipoCargaController,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      labelText: 'Tipo de Carga',
                      labelStyle: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ),

              // Tipo de nota fiscal
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0, bottom: 4.0),
                  child: Column(
                    children: [
                      RadioListTile(
                        groupValue: controller.opcaoNotaFiscal,
                        onChanged: (value) => controller.changeNotaFiscal(value),
                        value: 0,
                        title: Text(
                          'Não possui documento fiscal',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      RadioListTile(
                        groupValue: controller.opcaoNotaFiscal,
                        onChanged: (value) => controller.changeNotaFiscal(value),
                        value: 1,
                        title: Text(
                          'Possui vários remetentes',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      RadioListTile(
                        groupValue: controller.opcaoNotaFiscal,
                        onChanged: (value) => controller.changeNotaFiscal(value),
                        value: 2,
                        title: Text(
                          'Possui um único remetente',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // CNPJ do único remetente
              Visibility(
                visible: controller.opcaoNotaFiscal == 2,
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0, bottom: 32.0),
                    child: TextFormField(
                      controller: controller.cnpjRemetenteController,
                      keyboardType: TextInputType.number,
                      maxLength: 14,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        //r'^\d+\.?\d{0,2}
                      ],
                      decoration: const InputDecoration(
                        labelText: 'CNPJ Remetente (apenas dígitos)',
                        labelStyle: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ),

              // Peso declarado total
              Visibility(
                visible: controller.opcaoNotaFiscal != 0,
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0, bottom: 4.0),
                    child: TextFieldSomaWidget(
                      textFieldSomaController: controller.pesoDeclaradoSomaController,
                      textEditingController: controller.pesoDeclaradoController,
                      label: 'Peso declarado (kg)',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _balancaPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          // key: controller.balancaFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Informação de uso da balança
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0, bottom: 4.0),
                  child: Column(
                    children: [
                      RadioListTile(
                        groupValue: controller.opcaoBalanca,
                        onChanged: (value) => controller.changeBalanca(value),
                        value: 0,
                        title: Text(
                          'Balança não disponível',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      RadioListTile(
                        groupValue: controller.opcaoBalanca,
                        onChanged: (value) => controller.changeBalanca(value),
                        value: 1,
                        title: Text(
                          'Medição reallizada',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Peso aferido na pesagem
              Visibility(
                visible: controller.opcaoBalanca == 1,
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0, bottom: 4.0),
                    child: TextFieldSomaWidget(
                      textFieldSomaController: controller.pesoAferidoSomaController,
                      textEditingController: controller.pesoAferidoController,
                      label: 'Peso aferido (kg)',
                    ),
                  ),
                ),
              ),

              // Nome da balança usada
              Visibility(
                visible: controller.opcaoBalanca == 1,
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0, bottom: 32.0),
                    child: TextFormField(
                      readOnly: true,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        labelText: 'Balança utilizada',
                        labelStyle: TextStyle(fontSize: 14),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Número INMETRO de verificação da balança
              Visibility(
                visible: controller.opcaoBalanca == 1,
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0, bottom: 32.0),
                    child: TextFormField(
                      controller: controller.inmetroController,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        labelText: 'INMETRO',
                        labelStyle: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ),

              // Peso declarado total
              Visibility(
                visible: controller.opcaoBalanca == 1,
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0, bottom: 32.0),
                    child: TextFormField(
                      controller: controller.validadeAfericaoController,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        labelText: 'Validade da aferição',
                        labelStyle: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatNumber(String number) {
    // converte formato brasil para internacional
    // removendo os pontos e trocando vírgula por ponto
    return number.replaceAll('.', '').replaceAll(',', '.');
  }

  FiscalizacaoPesoModel validaDados() {
    try {
      if (controller.veiculoModel == null) {
        print('Erro: É necessário escolher uma configuração de eixos antes');
        Get.snackbar(
          'Erro',
          '',
          messageText: Text('É necessário escolher uma configuração de eixos antes!'),
          icon: Icon(Icons.error_outline, size: 30),
          duration: Duration(seconds: 5),
        );
        return null;
      }

      FiscalizacaoPesoModel fiscalizacao = FiscalizacaoPesoModel(
        classificacao: controller.veiculoModel.id,
        pbtcLegal: controller.valuePesoPorComprimento * 1000,
        pbtcTecnico: double.tryParse(formatNumber(controller.limiteTecnicoController.text)) ?? 0.0,
        tara: double.tryParse(formatNumber(controller.taraController.text)) ?? 0.0,
        cmt: double.tryParse(formatNumber(controller.cmtController.text)) ?? 0.0,
        placas: controller.placasTracionadosController.text ?? '',
        tipoCarga: controller.tipoCargaController.text ?? '',
        opcaoNotaFiscal: controller.opcaoNotaFiscal == 0
            ? OpcaoNotaFiscal.nao_possui
            : controller.opcaoNotaFiscal == 1
                ? OpcaoNotaFiscal.varios_remetentes
                : OpcaoNotaFiscal.unico_remetente,
        cnpj: controller.cnpjRemetenteController.text ?? '',
        pesoDeclarado: controller.opcaoNotaFiscal == 0 ? 0.0 : double.tryParse(formatNumber(controller.pesoDeclaradoController.text)) ?? 0.0,
        pesoAferido: controller.opcaoBalanca == 0 ? 0.0 : double.tryParse(formatNumber(controller.pesoAferidoController.text)) ?? 0.0,
        afericaoInmetro: controller.inmetroController.text ?? '',
        afericaoValidade: controller.validadeAfericaoController.text ?? '',
        pbtcLabel: controller.veiculoModel.pbtc,
      );

      if (fiscalizacao.pesoDeclarado == 0.0 && fiscalizacao.pesoAferido == 0.0) {
        print('Erro: Nenhum peso foi informado');
        Get.snackbar(
          'Erro',
          '',
          messageText: Text('Nenhum peso foi informado!'),
          icon: Icon(Icons.error_outline, size: 30),
          duration: Duration(seconds: 5),
        );
        return null;
      }

      if (fiscalizacao.pesoAferido == 0.0 && fiscalizacao.tara == 0.0) {
        print('Erro: É necessário informar a tara  do veículo na fiscalização por nota fiscal');
        Get.snackbar(
          'Erro',
          '',
          messageText: Text('É necessário informar a tara  do veículo na fiscalização por nota fiscal!'),
          icon: Icon(Icons.error_outline, size: 30),
          duration: Duration(seconds: 5),
        );
        return null;
      }

      // dados validados com sucesso
      return fiscalizacao;
    } catch (e) {
      // exibe erro: erro inesperado!
      return null;
    }
  }
}
