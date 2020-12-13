import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiscal/app/models/usuario_model.dart';
import 'package:fiscal/app/repository/shared_prefs_repository.dart';
import 'package:fiscal/app/services/usuario_service.dart';
import 'package:fiscal/app/shared/utils/internet_utils.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'auth_store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  @observable
  UsuarioModel usuarioLogado;

  @action
  Future<void> loadUsuario() async {
    usuarioLogado = await Modular.get<UsuarioService>().recuperaDadosUsuarioLogado();
  }

  @action
  Future<void> teste() async {
    usuarioLogado = UsuarioModel(email: 'teste@gmail.com', nome: 'Fábio Tavares');
  }

  @action
  Future<bool> isLogged() async {
    // final prefs = await SharedPrefsRepository.instance;
    // final accessToken = prefs.accessToken;
    // return accessToken != null;

    // verifica se o usuário corrente está nulo
    final fireAuth = FirebaseAuth.instance;
    if (fireAuth.currentUser == null) {
      return false;
    }

    // atualiza token se internet disponível
    if (await InternetUtils.conexaoDisponivel() && fireAuth.currentUser != null) {
      final idToken = await fireAuth.currentUser.getIdToken();
      final prefs = await SharedPrefsRepository.instance;
      prefs.registerAccessToken(idToken);
    }

    return true;
  }

  @action
  Future<bool> isProviderFacebook() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.providerData[0].providerId == 'facebook.com';
    }
    // retorna null se não tiver logado
    return null;
  }

  @action
  Future<bool> isProviderPassword() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.providerData[0].providerId == 'password';
    }
    // retorna null se não tiver logado
    return null;
  }

  @action
  Future<void> logout() async {
    usuarioLogado = null;
    Modular.get<UsuarioService>().logout();
  }
}
