import 'package:fiscal/app/components/home_appbar.dart';
import 'package:fiscal/app/components/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Fiscal de Trânsito"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    ThemeUtils.init(context);

    return Scaffold(
      drawer: Drawer(),
      backgroundColor: Colors.grey[300],
      appBar: HomeAppBar(null),
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            InkWell(
              onTap: () => Modular.to.pushNamed('/peso'),
              child: ListTile(
                leading: Icon(
                  FontAwesome.balance_scale,
                  size: 30,
                ),
                title: Text('Fiscalização de Peso'),
                subtitle: Text('Balança ou nota fiscal'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
