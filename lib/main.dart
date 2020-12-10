import 'package:fiscal/app/core/push_notification/push_message_configure.dart';
import 'package:flutter/material.dart';
import 'package:fiscal/app/app_module.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  // método que força a inicialização do contexto antes do do runApp
  WidgetsFlutterBinding.ensureInitialized();
  // inicializando o firebase
  await Firebase.initializeApp();
  // forçando orientação retrato para o app como única opção
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // carregando variáveis de ambiente
  await loadEnv();
  // obtendo o device id e armazenando no SharedPreferences
  PushMessageConfigure().configure();

  runApp(ModularApp(module: AppModule()));
}

// carregando variáveis de ambiente
Future<void> loadEnv() async {
  // modo de saber se o app tá rodando em modo release
  const isProduction = bool.fromEnvironment('dart.vm.product');
  await DotEnv().load(isProduction ? '.env' : '.env_dev');
  // importante: base_url conforme a plataforma (rondando local)
  // Emulador iOS: http://localhost:8888 (ou http://127.0.0.1:8888)
  // Emulador Android: http://10.2.0.1:8888
  // Aparelho físico: endereço da máquina (no mac: http://192.168.31.168:8888)
}
