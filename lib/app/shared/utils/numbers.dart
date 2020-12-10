import 'package:intl/intl.dart';

enum SymbolPosition {
  none,
  left,
  rigth,
}

class Numbers {
  static final _numFormatBr = NumberFormat(",##0.00#", "pt_BR");

  static String getDoubleFormatado(double value) {
    return _numFormatBr.format(value);
  }

  static String getPesoFormatado(double value) {
    return _numFormatBr.format(value) + ' kg';
  }

  static String getMoneyFormatado(double value) {
    return 'R\$ ' + _numFormatBr.format(value);
  }

  static String getDoubleNaoFormatado(String number) {
    // remove separador de milhar (.) e substitua decimal (,) por (.)
    return number.replaceAll('.', '').replaceAll(',', '.');
  }
}
