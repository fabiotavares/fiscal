import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiscal/app/models/usuario_model.dart';
import 'package:fiscal/app/repository/facebook_repository.dart';
import 'package:fiscal/app/repository/shared_prefs_repository.dart';
import 'package:fiscal/app/shared/auth_store.dart';
import 'package:fiscal/app/shared/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UsuarioRepository {
  Future<String> login(String email, {String senha, bool facebookLogin = false, String avatar = ''}) async {
    // fazendo login no Firebase
    final fireAuth = FirebaseAuth.instance;
    UserCredential res;

    if (!facebookLogin) {
      // login com email e senha no firebase
      res = await fireAuth.signInWithEmailAndPassword(email: email, password: senha);
      //
    } else {
      // login através do facebook
      var facebookModel = await FacebookRepository().login();
      if (facebookModel != null) {
        // fazer login no firebase
        final facebookCredencial = FacebookAuthProvider.credential(facebookModel.token);
        res = await fireAuth.signInWithCredential(facebookCredencial);
        // atualizar com a foto do facebook, caso já não exista outra deficida anteriormente
        print('### Foto geral do usuário via facebook: >${res.user.photoURL}<');
        // se for a foto genérica padrão do facebook, salve a do perfil no lugar
        if (res.user.photoURL == DEFAULT_URL_USER_PHOTO) {
          await res.user.updateProfile(photoURL: facebookModel.picture);
          res.user.reload();
        }
      }
    }
    return res.user.getIdToken();
  }

  Future<UsuarioModel> recuperaDadosUsuarioLogado() async {
    final prefs = await SharedPrefsRepository.instance;
    return prefs.userData;
  }

  Future<void> logoutFireAuth() async {
    print('### entrou em UsuarioRepository.logoutFireAuth');
    // desloga do Firebase se estiver ativo
    final fireAuth = FirebaseAuth.instance;
    fireAuth?.signOut();
  }

  Future<String> cadastrarUsuarioFireAuth({@required String email, @required String senha}) async {
    var fireAuth = FirebaseAuth.instance;
    final res = await fireAuth.createUserWithEmailAndPassword(email: email, password: senha);
    return res.user.getIdToken();
  }

  Future<void> atualizarProfile({String displayName, String photoURL}) async {
    // atualiza apenas os dados de profile
    var foto = photoURL;
    if (foto.trim().isEmpty) {
      // só pra marcar como sem foto (não encontrei mode de excluir)
      foto = '@';
    }

    final authStore = Modular.get<AuthStore>();
    await authStore.fireUser.updateProfile(displayName: displayName, photoURL: foto);
  }

  Future<void> salvarUsuarioLocal(UsuarioModel user) async {
    // salva no dispositivo os dados do usuário
    final prefs = await SharedPrefsRepository.instance;
    await prefs.registerUserData(user);
  }
}
