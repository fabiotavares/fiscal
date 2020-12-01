import 'package:fiscal/app/components/get_double_number_dialog.dart';
import 'package:fiscal/app/components/theme_utils.dart';
import 'package:flutter/material.dart';

// componente que exibe um TextFormField com opções de somar ou subtrair um número
// mantendo a conta montada para exibição
class TextFormFieldSoma extends StatefulWidget {
  final TextEditingController controller;
  final String label;

  const TextFormFieldSoma({
    Key key,
    @required this.controller,
    @required this.label,
  }) : super(key: key);

  @override
  _TextFormFieldSomaState createState() => _TextFormFieldSomaState();
}

class _TextFormFieldSomaState extends State<TextFormFieldSoma> {
  final TextEditingController _valueController = new TextEditingController();
  List<double> _valoresSoma;
  String _contaMontada;

  @override
  void initState() {
    super.initState();
    _valoresSoma = [];
    _contaMontada = '';
  }

  void add(double value) {
    _valoresSoma.add(value);
    atualizaTotalSoma();
  }

  void remove() {
    if (_valoresSoma.isNotEmpty) {
      _valoresSoma.removeLast();
      atualizaTotalSoma();
    }
  }

  void atualizaTotalSoma() {
    String aux = '';
    double total = _valoresSoma.fold(0, (previousValue, element) {
      if (aux.isNotEmpty) {
        aux += ' + ';
      }
      aux += '$element';
      return previousValue + element;
    });

    if (total == 0.0) {
      widget.controller.text = '';
      aux = '';
    } else {
      widget.controller.text = total.toStringAsFixed(2);
    }

    setState(() {
      _contaMontada = aux;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          readOnly: true,
          controller: widget.controller,
          decoration: InputDecoration(
            labelText: widget.label,
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
                      remove();
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add_circle,
                      color: ThemeUtils.accentColor,
                    ),
                    onPressed: () {
                      GetDoubleNumberDialog.show(context: context, valueController: _valueController).then((value) {
                        if (_valueController.text.isNotEmpty) {
                          try {
                            add(double.parse(_valueController.text));
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
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0),
          child: Text(
            _contaMontada,
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
