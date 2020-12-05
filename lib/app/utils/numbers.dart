import 'package:flutter_money_formatter/flutter_money_formatter.dart';

enum SymbolPosition {
  none,
  left,
  rigth,
}

class Numbers {
  static String getDoubleFormatado(double value, {int digits = 2, String symbol = '', SymbolPosition position = SymbolPosition.left}) {
    final num = FlutterMoneyFormatter(
        amount: value,
        settings: MoneyFormatterSettings(
          symbol: symbol,
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: ' ',
          fractionDigits: digits,
        ));

    if (position == SymbolPosition.left) {
      return num.output.symbolOnLeft;
    }

    if (position == SymbolPosition.rigth) {
      return num.output.symbolOnRight;
    }

    return num.output.nonSymbol;
  }

  static String getPesoFormatado(double value) {
    final num = FlutterMoneyFormatter(
        amount: value,
        settings: MoneyFormatterSettings(
          symbol: 'kg',
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: ' ',
          fractionDigits: 2,
        ));

    return num.output.symbolOnRight;
  }

  static String getMoneyFormatado(double value) {
    final num = FlutterMoneyFormatter(
        amount: value,
        settings: MoneyFormatterSettings(
          symbol: 'R\$',
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: ' ',
          fractionDigits: 2,
        ));

    return num.output.symbolOnLeft;
  }
}
