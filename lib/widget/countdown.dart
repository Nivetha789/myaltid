// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myaltid/reasuable/theme.dart';

class OtpTimer extends StatefulWidget {
  const OtpTimer({super.key});

  @override
  _OtpTimerState createState() => _OtpTimerState();
}

class _OtpTimerState extends State<OtpTimer> {
  final interval = const Duration(seconds: 2);

  final int timerMaxSeconds = 120;

  int currentSeconds = 0;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 120).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 120).toString().padLeft(2, '0')}';

  startTimeout([int? milliseconds]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      setState(() {
        debugPrint(timer.tick.toString());
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) timer.cancel();
        debugPrint("currentSeconds$currentSeconds");
      });
    });
  }

  @override
  void initState() {
    startTimeout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          timerText,
          style:const TextStyle(color: buttoncolor),
        )
      ],
    );
  }
}
