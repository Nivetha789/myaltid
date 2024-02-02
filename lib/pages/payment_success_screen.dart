
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentSuccessScreen extends StatefulWidget {
  String booking;
  bool booking_status;
  String payment_message;
  String response_message;

  PaymentSuccessScreen(this.booking, this.booking_status, this.payment_message,
      this.response_message);

  @override
  PaymentSuccessScreenState createState() => PaymentSuccessScreenState();
}

class PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print(
            'Backbutton pressed (device or appbar button), do whatever you want.');

        //trigger leaving and use own data
        Navigator.of(context).pop({'path': "1"});

        //we need to return a future
        return Future.value(false);
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                child: Image.asset(
                  "assets/images/star_background.jpg",
                  fit: BoxFit.fitHeight,
                ),
              ),
              Container(
                color: Colors.white.withOpacity(0.8),
              ),
              Container(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(),
                      flex: 1,
                    ),
                    Expanded(
                      child: Container(),
                      flex: 1,
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: Text(
                          widget.booking,
                          style: TextStyle(
                              color: widget.booking_status
                                  ? Colors.green
                                  : Colors.red,
                              fontSize: 28.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2),
                        ),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Container(
                        child: Image.asset(widget.booking_status
                            ? "assets/images/payment_cancel.jpg"
                            : "assets/images/payment_cancel.jpg"),
                      ),
                      flex: 5,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(),
                              flex: 3,
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      child: Text(
                                        widget.payment_message,
                                        style: TextStyle(
                                            color: Color(0xff495271),
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top:10.0,left:10.0,right: 10.0),
                                        child: Text(
                                          widget.response_message,
                                          style: TextStyle(
                                              color: Color(0xff495271),
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w400),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              flex: 2,
                            ),

                            Expanded(
                              child: InkWell(
                                onTap: () {
                                 Navigator.pop(context);
                                  // Navigator.pushReplacement(
                                  //     context,
                                  //     CupertinoPageRoute(
                                  //         builder: (BuildContext
                                  //                 context) =>
                                  //             MyVideoConsultationScreen()));
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width:
                                  MediaQuery.of(context).size.width,
                                  color: widget.booking_status
                                      ? Color(0xff388E3C)
                                      : Color(0xffd50000),
                                  child: Text(
                                    "Go to Back",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              flex: 1,
                            ),
                          ],
                        ),
                      ),
                      flex: 7,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
