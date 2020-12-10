import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiscal/app/core/exceptions/fiscal_exceptions.dart';
import 'package:fiscal/app/models/access_token_model.dart';
import 'package:fiscal/app/models/usuario_model.dart';
import 'package:fiscal/app/repository/facebook_repository.dart';
import 'package:fiscal/app/repository/shared_prefs_repository.dart';

class UsuarioRepository {
  Future<AccessTokenModel> login(String email, {String senha, bool facebookLogin = false, String avatar = ''}) async {
    // fazendo login no Firebase
    final fireAuth = FirebaseAuth.instance;
    AccessTokenModel accessTokenModel;
    UsuarioModel usuarioModel;

    if (!facebookLogin) {
      // login com email e senha no firebase
      var res = await fireAuth.signInWithEmailAndPassword(email: email, password: senha);
      // criando dados do usuário para salvar depois
      accessTokenModel = AccessTokenModel(await res.user.getIdToken());
      usuarioModel = UsuarioModel(email: email);
      //
    } else {
      // login através do facebook
      var facebookModel = await FacebookRepository().login();
      if (facebookModel != null) {
        // login no firebase
        final facebookCredencial = FacebookAuthProvider.credential(facebookModel.token);
        var res = await fireAuth.signInWithCredential(facebookCredencial);
        accessTokenModel = AccessTokenModel(await res.user.getIdToken());
        // criando dados do usuário para salvar depois
        usuarioModel = UsuarioModel(email: facebookModel.email, imgAvatar: facebookModel.picture);
        //
      } else {
        throw AcessoNegadoException('Acesso Negado');
      }
    }
    // salva dados do usuário logado
    final prefs = await SharedPrefsRepository.instance;
    await prefs.registerUserData(usuarioModel);

    return accessTokenModel;
  }

  Future<UsuarioModel> recuperaDadosUsuarioLogado() async {
    final prefs = await SharedPrefsRepository.instance;
    return prefs.userData;
  }

  Future<void> logout() async {
    // desloga do Firebase se estiver ativo
    final fireAuth = FirebaseAuth.instance;
    fireAuth?.signOut();

    // limpa dados internos e volta para tela de login
    final prefs = await SharedPrefsRepository.instance;
    prefs.logout();
  }
}
