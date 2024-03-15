import 'package:flutter/material.dart';
import 'package:myaltid/reasuable/theme.dart';

class ProgressDialogCall {
  late AlertDialog alert;

  showLoaderDialog(BuildContext context) {
    alert = AlertDialog(
      titlePadding: EdgeInsets.only(left: 50.0, right: 20.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      content: Container(
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          color: const Color(0xFFFFFF),
          borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
        ),
        height: MediaQuery.of(context).size.height / 5,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: buttoncolor,
            ),
            Container(
                margin: EdgeInsets.only(top: 20.0, left: 5),
                child: Text(
                  "You will get a call from your VMN 7825831988. Please pick the call to continue your conversation with the dialled number. Receiver will see your VMN in CLI. Charges will apply on your VMN and RMN as per your plan",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontFamily: "Helvetica",
                      fontWeight: FontWeight.w500),
                )),
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  dismissDialog(BuildContext context) {
    Navigator.pop(context);
  }
}