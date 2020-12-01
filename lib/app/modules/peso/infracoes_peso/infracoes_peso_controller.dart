import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'infracoes_peso_controller.g.dart';

@Injectable()
class InfracoesPesoController = _InfracoesPesoControllerBase with _$InfracoesPesoController;

abstract class _InfracoesPesoControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
