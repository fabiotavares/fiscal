import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiscal/app/shared/components/info_dialog.dart';
import 'package:fiscal/app/shared/theme_utils.dart';
import 'package:fiscal/app/shared/utils/validador.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      backgroundColor: ThemeUtils.accentColor,
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
            mainAxisAlignment: MainAxisAlignment.center,
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
                        // height: 240,
                        margin: const EdgeInsets.only(top: 60),
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0, bottom: 20.0),
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
                                  SizedBox(height: 10),
                                  InkWell(
                                    child: Text(
                                      'Esqueci a senha',
                                      style: TextStyle(color: ThemeUtils.primaryColorDark),
                                    ),
                                    onTap: () {
                                      // envia email para redefinição de senha
                                      final email = controller.loginController.text;
                                      if (email.trim().isNotEmpty && Validador.validEmail(email)) {
                                        try {
                                          // envia email para resetar senha
                                          FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                                          // informa sobre as cosnequências de alterar senha de login via facebool
                                          InfoDialog.show(
                                            context: context,
                                            title: 'Atenção',
                                            msg: '1) Se você fez login antes pelo facebook e trocar sua senha aqui, ' +
                                                'será preciso fornecer email e senha em cada novo login. Se quiser manter ' +
                                                'o login atual, faça a recuperação da senha no facebook;\n\n ' +
                                                '2) Em instantes você receberá no email cadastrado informações para ' +
                                                'alterar sua senha. Caso desista, basta ignorar a mensagem.',
                                          );
                                        } catch (e) {}
                                      } else {
                                        InfoDialog.show(
                                          context: context,
                                          title: 'Atenção',
                                          msg: 'Informe um email válido.',
                                        );
                                      }
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
                    'Entrar',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                    ),
                    textScaleFactor: ScreenUtil().scaleText,
                  ),
                  onPressed: controller.login,
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: ScreenUtil().screenWidth * .9,
                height: 45.0,
                child: FlatButton(
                  color: Color(0xFF4267B2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                  child: Text(
                    'Entrar com Facebook',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                    ),
                    textScaleFactor: ScreenUtil().scaleText,
                  ),
                  onPressed: controller.facebookLogin,
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
                    'Cadastrar',
                    style: TextStyle(
                      color: ThemeUtils.primaryColorDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                    ),
                    textScaleFactor: ScreenUtil().scaleText,
                  ),
                  onPressed: () => Modular.to.pushNamed('/login/cadastro'),
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

// class CustomClipPath extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     path.moveTo(0, size.height * 0.14);
//     path.quadraticBezierTo(size.width * 0.4, size.height * 0.14, size.width * 0.35, size.height * 0.14);
//     path.quadraticBezierTo(size.width * 0.5, size.height * 0.4, size.width * 0.65, size.height * 0.14);
//     path.lineTo(size.width, size.height * 0.14);
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//     path.lineTo(0, size.height * 0.14);
//     path.close();

//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }
