import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SimOuNaoDialog {
  static Future<bool> show({@required BuildContext context, @required String msg}) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Atenção'),
            content: Text(msg),
            actions: <Widget>[
              FlatButton(
                child: Text('Não'),
                onPressed: () {
                  Modular.to.pop(false);
                },
              ),
              FlatButton(
                child: Text('Sim'),
                onPressed: () {
                  Modular.to.pop(true);
                },
              ),
            ],
          );
        });
  }
}
