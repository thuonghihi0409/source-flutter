import 'package:flutter/services.dart';

class ThousandsSeparatorFormatter extends TextInputFormatter {
  final String separator;
  ThousandsSeparatorFormatter({this.separator = ','});

  String format(String digits) {
    if (digits.isEmpty) return '';
    final sb = StringBuffer();
    int count = 0;
    for (int i = digits.length - 1; i >= 0; i--) {
      sb.write(digits[i]);
      count++;
      if (count == 3 && i != 0) {
        sb.write(separator);
        count = 0;
      }
    }
    return sb.toString().split('').reversed.join('');
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Giữ chỉ chữ số
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final formatted = format(digits);
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
      composing: TextRange.empty,
    );
  }
}
