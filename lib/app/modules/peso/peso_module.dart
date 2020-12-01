import 'package:fiscal/app/modules/peso/infracoes_peso/infracoes_peso_controller.dart';
import 'package:fiscal/app/modules/peso/infracoes_peso/infracoes_peso_page.dart';
import 'package:fiscal/app/modules/peso/configuracoes/configuracoes_page.dart';

import 'configuracoes/configuracoes_controller.dart';
import 'peso_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'peso_page.dart';

class PesoModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $InfracoesPesoController,
        $ConfiguracoesController,
        $PesoController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => PesoPage()),
        ModularRouter('/configuracoes', child: (_, args) => ConfiguracoesPage()),
        ModularRouter('/infracoes_peso', child: (_, args) => InfracoesPesoPage(fiscalizacao: args.data)),
      ];

  static Inject get to => Inject<PesoModule>.of();
}
