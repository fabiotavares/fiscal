import 'package:fiscal/app/shared/theme_utils.dart';
import 'package:fiscal/app/shared/utils/validador.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'cadastro_controller.dart';

class CadastroPage extends StatefulWidget {
  final String title;
  const CadastroPage({Key key, this.title = "Cadastrar Usuário"}) : super(key: key);

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends ModularState<CadastroPage, CadastroController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      //   // backgroundColor: ThemeUtils.primaryColor,
      //   elevation: 0,
      // ),
      // backgroundColor: ThemeUtils.primaryColor,
      body: SingleChildScrollView(
        child: Container(
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().screenHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 100.0, bottom: 30.0),
                // child: Text('Fiscal de Trânsito'),
                child: Image.asset(
                  'lib/assets/images/slogan.png',
                  width: ScreenUtil().screenWidth * .4,
                ),
              ),
              Stack(
                children: [
                  Center(
                    child: Container(
                      child: Container(
                        width: ScreenUtil().screenWidth * .9,
                        margin: const EdgeInsets.only(top: 60),
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0, bottom: 25.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Observer(
                          builder: (BuildContext context) {
                            return Form(
                              key: controller.formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: controller.loginController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      // fillColor e filled precisam ser configurados em conjunto
                                      fillColor: Colors.grey[200],
                                      filled: true,
                                      labelText: 'Email',
                                      labelStyle: TextStyle(fontSize: 15),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                        borderSide: BorderSide(color: Colors.grey[200]),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                        borderSide: BorderSide(color: Colors.grey[200]),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                        borderSide: BorderSide(color: Colors.grey[200]),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return 'Login obrigatório';
                                      } else if (!Validador.validEmail(value)) {
                                        return 'Login precisa ser um email';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  TextFormField(
                                    controller: controller.senhaController,
                                    obscureText: controller.ocultaSenha,
                                    decoration: InputDecoration(
                                      // fillColor e filled precisam ser configurados em conjunto
                                      fillColor: Colors.grey[200],
                                      filled: true,
                                      labelText: 'Senha',
                                      labelStyle: TextStyle(fontSize: 15),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                        borderSide: BorderSide(color: Colors.grey[200]),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                        borderSide: BorderSide(color: Colors.grey[200]),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                        borderSide: BorderSide(color: Colors.grey[200]),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: controller.ocultaSenha ? Icon(Icons.lock) : Icon(Icons.lock_open),
                                        onPressed: controller.toggleOcultaSenha,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return 'Senha obrigatória';
                                      } else if (value.length < 6) {
                                        return 'Senha precisa ter pelo menos 6 caracteres';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  TextFormField(
                                    controller: controller.confirmaSenhaController,
                                    obscureText: controller.ocultaSenha,
                                    decoration: InputDecoration(
                                      // fillColor e filled precisam ser configurados em conjunto
                                      fillColor: Colors.grey[200],
                                      filled: true,
                                      labelText: 'Confirma Senha',
                                      labelStyle: TextStyle(fontSize: 15),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                        borderSide: BorderSide(color: Colors.grey[200]),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                        borderSide: BorderSide(color: Colors.grey[200]),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                        borderSide: BorderSide(color: Colors.grey[200]),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return 'Confirma Senha obrigatória';
                                      } else if (value.length < 6) {
                                        return 'Confirma Senha precisa ter pelo menos 6 caracteres';
                                      } else if (value != controller.senhaController.text) {
                                        return 'Senha e Confirma Senha não são iguais';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      // alignment: Alignment.topCenter,
                      width: 90.0, //ScreenUtil().screenWidth * .2,
                      height: 90.0, //ScreenUtil().screenWidth * .2,
                      decoration: BoxDecoration(
                        color: ThemeUtils.accentColor, //Colors.blueGrey[200],
                        // image: DecorationImage(image: AssetImage('lib/assets/images/fundo2.png'), fit: BoxFit.cover),
                        // color: ThemeUtils.accentColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Image.asset('lib/assets/images/logo.png'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Container(
                width: ScreenUtil().screenWidth * .9,
                height: 45.0,
                child: FlatButton(
                  color: ThemeUtils.primaryColorDark,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                  child: Text(
                    'Cadastrar',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                    ),
                    textScaleFactor: ScreenUtil().scaleText,
                  ),
                  onPressed: controller.cadastrarUsuario,
                ),
              ),
              Expanded(child: SizedBox(height: 10)),
              Container(
                width: ScreenUtil().screenWidth * .9,
                height: 45.0,
                child: OutlineButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Text(
                    'Voltar',
                    style: TextStyle(
                      color: ThemeUtils.primaryColorDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                    ),
                    textScaleFactor: ScreenUtil().scaleText,
                  ),
                  onPressed: () => Modular.to.pop(),
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
