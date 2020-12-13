import 'package:fiscal/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class InfoDialog {
  static Future<bool> show({@required BuildContext context, @required String title, @required String msg}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(msg),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Ok',
                  style: TextStyle(color: ThemeUtils.accentColor),
                ),
                onPressed: () {
                  Modular.to.pop();
                },
              ),
            ],
          );
        });
  }
}
