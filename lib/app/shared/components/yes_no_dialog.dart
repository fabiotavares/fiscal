import 'package:fiscal/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class YesNoDialog {
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
                child: Text(
                  'Não',
                  style: TextStyle(color: ThemeUtils.accentColor),
                ),
                onPressed: () {
                  Modular.to.pop(false);
                },
              ),
              FlatButton(
                child: Text(
                  'Sim',
                  style: TextStyle(color: ThemeUtils.accentColor),
                ),
                onPressed: () {
                  Modular.to.pop(true);
                },
              ),
            ],
          );
        });
  }
}
