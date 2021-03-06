import 'package:fiscal/app/modules/peso/components/classificacao_item.dart';
import 'package:fiscal/app/models/classificacao_eixos_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'classificacao_controller.dart';

class ClassificacaoPage extends StatefulWidget {
  final String title;
  const ClassificacaoPage({Key key, this.title = "Port. 63/09 Denatran"}) : super(key: key);

  @override
  _ClassificacaoPageState createState() => _ClassificacaoPageState();
}

class _ClassificacaoPageState extends ModularState<ClassificacaoPage, ClassificacaoController> {
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
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      backgroundColor: Colors.grey[300],
      elevation: 0,
      title: Text(
        widget.title,
        style: TextStyle(color: Colors.black),
      ),
    );

    return Scaffold(
      appBar: myAppBar,
      backgroundColor: Colors.grey[300],
      floatingActionButton: Observer(builder: (_) {
        return AnimatedOpacity(
          opacity: controller.scrollToTopVisible ? 1.0 : 0.0,
          duration: Duration(milliseconds: 300),
          child: Visibility(
            visible: controller.scrollToTopVisible,
            child: FloatingActionButton(
              mini: true,
              child: Icon(Icons.vertical_align_top_rounded),
              backgroundColor: Colors.white,
              onPressed: () {
                controller.scrollController.animateTo(
                  0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Observer(builder: (_) {
        return FutureBuilder<List<ClassificacaoEixosModel>>(
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
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Material(
                            // color: Colors.grey[300],
                            elevation: 10,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: ScreenUtil().screenWidth,
                              height: 60,
                              padding: const EdgeInsets.all(16.0),
                              child: Center(
                                child: DropdownButton<String>(
                                  underline: Divider(color: Colors.transparent),
                                  style: TextStyle(color: Colors.black),
                                  dropdownColor: Colors.grey[200],
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
                            ),
                          ),
                        );
                      }),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: ListView.builder(
                            controller: controller.scrollController,
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
                                    child: ClassificacaoItem(veiculoModel: config),
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
