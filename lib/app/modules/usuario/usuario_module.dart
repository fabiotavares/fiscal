import 'usuario_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'usuario_page.dart';

class UsuarioModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $UsuarioController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => UsuarioPage()),
      ];

  static Inject get to => Inject<UsuarioModule>.of();
}
