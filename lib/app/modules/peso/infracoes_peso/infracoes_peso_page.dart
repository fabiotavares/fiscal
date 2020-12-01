import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12.0),
        child: Container(
          width: ScreenUtil().screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: fiscalizacao.getInfracoes().map((e) => Text(e.toString())).toList(),
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
