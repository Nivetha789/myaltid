import 'package:flutter/services.dart';

class MobileNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final filteredValue = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    return newValue.copyWith(text: filteredValue);
  }
}