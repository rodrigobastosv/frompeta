import 'package:intl/intl.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

extension NumberExtension on String {
  String formatNumber() {
    return NumberFormat.currency(locale: 'pt_BR', symbol: '', decimalDigits: 0)
        .format(double.parse(this));
  }

  String formatCurrency() {
    return NumberFormat.currency(
            locale: 'pt_BR', symbol: 'R\$', decimalDigits: 2)
        .format(double.parse(this));
  }
}
