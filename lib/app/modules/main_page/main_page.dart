import 'package:fiscal/app/shared/auth_store.dart';
import 'package:fiscal/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();

    // necessário estar numa StatefulWidget para esse método funcionar bem
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        // inicializa o usuário do FirebaseAuth e o modelo local
        final authStore = Modular.get<AuthStore>();
        await authStore.initUser();

        if (authStore.isLogged()) {
          // serve pra matar esta página e tudo que tinha antes
          Modular.to.pushNamedAndRemoveUntil('/home', (_) => false);
        } else {
          // serve pra matar esta página e tudo que tinha antes
          Modular.to.pushNamedAndRemoveUntil('/login', (_) => false);
        }
      } catch (e) {
        // se ocorrer algum erro vai pra tela de login
        Modular.to.pushNamedAndRemoveUntil('/login', (_) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // inicializando o componente ScreenUtil
    ScreenUtil.init(context);
    ThemeUtils.init(context);

    return Scaffold(
      // backgroundColor: ThemeUtils.accentColor,
      body: Center(
        child: Image.asset(
          'lib/assets/images/logo.png',
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}
