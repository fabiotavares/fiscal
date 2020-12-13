import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'usuario_controller.g.dart';

@Injectable()
class UsuarioController = _UsuarioControllerBase with _$UsuarioController;

abstract class _UsuarioControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
