// ignore_for_file: prefer_typing_uninitialized_variables, unrelated_type_equality_checks, use_build_context_synchronously, non_constant_identifier_names

import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myaltid/data/api.dart';
import 'package:myaltid/pages/calls/calllist.dart';
import 'package:myaltid/pages/kyc.dart';
import 'package:myaltid/pages/selectplan.dart';
import 'package:myaltid/pages/services.dart';
import 'package:myaltid/widget/sharedpreference.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

import '../reasuable/background_screen.dart';
import '../reasuable/button.dart';
import '../reasuable/theme.dart';
import 'activeuserhome.dart';
import 'alternateid.dart';

class SendOTPScreen extends StatefulWidget {
  final phonenumber, name, refferalcode, signup;

  const SendOTPScreen(
      {super.key, this.phonenumber, this.name, this.refferalcode, this.signup});

  @override
  State<SendOTPScreen> createState() => _SendOTPScreenState();
}

class _SendOTPScreenState extends State<SendOTPScreen> {
  OtpFieldController otpController = OtpFieldController();
  TextEditingController textEditingController = TextEditingController();

  bool isconfirmloading = false;

  bool isChecked = false,
      confirmotp = false,
      otpfield = false,
      errorfield = false,
      agreeterm = false;
  var otp;

  @override
  void initState() {
    SendOTP();
    startTimeout();
    super.initState();
  }

  final interval = const Duration(seconds: 1);

  final int timerMaxSeconds = 180;

  int currentSeconds = 0;

  String get timerText {
    if (currentSeconds >= timerMaxSeconds) {
      return '00:00';
    } else {
      return '${((timerMaxSeconds - currentSeconds) ~/ 180).toString().padLeft(2, '0')}:${((timerMaxSeconds - currentSeconds) % 180).toString().padLeft(2, '0')}';
    }
  }

  // '${((timerMaxSeconds - currentSeconds) ~/ 180).toString().padLeft(2, '0')}:${((timerMaxSeconds - currentSeconds) % 180).toString().padLeft(2, '0')}';

  startTimeout([int? milliseconds]) {
    print("sdfhdfjhgsdfjhgsdf $timerText");
    var duration = interval;
    Timer.periodic(duration, (timer) {
      setState(() {
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) timer.cancel();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Backgroundscreen(
      ccontainerchild: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 120,
              ),
              Image.asset("assets/images/myaltidlogo.png"),
              const Text(
                "Privacy Matters",
                style: TextStyle(
                    color: Color(0xff55B780),
                    fontFamily: "Helvatica",
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Enter OTP",
                style: TextStyle(
                    fontFamily: "Helvatica",
                    color: whitecolor,
                    fontWeight: FontWeight.w700,
                    fontSize: 28),
              ),
              const SizedBox(
                height: 40,
              ),
              Column(
                children: [
                  OTPTextField(
                    controller: otpController,
                    length: 4,
                    width: MediaQuery.of(context).size.width,
                    fieldWidth: 50,
                    fieldStyle: FieldStyle.box,
                    style: const TextStyle(
                        color: whitecolor,
                        fontSize: 15,
                        fontFamily: "Helvatica",
                        fontWeight: FontWeight.w500),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    onCompleted: (pin) {
                      setState(() {
                        otpfield = true;
                        otp = pin;
                      });
                      debugPrint("Completed: $pin");
                    },
                    otpFieldStyle: OtpFieldStyle(
                      borderColor: const Color(0xff1C1C1E),
                      backgroundColor: const Color(0xff1C1C1E),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  errorfield == true
                      ? const Text(
                          "Please Enter OTP",
                          style: TextStyle(color: Colors.red),
                        )
                      : const Text(""),
                  Text(
                    "OTP has been sent to +91 ${widget.phonenumber}",
                    style: const TextStyle(
                        fontFamily: "Helvatica",
                        color: whitecolor,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        // fontStyle: FontStyle.italic,
                        fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Edit Number',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: buttoncolor),
                        ),
                      ),
                      timerText == "00:00"
                          ? InkWell(
                              onTap: () {
                                ResendOTP();
                              },
                              child: const Row(
                                children: [
                                  Text(
                                    'Retry Now ',
                                    style: TextStyle(color: buttoncolor),
                                  ),
                                ],
                              ),
                            )
                          : Row(
                              children: [
                                const Text(
                                  'Retry after ',
                                  style: TextStyle(color: whitecolor),
                                ),
                                Text(
                                  timerText == "01:00" ? "00:180" : timerText,
                                  style: const TextStyle(color: buttoncolor),
                                ),
                                const Text(
                                  ' sec',
                                  style: TextStyle(color: whitecolor),
                                ),
                              ],
                            ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  widget.signup == "signup"
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              hoverColor: buttoncolor,

                              fillColor: isChecked
                                  ? MaterialStateProperty.all<Color>(
                                      buttoncolor)
                                  : MaterialStateProperty.all<Color>(
                                      whitecolor),
                              checkColor: whitecolor,
                              //   fillColor: Colors.white,
                              // overlayColor:
                              //     MaterialStateProperty.all<Color>(whitecolor),
                              // fillColor: Color(0xFF0970d6),
                              activeColor: buttoncolor,
                              value: isChecked,
                              onChanged: (value) {
                                isChecked = !isChecked;
                                setState(() {
                                  debugPrint("DFDDGDFGDFGFD $isChecked");
                                });
                              },
                            ),
                            const Text.rich(
                              TextSpan(
                                text: 'I agree with ',
                                style:
                                    TextStyle(fontSize: 15, color: whitecolor),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'terms & conditions',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontSize: 15,
                                          color: Color(0xffE4C793))),
                                  // can add more TextSpans here...
                                ],
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  agreeterm == true
                      ? const Text(
                          "Please accept agree & terms conditions",
                          style: TextStyle(color: Colors.red),
                        )
                      : const Text(""),
                  const SizedBox(
                    height: 70,
                  ),
                  widget.signup == "signup"
                      ? Column(
                          children: [
                            otpfield == true && isChecked == true
                                ? InkWell(
                                    onTap: isconfirmloading == false
                                        ? () {
                                            debugPrint("PAVITHRA");
                                            setState(() {
                                              isconfirmloading = true;
                                            });
                                            VerifyOTP();
                                          }
                                        : () {},
                                    child: const ButtonScreen(
                                      buttontext: "Confirm",
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      debugPrint("PAVITHRA12");
                                      if (otpfield == false &&
                                          isChecked == false) {
                                        setState(() {
                                          confirmotp = false;
                                          errorfield = true;
                                          agreeterm = true;
                                        });
                                      } else if (otpfield == false) {
                                        confirmotp = false;
                                        errorfield = true;
                                        agreeterm = false;
                                      } else {
                                        confirmotp = false;
                                        errorfield = false;
                                        agreeterm = true;
                                      }

                                      // Navigator.of(context).push(
                                      //   MaterialPageRoute(
                                      //       builder: (context) => const SendOTPScreen()),
                                      // );
                                    },
                                    child: const ButtonScreen(
                                      buttontext: "Confirm",
                                    ),
                                  ),
                          ],
                        )
                      : Column(
                          children: [
                            otpfield == true
                                ? InkWell(
                                    onTap: isconfirmloading == false
                                        ? () {
                                            debugPrint("PAVITHRA");
                                            setState(() {
                                              isconfirmloading = true;
                                            });
                                            VerifyOTP();
                                          }
                                        : () {},
                                    child: const ButtonScreen(
                                      buttontext: "Confirm",
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      debugPrint("PAVITHRA12");

                                      setState(() {
                                        confirmotp = false;
                                        errorfield = true;
                                      });

                                      // Navigator.of(context).push(
                                      //   MaterialPageRoute(
                                      //       builder: (context) => const SendOTPScreen()),
                                      // );
                                    },
                                    child: const ButtonScreen(
                                      buttontext: "Confirm",
                                    ),
                                  ),
                          ],
                        ),
                ],
              )
              // : Column(
              //     children: [
              //       OTPTextField(
              //         length: 4,
              //         width: MediaQuery.of(context).size.width,
              //         fieldWidth: 50,
              //         fieldStyle: FieldStyle.box,
              //         style: const TextStyle(
              //             color: blackcolor,
              //             fontSize: 15,
              //             fontFamily: "Helvatica",
              //             fontWeight: FontWeight.w500),
              //         textFieldAlignment: MainAxisAlignment.spaceAround,
              //         onCompleted: (pin) {
              //           //   debugPrint("Completed: " + pin);
              //         },
              //         otpFieldStyle: OtpFieldStyle(
              //           borderColor: const Color(0xff1C1C1E),
              //           backgroundColor: const Color(0xff1C1C1E),
              //         ),
              //       ),
              //       const SizedBox(
              //         height: 30,
              //       ),
              //       const Text(
              //         "OTP has been sent to +91 1234567890",
              //         style: TextStyle(
              //             fontFamily: "Helvatica",
              //             color: whitecolor,
              //             fontWeight: FontWeight.w400,
              //             fontStyle: FontStyle.normal,
              //             // fontStyle: FontStyle.italic,
              //             fontSize: 14),
              //         textAlign: TextAlign.center,
              //       ),
              //       const SizedBox(
              //         height: 20,
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: const [
              //           Text(
              //             'Edit Number',
              //             style: TextStyle(
              //                 decoration: TextDecoration.underline,
              //                 color: buttoncolor),
              //           ),
              //           Text(
              //             'Resend OTP',
              //             style: TextStyle(
              //                 decoration: TextDecoration.underline,
              //                 color: buttoncolor),
              //           ),
              //         ],
              //       ),
              //       const SizedBox(
              //         height: 30,
              //       ),
              // InkWell(
              //   onTap: () {
              //     Navigator.of(context).push(
              //       MaterialPageRoute(
              //           builder: (context) => const ServiceApp()),
              //     );
              //   },
              //         child: const ButtonScreen(
              //           buttontext: "Confirm OTP",
              //         ),
              //       ),
              //     ],
              //   ),
            ],
          ),
        ),
      ),
    );
  }

  SendOTP() async {
    try {
      Dio dio = Dio();

      var parameters = {"n_Mobile": widget.phonenumber};
      dio.options.contentType = Headers.formUrlEncodedContentType;
      final response = await dio.post(
        ApiProvider.sendotp,
        data: parameters,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      debugPrint("pavithra ${response.data}");

      if (response.statusCode == 401) {
      } else if (response.statusCode == 200) {
        textEditingController.text = response.data["data"][0].toString();
        final snackBar =
            //  SnackBar(
            //   backgroundColor: Colors.green,
            //   content: Text('Your OTP is ! ${response.data["data"][0]}'),
            //   duration: const Duration(seconds: 2),
            // );
            // ScaffoldMessenger.of(context).showSnackBar(snackBar);
            SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Oh Hey!',
            message: 'Your OTP is ! ${response.data["data"][0]}',
            contentType: ContentType.success,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        // Navigator.of(context).push(
        //   MaterialPageRoute(builder: (context) => const Congratulations()),
        // );
      } else {
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'On Snap!',
            message: 'Please enter valid otp!',
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  VerifyOTP() async {
    try {
      Dio dio = Dio();

      var parameters = {"n_Mobile": widget.phonenumber, "n_Otp": otp};
      dio.options.contentType = Headers.formUrlEncodedContentType;
      final response = await dio.post(
        ApiProvider.verifyotp,
        data: parameters,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      debugPrint("verifyOtpRes: ${response.data}");
      if (response.statusCode == 401) {
      } else if (response.statusCode == 200) {
        if (response.data["status"] == 1) {
          await SharedPreference().setphonenumber(widget.phonenumber!);
          if (response.data["data"][0]["c_Name"].toString().isNotEmpty) {
            await SharedPreference()
                .setuserName(response.data["data"][0]["c_Name"].toString());
          } else {
            await SharedPreference().setuserName(widget.name);
          }
          await SharedPreference().setrefferalcode(widget.refferalcode!);
          await SharedPreference()
              .settoken(response.data["data"][0]["c_accessToken"]);

          print("widget.signup " + widget.signup.toString());
          await SharedPreference().setNStatus(response.data["data"][0]["n_Status"].toString());

          if (widget.signup != "signup") {
            setState(() {
              isconfirmloading = false;
            });
            if (response.data["data"][0]["n_Status"] == 3) {
              setState(() {
                isconfirmloading = false;
              });
              final snackBar = SnackBar(
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'On Snap!',
                  message: 'Please contact your admin',
                  contentType: ContentType.failure,
                ),
              );

              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);
            } else if (response.data["data"][0]["n_Status"] == 1) {
              setState(() {
                isconfirmloading = false;
              });
              await SharedPreference().setLogin("2");
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => ServiceApp()),
                      (Route<dynamic> route) => false);
            } else {
              print("paymentttt "+response.data["data"][0]["n_Payment"].toString());
              print("n_Kyc "+response.data["data"][0]["n_Kyc"].toString());
              print("n_Virtual "+response.data["data"][0]["n_Virtual"].toString());
              if (response.data["data"][0]["n_Payment"] == 2 &&
                  response.data["data"][0]["n_Kyc"] == 1) {
                //kyc incomplete
                await SharedPreference().setLogin("3");
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => KycScreen()),
                    (Route<dynamic> route) => false);
              } else if (response.data["data"][0]["n_Payment"] == 2 &&
                  response.data["data"][0]["n_Virtual"] == 2 && response.data["data"][0]["n_Kyc"]==1) {
                //kyc incomplete
                await SharedPreference().setLogin("3");
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => KycScreen()),
                    (Route<dynamic> route) => false);
              } else if (response.data["data"][0]["n_Payment"] == 1 &&
                  response.data["data"][0]["n_Kyc"] == 2) {
                //payment incomplete
                await SharedPreference().setLogin("2");
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => SelectPlan()),
                    (Route<dynamic> route) => false);
              }else if (response.data["data"][0]["n_Payment"] == 2 &&
                  response.data["data"][0]["n_Virtual"] == 1) {
                //Virtual incomplete
                await SharedPreference().setLogin("4");
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => SelectAlternateID()),
                    (Route<dynamic> route) => false);
              } else if (response.data["data"][0]["n_Payment"] == 2 &&
                  response.data["data"][0]["n_Kyc"] == 2 &&
                  response.data["data"][0]["n_Virtual"] == 2) {
                await SharedPreference().setLogin("1");
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => ActiveUserHome()),
                    (Route<dynamic> route) => false);
              } else {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => CallistPage()),
                    (Route<dynamic> route) => false);
              }
            }
          } else {
            setState(() {
              isconfirmloading = false;
            });
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => ServiceApp()),
                (Route<dynamic> route) => false);
          }

          // else if (response.data["data"][0]["n_Payment"] == 2) {
          //   setState(() {
          //     isconfirmloading = false;
          //   });
          //   Navigator.of(context).push(
          //     MaterialPageRoute(builder: (context) => const KycScreen()),
          //   );
          // } else {
          //   setState(() {
          //     isconfirmloading = false;
          //   });
          //   Navigator.of(context).push(
          //     MaterialPageRoute(builder: (context) => const ServiceApp()),
          //   );
          // }
        } else {
          setState(() {
            isconfirmloading = false;
          });
          otpController.clear();
          final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'On Snap!',
              message: response.data["error"][0],
              contentType: ContentType.failure,
            ),
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        }
      } else {
        setState(() {
          isconfirmloading = false;
        });
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'On Snap!',
            message: 'Please enter valid otp!',
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (e) {
      debugPrint("exceptionn : " + e.toString());
    }
  }

//checkrefferalcode

  checkrefferal() async {
    try {
      Dio dio = Dio();

      var parameters = {"n_Mobile": widget.phonenumber, "n_Otp": otp};
      dio.options.contentType = Headers.formUrlEncodedContentType;
      final response = await dio.post(
        ApiProvider.verifyotp,
        data: parameters,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      debugPrint("pavithra ${response.data}");
      if (response.statusCode == 401) {
      } else if (response.statusCode == 200) {
        if (response.data["status"] == 1) {
          await SharedPreference().setphonenumber(widget.phonenumber!);

          await SharedPreference().setuserName(widget.name!);

          // SharedPreferences.setPrefix(prefix)
          //   await _prefs.setString('action', 'Start');
          // await prefs.setString('action', 'Start');
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ServiceApp()),
          );
        } else {
          otpController.clear();
          final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'On Snap!',
              message: 'Please enter valid otp!',
              contentType: ContentType.failure,
            ),
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        }
      } else {
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'On Snap!',
            message: 'Please enter valid otp!',
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (e) {
      debugPrint(e as String?);
    }
  }

  ResendOTP() async {
    try {
      Dio dio = Dio();

      var parameters = {"n_Mobile": widget.phonenumber};
      dio.options.contentType = Headers.formUrlEncodedContentType;
      final response = await dio.post(
        ApiProvider.resendotp,
        data: parameters,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      debugPrint("pavithra ${response.data}");
      setState(() {
        isconfirmloading = false;
      });
      if (response.statusCode == 401) {
      } else if (response.statusCode == 200) {
        startTimeout();
        currentSeconds = 0;
        textEditingController.text = response.data["data"][0].toString();
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Oh Hey!',
            message: 'Your OTP is ! ${response.data["data"][0]}',
            contentType: ContentType.success,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        // Navigator.of(context).push(
        //   MaterialPageRoute(builder: (context) => const Congratulations()),
        // );
      } else {
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'On Snap!',
            message: 'Please enter valid otp!',
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (e) {
      debugPrint(e as String?);
    }
  }
}
