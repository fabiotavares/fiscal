import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiscal/app/models/usuario_model.dart';
import 'package:fiscal/app/repository/shared_prefs_repository.dart';
import 'package:fiscal/app/shared/utils/internet_utils.dart';
import 'package:mobx/mobx.dart';
part 'auth_store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  @observable
  UsuarioModel usuarioLogado;

  @action
  Future<void> loadUsuario() async {
    final prefs = await SharedPrefsRepository.instance;
    usuarioLogado = prefs.userData;
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
    if (await InternetUtils.conexaoDisponivel()) {
      final idToken = await fireAuth.currentUser.getIdToken();
      final prefs = await SharedPrefsRepository.instance;
      prefs.registerAccessToken(idToken);
    }

    return true;
  }
}
