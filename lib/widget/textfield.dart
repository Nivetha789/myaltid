import 'package:flutter/material.dart';
import 'package:myaltid/reasuable/theme.dart';

InputDecoration buildInputDecoration(
  String hinttext,
) {
  return InputDecoration(
    hintText: hinttext,

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
    filled: true,
    hintStyle: const TextStyle(
        color: Color(0xffEBEBF5),
        fontFamily: "Helvatica",
        fontSize: 15,
        fontWeight: FontWeight.w400),
    fillColor: textfieldfilcolor,
    // errorText: texterror ? "Enter Correct Name" : null,
    errorStyle: const TextStyle(color: Colors.red),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: const BorderSide(
        color: Colors.red,
        width: 1.5,
      ),
    ),
  );
}
