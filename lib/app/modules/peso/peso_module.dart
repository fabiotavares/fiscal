import 'package:fiscal/app/modules/peso/configuracoes/configuracoes_page.dart';

import 'configuracoes/configuracoes_controller.dart';
import 'peso_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'peso_page.dart';

class PesoModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $ConfiguracoesController,
        $PesoController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => PesoPage()),
        ModularRouter('/configuracoes', child: (_, args) => ConfiguracoesPage()),
      ];

  static Inject get to => Inject<PesoModule>.of();
}
