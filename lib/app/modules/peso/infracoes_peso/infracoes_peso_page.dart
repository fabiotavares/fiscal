import 'package:fiscal/app/model/fiscalizacao_peso_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'infracoes_peso_controller.dart';

class InfracoesPesoPage extends StatefulWidget {
  final FiscalizacaoPesoModel fiscalizacao;
  final String title;
  const InfracoesPesoPage({Key key, this.title = "Infrações", @required this.fiscalizacao}) : super(key: key);

  @override
  _InfracoesPesoPageState createState() => _InfracoesPesoPageState(fiscalizacao);
}

class _InfracoesPesoPageState extends ModularState<InfracoesPesoPage, InfracoesPesoController> {
  //use 'controller' variable to access controller
  final FiscalizacaoPesoModel fiscalizacao;

  _InfracoesPesoPageState(this.fiscalizacao);

  @override
  Widget build(BuildContext context) {
    final infracoes = fiscalizacao.getInfracoes();

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('${widget.title}'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: ListView.builder(
          itemCount: infracoes.length,
          itemBuilder: (context, index) => infracoes[index].getInfracaoWidget(),
        ),
      ),
    );
  }
}
