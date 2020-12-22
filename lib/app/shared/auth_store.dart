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
  User fireUser;

  @observable
  UsuarioModel usuarioLogado;

  Future<void> initUser() async {
    // inicializa o usuário remoto
    final fireAuth = FirebaseAuth.instance;
    fireUser = fireAuth.currentUser;
    // inicializa o usuário model logado
    await updateUsuarioLogado();
    // ouvinte para quando o estado do usuário mudar
    // todo: pensar no caso dele deslogar remotamente, ou mudar a senha do provider...
    fireAuth.authStateChanges().listen((user) async {
      print('### Entrou em authStateChanges');
      fireUser = user;
      // updateUsuarioLogado();
    });
  }

  @action
  Future<void> updateUsuarioLogado() async {
    // faz reload se tiver acesso à internet
    if (fireUser != null && await InternetUtils.conexaoDisponivel()) {
      try {
        await fireUser.reload();
        fireUser = FirebaseAuth.instance.currentUser;
        // salva token...
        final prefs = await SharedPrefsRepository.instance;
        prefs.registerAccessToken(await fireUser.getIdToken());
      } catch (e) {}
    }

    // cria novo modelo com base no fireUser atual
    if (fireUser != null) {
      usuarioLogado = UsuarioModel(
        email: fireUser.email,
        nome: fireUser.displayName,
        avatar: fireUser.photoURL,
      );
      print('### Foto no updateUsuarioLogado: >${fireUser.photoURL}<');

      // registrar localmente
      await registerUsuario();
    }
  }

  @action
  Future<void> loadUsuarioDispositivo() async {
    final prefs = await SharedPrefsRepository.instance;
    usuarioLogado = prefs.userData;
  }

  Future<void> registerUsuario() async {
    if (usuarioLogado != null) {
      final prefs = await SharedPrefsRepository.instance;
      prefs.registerUserData(usuarioLogado);
    }
  }

  @action
  bool isLogged() {
    return fireUser != null;
  }

  @action
  Future<bool> isProviderFacebook() async {
    if (fireUser != null) {
      return fireUser.providerData[0].providerId == 'facebook.com';
    }
    // retorna null se não tiver logado
    return null;
  }

  @action
  Future<bool> isProviderPassword() async {
    if (fireUser != null) {
      return fireUser.providerData[0].providerId == 'password';
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
