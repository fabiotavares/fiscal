import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'usuario_controller.dart';

class UsuarioPage extends StatefulWidget {
  final String title;
  const UsuarioPage({Key key, this.title = "Usuario"}) : super(key: key);

  @override
  _UsuarioPageState createState() => _UsuarioPageState();
}

class _UsuarioPageState extends ModularState<UsuarioPage, UsuarioController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
