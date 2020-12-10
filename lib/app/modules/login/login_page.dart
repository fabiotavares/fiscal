import 'package:fiscal/app/services/usuario_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('Logar com email e senha...'),
              onPressed: () async {
                await Modular.get<UsuarioService>()
                    .login(facebookLogin: false, email: 'android@fabreder.com', senha: '123123');
                Modular.to.pushNamedAndRemoveUntil('/', (_) => false);
              },
            ),
            FlatButton(
              child: Text('Logar com Facebook...'),
              onPressed: () async {
                await Modular.get<UsuarioService>().login(facebookLogin: true);
                Modular.to.pushNamedAndRemoveUntil('/', (_) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
