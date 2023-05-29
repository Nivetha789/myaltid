import 'package:flutter/services.dart';

class PANFormatter extends TextInputFormatter {
  final RegExp _panPattern = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final formattedText = newValue.text.toUpperCase();
    final isValid = _panPattern.hasMatch(formattedText);

    if (formattedText != newValue.text || !isValid) {
      return TextEditingValue(
        text: formattedText,
        selection: newValue.selection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}
