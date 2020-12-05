import 'package:fiscal/app/modules/home/components/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
    return Scaffold(
      drawer: Drawer(),
      backgroundColor: Colors.grey[200],
      appBar: HomeAppBar(null),
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            InkWell(
              onTap: () async {
                Modular.to.pushNamed('/home/peso');
              },
              child: ListTile(
                leading: Icon(
                  FontAwesome.balance_scale,
                  size: 30,
                ),
                title: Text('Excesso de Peso'),
                subtitle: Text('Roteiro de fiscalização'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
