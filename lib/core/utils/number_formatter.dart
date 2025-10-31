import 'package:intl/intl.dart';

class NumberFormatter {
  static String formatDecimal(num value, {int maxFractionDigits = 3}) {
    if (value is int || value % 1 == 0) {
      return value.toInt().toString();
    }

    final formatter = NumberFormat()
      ..minimumFractionDigits = 1
      ..maximumFractionDigits = maxFractionDigits;

    return formatter.format(value);
  }

  static String formatCurrency(num value, String? symbol) {
    final formattedValue = formatDecimal(value);
    return '$formattedValue${symbol != null ? ' $symbol' : ''}';
  }
}
