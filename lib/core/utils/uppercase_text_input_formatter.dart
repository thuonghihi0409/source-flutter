import 'package:flutter/services.dart';

/// A custom TextInputFormatter that converts all letters to uppercase and only allows letters and spaces.
class UpperCaseTextInputFormatter extends TextInputFormatter {
  final RegExp _letterRegExp = RegExp(r'[a-zA-Z]');
  final RegExp _textRegExp = RegExp(r'^[A-Z\s]*$');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String newText = newValue.text.replaceAllMapped(_letterRegExp, (
      match,
    ) {
      return match.group(0)!.toUpperCase();
    });
    // Allow deletion always
    if (newValue.text.length < oldValue.text.length) {
      return newValue.copyWith(text: newText);
    }
    final hasMatchTextReg = _textRegExp.hasMatch(newText);
    if (!hasMatchTextReg) {
      return oldValue;
    }
    return newValue.copyWith(text: newText);
  }
}
