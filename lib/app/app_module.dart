import 'package:fiscal/app/modules/login/login_module.dart';
import 'package:fiscal/app/modules/main_page/main_page.dart';
import 'package:fiscal/app/repository/auto_repository.dart';
import 'package:fiscal/app/repository/gravidade_repository.dart';
import 'package:fiscal/app/repository/infracao_repository.dart';
import 'package:fiscal/app/repository/usuario_repository.dart';
import 'package:fiscal/app/services/auto_service.dart';
import 'package:fiscal/app/services/gravidade_service.dart';
import 'package:fiscal/app/services/infracao_service.dart';
import 'package:fiscal/app/services/usuario_service.dart';
import 'package:fiscal/app/shared/auth_store.dart';

import 'app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:fiscal/app/app_widget.dart';
import 'package:fiscal/app/modules/home/home_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        $AppController,
        // autenticação
        Bind((i) => AuthStore()),
        Bind((i) => UsuarioRepository()),
        Bind((i) => UsuarioService(i.get())),
        Bind((i) => AutoRepository()),
        Bind((i) => AutoService(i.get())),
        Bind((i) => GravidadeRepository()),
        Bind((i) => GravidadeService(i.get())),
        Bind((i) => InfracaoRepository()),
        Bind((i) => InfracaoService(i.get())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (context, args) => MainPage()),
        ModularRouter('/home', module: HomeModule()),
        ModularRouter('/login', module: LoginModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
