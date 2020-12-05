import 'package:fiscal/app/models/usuario_model.dart';
import 'package:fiscal/app/repository/shared_prefs_repository.dart';
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
    final prefs = await SharedPrefsRepository.instance;
    final accessToken = prefs.accessToken;

    return accessToken != null;
  }
}
