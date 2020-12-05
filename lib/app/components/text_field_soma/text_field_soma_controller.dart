import 'package:fiscal/app/utils/numbers.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

part 'text_field_soma_controller.g.dart';

@Injectable()
class TextFieldSomaController = _TextFieldSomaControllerBase with _$TextFieldSomaController;

abstract class _TextFieldSomaControllerBase with Store {
  @observable
  List<double> valoresSoma = [];

  @observable
  String contaMontada = '';

  @action
  void remove(TextEditingController controller) {
    if (valoresSoma.isNotEmpty) {
      valoresSoma.removeLast();
      atualizaTotalSoma(controller);
    }
  }

  @action
  void add(TextEditingController controller, double value) {
    valoresSoma.add(value);
    atualizaTotalSoma(controller);
  }

  @action
  void atualizaTotalSoma(TextEditingController controller) {
    String aux = '';
    double total = valoresSoma.fold(0, (previousValue, element) {
      if (aux.isNotEmpty) {
        aux += ' + ';
      }
      aux += '${Numbers.getDoubleFormatado(element)}';
      return previousValue + element;
    });

    if (total == 0.0) {
      controller.text = '';
      aux = '';
    } else {
      controller.text = Numbers.getDoubleFormatado(total);
    }

    contaMontada = aux;
  }
}
