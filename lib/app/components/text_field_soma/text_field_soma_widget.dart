import 'package:fiscal/app/components/get_double_number_dialog.dart';
import 'package:fiscal/app/components/text_field_soma/text_field_soma_controller.dart';
import 'package:fiscal/app/components/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class TextFieldSomaWidget extends StatelessWidget {
  // classe para persistir algumas informações na tela
  final TextFieldSomaController controller;
  // controle do total exibido e repassado para quem chamou
  final TextEditingController textFieldController;
  // controle apenas local para se obter um novo valor a ser somado
  final TextEditingController _newValue = TextEditingController();
  // rótulo a ser exibido
  final String label;

  TextFieldSomaWidget({
    Key key,
    @required this.controller,
    @required this.textFieldController,
    @required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          readOnly: true,
          controller: textFieldController,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(fontSize: 14),
            suffixIcon: Container(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.remove_circle,
                      color: ThemeUtils.theme.errorColor,
                    ),
                    onPressed: () {
                      controller.remove(textFieldController);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add_circle,
                      color: ThemeUtils.accentColor,
                    ),
                    onPressed: () {
                      GetDoubleNumberDialog.show(context: context, valueController: _newValue).then((value) {
                        if (_newValue.text.isNotEmpty) {
                          try {
                            controller.add(textFieldController, double.parse(_newValue.text));
                          } catch (e) {
                            // TODO
                          }
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Observer(builder: (_) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 4.0),
            child: Text(
              controller.contaMontada,
              style: TextStyle(color: Colors.grey),
            ),
          );
        }),
      ],
    );
  }
}