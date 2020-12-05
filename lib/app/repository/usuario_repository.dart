import 'dart:io';

import 'package:fiscal/app/core/dio/custom_dio.dart';
import 'package:fiscal/app/models/access_token_model.dart';
import 'package:fiscal/app/models/confirm_login_model.dart';
import 'package:fiscal/app/models/usuario_model.dart';
import 'package:fiscal/app/repository/shared_prefs_repository.dart';

class UsuarioRepository {
  Future<AccessTokenModel> login(String email, {String senha, bool facebookLogin = false, String avatar = ''}) {
    // login pelo facebook já implica em um cadastro automático
    // o avatar será a imagem do usuário, que pode vir do facebook

    // usando instance pois é apenas o login, onde obterei o token
    // apenas '/login' pois CustomDio já encapsula a base_url

    // fazendo login no backend
    return CustomDio.instance.post('/login', data: {
      'login': email,
      'senha': senha,
      'facebookLogin': facebookLogin,
      'avatar': avatar,
    }).then((res) => AccessTokenModel.fromJson(res.data));
  }

  // confirmando login
  Future<ConfirmLoginModel> confirmLogin() async {
    final prefs = await SharedPrefsRepository.instance;
    final deviceId = prefs.deviceId;

    // uso de 'patch' pois vai alterar um dado
    return CustomDio.authInstance.patch('/login/confirmar', data: {
      'ios_token': Platform.isIOS ? deviceId : null,
      'android_token': Platform.isAndroid ? deviceId : null,
    }).then((res) => ConfirmLoginModel.fromJson(res.data));
  }

  Future<UsuarioModel> recuperaDadosUsuarioLogado() {
    return CustomDio.authInstance.get('/usuario').then((res) => UsuarioModel.fromJson(res.data));
  }

  Future<void> cadastrarUsuario(String email, String senha) async {
    await CustomDio.instance.post('/login/cadastrar', data: {
      'email': email,
      'senha': senha,
    });
  }
}
