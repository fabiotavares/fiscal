import 'package:fiscal/app/core/exceptions/acesso_negado_dio_exceptions.dart';
import 'package:fiscal/app/core/exceptions/acesso_negado_firebase_exceptions.dart';
import 'package:fiscal/app/services/usuario_service.dart';
import 'package:fiscal/app/shared/components/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'login_controller.g.dart';

@Injectable()
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final UsuarioService _service;

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController loginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  _LoginControllerBase(this._service);

  @observable
  bool ocultaSenha = true;

  @action
  void toggleOcultaSenha() {
    ocultaSenha = !ocultaSenha;
  }

  @action
  Future<void> login() async {
    if (formKey.currentState.validate()) {
      try {
        Loader.show();
        await _service.login(facebookLogin: false, email: loginController.text, senha: senhaController.text);
        Loader.hide();
        // como tenho apenas a tela de login até aqui, essa chamada já vai eliminá-la
        Modular.to.pushReplacementNamed('/');
      } on AcessoNegadoDioException catch (e) {
        Loader.hide();
        print(e);
        Get.snackbar(
          'Erro',
          e.mensagem,
          barBlur: 50,
          backgroundGradient: LinearGradient(colors: [Colors.white, Colors.white]),
        );
      } on AcessoNegadoFirebaseException catch (e) {
        Loader.hide();
        print(e);
        Get.snackbar(
          'Erro',
          e.mensagem,
          barBlur: 50,
          backgroundGradient: LinearGradient(colors: [Colors.white, Colors.white]),
        );
      } catch (e) {
        Loader.hide();
        print('Erro: $e');
        Get.snackbar(
          'Erro',
          'Erro ao realizar login.',
          barBlur: 50,
          backgroundGradient: LinearGradient(colors: [Colors.white, Colors.white]),
        );
      }
    }
  }

  Future<void> facebookLogin() async {
    try {
      Loader.show();
      await _service.login(facebookLogin: true);
      Loader.hide();
      Modular.to.pushReplacementNamed('/');
    } on AcessoNegadoFirebaseException catch (e) {
      Loader.hide();
      print(e);
      Get.snackbar(
        'Erro',
        e.mensagem,
        barBlur: 50,
        backgroundGradient: LinearGradient(colors: [Colors.white, Colors.white]),
      );
    } catch (e) {
      Loader.hide();
      print('Erro: $e');
      Get.snackbar(
        'Erro',
        'Erro ao realizar login',
        barBlur: 50,
        backgroundGradient: LinearGradient(colors: [Colors.white, Colors.white]),
      );
    }
  }
}
