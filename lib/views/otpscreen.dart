// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:myaltid/views/reasuable/background_screen.dart';
import 'package:myaltid/views/reasuable/button.dart';
import 'package:myaltid/views/reasuable/theme.dart';
import 'package:myaltid/views/services.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class SendOTPScreen extends StatefulWidget {
  final phonenumber;
  const SendOTPScreen({super.key, this.phonenumber});

  @override
  State<SendOTPScreen> createState() => _SendOTPScreenState();
}

class _SendOTPScreenState extends State<SendOTPScreen> {
  OtpFieldController otpController = OtpFieldController();

  bool isChecked = false,
      confirmotp = false,
      otpfield = false,
      errorfield = false;
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
                      });
                      // print("Completed: " + pin);
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
                      Row(
                        children: const [
                          Text(
                            'Retry after',
                            style: TextStyle(color: whitecolor),
                          ),
                          Text(
                            ' 180',
                            style: TextStyle(color: buttoncolor),
                          ),
                          Text(
                            ' sec',
                            style: TextStyle(color: whitecolor),
                          ),
                        ],
                      ),
                      //           Countdown(
                      //                 animation: StepTween(
                      //                   begin: 2 * 60,
                      //                   end: 0,
                      //                 ).animate(_controller),
                      //               ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        hoverColor: buttoncolor,

                        fillColor: isChecked
                            ? MaterialStateProperty.all<Color>(buttoncolor)
                            : MaterialStateProperty.all<Color>(whitecolor),
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
                            //   print("DFDDGDFGDFGFD $isChecked");
                          });
                        },
                      ),
                      const Text.rich(
                        TextSpan(
                          text: 'I agree with ',
                          style: TextStyle(fontSize: 15, color: whitecolor),
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
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  otpfield == true
                      ? InkWell(
                          onTap: () {
                            print("PAVITHRA");
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const ServiceApp()),
                            );
                          },
                          child: const ButtonScreen(
                            buttontext: "Confirm",
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            print("PAVITHRA12");
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
              //           //   print("Completed: " + pin);
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
}
