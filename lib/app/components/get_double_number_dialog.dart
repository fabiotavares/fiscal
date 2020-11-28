import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GetDoubleNumberDialog {
  static Future<Widget> show({@required BuildContext context, @required TextEditingController valueController}) {
    final GlobalKey<FormState> valueDialogForm = new GlobalKey<FormState>();
    FocusNode focus = FocusNode();
    focus.requestFocus();
    valueController.clear();

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Form(
              key: valueDialogForm,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: valueController,
                    decoration: const InputDecoration(
                      labelText: 'Digite um valor',
                    ),
                    focusNode: focus,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                    ],
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Digite algum valor';
                      }
                      if (double.tryParse(value) == 0.0) {
                        return 'Digite algum valor maior que zero';
                      }

                      return null;
                    },
                  )
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancelar'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  if (valueDialogForm.currentState.validate()) {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          );
        });
  }
}
