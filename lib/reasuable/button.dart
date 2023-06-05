// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:myaltid/reasuable/theme.dart';

class ButtonScreen extends StatefulWidget {
  final buttontext;
  const ButtonScreen({
    super.key,
    this.buttontext,
  });

  @override
  State<ButtonScreen> createState() => _ButtonScreenState();
}

class _ButtonScreenState extends State<ButtonScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 50,
      decoration: BoxDecoration(
        color: buttoncolor,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        widget.buttontext,
        style: const TextStyle(
            color: blackcolor, fontSize: 15.0, fontWeight: FontWeight.w500),
      ),
    );
  }
}
