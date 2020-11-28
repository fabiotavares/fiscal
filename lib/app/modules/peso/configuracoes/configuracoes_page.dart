import 'package:fiscal/app/components/configuracao_peso_item.dart';
import 'package:fiscal/app/components/theme_utils.dart';
import 'package:fiscal/app/model/veiculo_peso_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'configuracoes_controller.dart';

class ConfiguracoesPage extends StatefulWidget {
  final String title;
  const ConfiguracoesPage({Key key, this.title = "Configurações"}) : super(key: key);

  @override
  _ConfiguracoesPageState createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends ModularState<ConfiguracoesPage, ConfiguracoesController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    super.initState();
    // um bom padrão a ser seguido
    controller.initPage();
  }

  @override
  Widget build(BuildContext context) {
    var myAppBar = AppBar(
      title: Text(widget.title),
    );

    return Scaffold(
      appBar: myAppBar,
      backgroundColor: Colors.grey[300],
      body: Observer(builder: (_) {
        return FutureBuilder<List<VeiculoPesoModel>>(
          future: controller.configuracoesFuture,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Container();
                break;
              case ConnectionState.waiting:
              case ConnectionState.active:
                return Center(child: CircularProgressIndicator());
                break;
              case ConnectionState.done:
                // verifica se tem algum erro
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Erro ao buscar configurações'),
                  );
                }

                // confirmar se tem algum dado
                if (snapshot.hasData) {
                  var configs = snapshot.data;

                  return Column(
                    children: [
                      Observer(builder: (_) {
                        return Container(
                          // color: ThemeUtils.accentColor,
                          width: ScreenUtil().screenWidth * .8,
                          height: 60,
                          child: Center(
                            child: DropdownButton<String>(
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                              isExpanded: true,
                              value: controller.filtroSelecionado,
                              items: [
                                DropdownMenuItem<String>(
                                  value: 'Todos',
                                  child: Text('Todos'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Caminhão',
                                  child: Text('Caminhão'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Caminhão + Reboque',
                                  child: Text('Caminhão + Reboque'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Caminhão + 2 Reboques',
                                  child: Text('Caminhão + 2 Reboques'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'C. Trator + Semirreboque',
                                  child: Text('C. Trator + Semirreboque'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'C. Trator + Semirreboque + Reboque',
                                  child: Text('C. Trator + Semirreboque + Reboque'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'C. Trator + 2 Semirreboques',
                                  child: Text('C. Trator + 2 Semirreboques'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'C. Trator + 3 Semirreboques',
                                  child: Text('C. Trator + 3 Semirreboques'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'C. Trator + SR + Dolly + SR',
                                  child: Text('C. Trator + SR + Dolly + SR'),
                                ),
                              ],
                              onChanged: (String value) {
                                controller.changeFiltroSelecionado(value);
                              },
                            ),
                          ),
                        );
                      }),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          //width: double.infinity,
                          //height: ScreenUtil().screenHeight - (myAppBar.preferredSize.height + ScreenUtil().statusBarHeight),
                          child: ListView.builder(
                            itemCount: configs.length,
                            itemBuilder: (context, index) {
                              var config = configs[index];
                              // construção do circulo com icone e desenho embaixo
                              return InkWell(
                                onTap: () {
                                  Modular.to.pop(config);
                                },
                                child: Card(
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0),
                                    child: ConfiguracaoPesoItem(veiculoModel: config),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  // não tem dados pra mostrar
                  return Center(
                    child: Text('Nenhuma configuração pra exibir'),
                  );
                }
                break;
              default:
                return Container();
            }
          },
        );
      }),
    );
  }
}
