import 'fiscalizacao/fiscalizacao_controller.dart';
import 'package:fiscal/app/modules/peso/classificacao/classificacao_controller.dart';
import 'package:fiscal/app/modules/peso/classificacao/classificacao_page.dart';
import 'package:fiscal/app/modules/peso/fiscalizacao/fiscalizacao_controller.dart';
import 'package:fiscal/app/modules/peso/fiscalizacao/fiscalizacao_page.dart';
import 'peso_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'peso_page.dart';

class PesoModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $FiscalizacaoController,
        $ConfiguracoesController,
        $PesoController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => PesoPage()),
        ModularRouter('/configuracoes', child: (_, args) => ClassificacaoPage()),
        ModularRouter('/fiscalizacao', child: (_, args) => FiscalizacaoPage(fiscalizacao: args.data)),
      ];

  static Inject get to => Inject<PesoModule>.of();
}
