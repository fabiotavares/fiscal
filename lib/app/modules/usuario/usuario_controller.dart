import 'package:fiscal/app/services/usuario_service.dart';
import 'package:fiscal/app/shared/components/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'usuario_controller.g.dart';

@Injectable()
class UsuarioController = _UsuarioControllerBase with _$UsuarioController;

abstract class _UsuarioControllerBase with Store {
  final UsuarioService _service;

  GlobalKey<FormState> formKey = GlobalKey();
  var nomeController = TextEditingController();
  var avatarController = TextEditingController();
  var oldSenhaController = TextEditingController();
  var newSenhaController = TextEditingController();
  var confirmNewSenhaController = TextEditingController();

  _UsuarioControllerBase(this._service);

  @observable
  bool urlValida = true;

  @action
  void setUrlValida(bool value) {
    urlValida = value;
  }

  @action
  Future<void> atualizarProfile() async {
    if (formKey.currentState.validate()) {
      try {
        Loader.show();
        // salve o usuário logado com os dados atuais
        await _service.atualizarProfile(displayName: nomeController.text, photoURL: avatarController.text);
        Loader.hide();
        // mostre mensagem de sucesso e fecha a tela
        Modular.to.pop();
        Get.snackbar(
          'Sucesso',
          'Usuário atualizado com sucesso.',
          barBlur: 50,
          backgroundGradient: LinearGradient(colors: [Colors.white, Colors.white]),
          duration: Duration(seconds: 2),
        );
        //
      } catch (e) {
        Loader.hide();
        Get.snackbar(
          'Erro',
          'Erro ao atualizar usuário',
          barBlur: 50,
          backgroundGradient: LinearGradient(colors: [Colors.white, Colors.white]),
        );
        print('Erro ao atualizar usuário: $e');
      }
    }
  }
}
