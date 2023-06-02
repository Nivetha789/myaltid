import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class MobileNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final filteredValue = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    return newValue.copyWith(text: filteredValue);
  }
}

class MobileNumberInputFormatter1 extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final filteredValue = newValue.text.replaceAll(RegExp(r'^(9|8|7|6)'), '');
    return newValue.copyWith(text: filteredValue);
  }
}

class NameInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final filteredValue =
        newValue.text.replaceAll(RegExp(r'^[a-zA-Z]+(?: [a-zA-Z]+)?$'), '');
    return newValue.copyWith(text: filteredValue);
  }
}

class singleNameInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;

    // Remove any special characters
    newText = newText.replaceAll(RegExp(r'[^\w\s]+'), '');

    // Remove leading and trailing spaces
    newText = newText.trim();

    // Replace multiple spaces with a single space
    newText = newText.replaceAll(RegExp(r'\s+'), ' ');

    // If the input has changed, update the text editing value
    if (newText != newValue.text) {
      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }

    return newValue;
  }
}
