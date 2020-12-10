import 'package:fiscal/app/models/fiscalizacao_peso_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'fiscalizacao_controller.dart';

class FiscalizacaoPage extends StatefulWidget {
  final FiscalizacaoPesoModel fiscalizacao;
  final String title;

  const FiscalizacaoPage({Key key, this.title = "Fiscalizacao", this.fiscalizacao}) : super(key: key);

  @override
  _FiscalizacaoPageState createState() => _FiscalizacaoPageState();
}

class _FiscalizacaoPageState extends ModularState<FiscalizacaoPage, FiscalizacaoController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    super.initState();
    controller.getAutos(widget.fiscalizacao);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('${widget.title}'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Observer(builder: (_) {
          return ListView.builder(
            itemCount: controller.autos.length,
            itemBuilder: (context, index) => controller.autos[index].getAutoWidget(),
          );
        }),
      ),
    );
  }
}
