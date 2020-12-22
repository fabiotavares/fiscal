import 'package:fiscal/app/modules/peso/peso_module.dart';
import 'package:fiscal/app/modules/usuario/usuario_module.dart';
import 'home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $HomeController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => HomePage()),
        ModularRouter('/peso', module: PesoModule()),
        ModularRouter('/usuario', module: UsuarioModule()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
