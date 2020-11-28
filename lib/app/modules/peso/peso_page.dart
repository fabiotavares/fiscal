import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:fiscal/app/components/configuracao_peso_item.dart';
import 'package:fiscal/app/components/sim_ou_nao_dialog.dart';
import 'package:fiscal/app/components/text_form_field_soma.dart';
import 'package:fiscal/app/model/veiculo_peso_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            title: Text(widget.title),
            actions: [
              IconButton(
                icon: Icon(Icons.check),
                onPressed: () {},
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
              physics: NeverScrollableScrollPhysics(),
            );
          }),
          bottomNavigationBar: FFNavigationBar(
            selectedIndex: controller.selectedTab,
            theme: FFNavigationBarTheme(
              itemWidth: 60,
              barHeight: 70,
              barBackgroundColor: Theme.of(context).primaryColor,
              unselectedItemIconColor: Colors.white,
              unselectedItemLabelColor: Colors.white,
              selectedItemBorderColor: Colors.white,
              selectedItemIconColor: Colors.black,
              selectedItemBackgroundColor: Theme.of(context).accentColor,
              selectedItemLabelColor: Colors.black,
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
          key: controller.veiculoFormKey,
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
                  child: TextFormFieldSoma(controller: controller.limiteTecnicoController, label: 'Limite técnico (t)'),
                ),
              ),

              // Tara total do veículo fiscalizado
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0, bottom: 4.0),
                  child: TextFormFieldSoma(controller: controller.taraController, label: 'Tara (t)'),
                ),
              ),

              // Capacidade máxima de tração
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0, bottom: 28.0),
                  child: TextFormField(
                    controller: controller.cmtController,
                    decoration: const InputDecoration(
                      labelText: 'Capacidade máxima de tração',
                    ),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                    ],
                  ),
                ),
              ),

              // Placas dos tracionados
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0, bottom: 28.0),
                  child: TextFormField(
                    controller: controller.placasTracionadosController,
                    textCapitalization: TextCapitalization.characters,
                    decoration: const InputDecoration(
                      labelText: 'Placas dos tracionados',
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
          key: controller.notaFiscalFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tipo de carga
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0, bottom: 28.0),
                  child: TextFormField(
                    controller: controller.tipoCargaController,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      labelText: 'Tipo de Carga',
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
                      Row(
                        children: [
                          Radio(
                            value: 0,
                            groupValue: controller.groupNotaFiscal,
                            onChanged: (value) => controller.changeNotaFiscal(value),
                          ),
                          Text(
                            'Não possui documento fiscal',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 1,
                            groupValue: controller.groupNotaFiscal,
                            onChanged: (value) => controller.changeNotaFiscal(value),
                          ),
                          Text(
                            'Possui vários remetentes',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 2,
                            groupValue: controller.groupNotaFiscal,
                            onChanged: (value) => controller.changeNotaFiscal(value),
                          ),
                          Text(
                            'Possui um único remetente',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // CNPJ do único remetente
              Visibility(
                visible: controller.groupNotaFiscal == 2,
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0, bottom: 28.0),
                    child: TextFormField(
                      controller: controller.cnpjRemetenteController,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        labelText: 'CNPJ Remetente',
                      ),
                    ),
                  ),
                ),
              ),

              // Peso declarado total
              Visibility(
                visible: controller.groupNotaFiscal != 0,
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0, bottom: 4.0),
                    child: TextFormFieldSoma(controller: controller.taraController, label: 'Peso declarado (t)'),
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
          key: controller.balancaFormKey,
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
                      Row(
                        children: [
                          Radio(
                            value: 0,
                            groupValue: controller.groupBalanca,
                            onChanged: (value) => controller.changeBalanca(value),
                          ),
                          Text(
                            'Balança não disponível',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 1,
                            groupValue: controller.groupBalanca,
                            onChanged: (value) => controller.changeBalanca(value),
                          ),
                          Text(
                            'Medição reallizada',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Peso aferido na pesagem
              Visibility(
                visible: controller.groupBalanca == 1,
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0, bottom: 28.0),
                    child: TextFormField(
                      controller: controller.cmtController,
                      decoration: const InputDecoration(
                        labelText: 'Peso aferido (t)',
                      ),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Digite algum valor';
                        }
                        if (double.tryParse(value) == 0.0) {
                          return 'Digite algum valor maior que zero';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),

              // Nome da balança usada
              Visibility(
                visible: controller.groupBalanca == 1,
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0, bottom: 28.0),
                    child: TextFormField(
                      readOnly: true,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        labelText: 'Balança utilizada',
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
                visible: controller.groupBalanca == 1,
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0, bottom: 28.0),
                    child: TextFormField(
                      controller: controller.inmetroController,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        labelText: 'INMETRO',
                      ),
                    ),
                  ),
                ),
              ),

              // Peso declarado total
              Visibility(
                visible: controller.groupBalanca == 1,
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0, bottom: 28.0),
                    child: TextFormField(
                      controller: controller.validadeAfericaoController,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        labelText: 'Validade da aferição',
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
}
