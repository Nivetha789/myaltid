import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myaltid/reasuable/theme.dart';

class ProgressDialog {
  late AlertDialog alert;

  showLoaderDialog(BuildContext context) {
    alert = const AlertDialog(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color:buttoncolor),
        ],
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      barrierColor: const Color(0xBFFFFFFF),
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showWithoutBackgroundLoaderDialog(BuildContext context) {
    alert =const AlertDialog(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: buttoncolor),
        ],
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      barrierColor: const Color(0x01000000),
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  dismissDialog(BuildContext context) {
    Navigator.pop(context);
  }

}

