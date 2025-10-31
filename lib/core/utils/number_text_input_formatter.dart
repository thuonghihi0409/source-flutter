import 'package:flutter/services.dart';

/// A custom TextInputFormatter that only allows one or more digits (0-9) and allows deletion.
class NumberTextInputFormatter extends TextInputFormatter {
  final RegExp _numberRegExp = RegExp(r'^\d+$');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Allow deletion always
    if (newValue.text.length < oldValue.text.length) {
      return newValue;
    }
    // Check if new text consists only of one or more digits
    if (_numberRegExp.hasMatch(newValue.text)) {
      return newValue;
    }
    // Reject invalid input
    return oldValue;
  }
}
