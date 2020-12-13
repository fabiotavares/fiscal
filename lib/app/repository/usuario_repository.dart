import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiscal/app/models/usuario_model.dart';
import 'package:fiscal/app/repository/facebook_repository.dart';
import 'package:fiscal/app/repository/shared_prefs_repository.dart';
import 'package:flutter/material.dart';

class UsuarioRepository {
  Future<UsuarioModel> login(String email, {String senha, bool facebookLogin = false, String avatar = ''}) async {
    // fazendo login no Firebase
    final fireAuth = FirebaseAuth.instance;
    UsuarioModel usuarioModel;

    if (!facebookLogin) {
      // login com email e senha no firebase
      var res = await fireAuth.signInWithEmailAndPassword(email: email, password: senha);
      // criando dados do usuário para salvar depois
      usuarioModel = UsuarioModel(email: email, token: await res.user.getIdToken());
      //
    } else {
      // login através do facebook
      var facebookModel = await FacebookRepository().login();
      if (facebookModel != null) {
        // fazer login no firebase
        final facebookCredencial = FacebookAuthProvider.credential(facebookModel.token);
        var res = await fireAuth.signInWithCredential(facebookCredencial);
        // criando dados do usuário para salvar depois (id será o mesmo do FireAuth)
        usuarioModel = UsuarioModel(
          email: facebookModel.email,
          token: await res.user.getIdToken(),
          avatar: facebookModel.picture,
        );
        //
      }
    }

    return usuarioModel;
  }

  Future<UsuarioModel> recuperaDadosUsuarioLogado() async {
    final prefs = await SharedPrefsRepository.instance;
    return prefs.userData;
  }

  Future<void> logoutFireAuth() async {
    // desloga do Firebase se estiver ativo
    final fireAuth = FirebaseAuth.instance;
    fireAuth?.signOut();
  }

  Future<UsuarioModel> cadastrarUsuarioFireAuth({@required String email, @required String senha}) async {
    var fireAuth = FirebaseAuth.instance;
    final res = await fireAuth.createUserWithEmailAndPassword(email: email, password: senha);
    return UsuarioModel(
      email: email,
      token: await res.user.getIdToken(),
    );
  }

  // Future<void> cadastrarUsuarioBanco(UsuarioModel user) async {
  //   // verifica antes se o usuário já existe no Firestore...
  //   final consulta =
  //       await FirebaseFirestore.instance.collection('usuarios').where('email', isEqualTo: user.email).get();
  //   if (consulta.docs.isEmpty) {
  //     // cadastrar novo usuário passando o mesmo id do FireAuth
  //     await FirebaseFirestore.instance.collection('usuarios').doc(user.id).set(user.toJson());
  //   }
  // }

  Future<void> atualizarUsuarioBanco(UsuarioModel usuario) async {
    // atualiza usuario no banco de dados
    // await FirebaseFirestore.instance.collection('usuarios').doc(usuario.id).set(usuario.toJson());
    //todo:
  }

  Future<void> salvaUsuarioLocal(UsuarioModel user) async {
    // salva no dispositivo os dados do usuário
    final prefs = await SharedPrefsRepository.instance;
    await prefs.registerUserData(user);
  }
}
