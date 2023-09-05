import 'package:flutter/material.dart';
import 'package:myaltid/reasuable/background_screen.dart';
import 'package:myaltid/reasuable/button.dart';
import 'package:myaltid/reasuable/theme.dart';
import 'package:myaltid/pages/signupnext.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Backgroundscreen(
      ccontainerchild: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: const EdgeInsets.all(15),
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
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
                      height: 60,
                    ),
                    const Text(
                      "Create your Alternate ID",
                      style: TextStyle(
                          fontFamily: "Helvatica",
                          color: whitecolor,
                          fontWeight: FontWeight.w300,
                          fontSize: 16),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Sign up in 2 Minutes",
                      style: TextStyle(
                          fontFamily: "Helvatica",
                          color: whitecolor,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.italic,
                          fontSize: 16),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Digitally create an instant Virtual Mobile Number (VMN) & Virtual @Mail ID (VEID) to hide from Telemarketers, Scamsters and Phishing",
                      style: TextStyle(
                          fontFamily: "Helvatica",
                          color: whitecolor,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          // fontStyle: FontStyle.italic,
                          fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "New User",
                          style: TextStyle(
                              fontFamily: "Helvatica",
                              color: whitecolor,
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.normal,
                              fontSize: 12),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const SignupApp(signup: "signup")),
                            );
                          },
                          child: const ButtonScreen(
                            buttontext: "Get MYALTID Now",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Existing User",
                          style: TextStyle(
                              fontFamily: "Helvatica",
                              color: whitecolor,
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.normal,
                              fontSize: 12),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const SignupApp(signup: "signin")),
                            );
                            // updateCommunityText(index);
                          },
                          child: Container(
                            width: 250,
                            height: 50,
                            decoration: BoxDecoration(
                                color: blackcolor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(0xff00F00B),
                                  width: 2,
                                )),
                            alignment: Alignment.center,
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                  fontFamily: "Helvatica",
                                  color: buttoncolor,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
