import 'package:flutter/material.dart';
import 'package:myaltid/views/reasuable/background_screen.dart';
import 'package:myaltid/views/reasuable/button.dart';
import 'package:myaltid/views/reasuable/theme.dart';
import 'package:myaltid/views/selectplan.dart';

class ServiceApp extends StatefulWidget {
  const ServiceApp({super.key});

  @override
  State<ServiceApp> createState() => _ServiceAppState();
}

class _ServiceAppState extends State<ServiceApp> {
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
                height: 30,
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: ClipOval(
                  child: Material(
                    color: blackcolor, // Button color
                    child: InkWell(
                      splashColor: Colors.red, // Splash color
                      onTap: () {},
                      child: const SizedBox(
                        width: 50,
                        height: 50,
                        child: Icon(
                          Icons.person,
                          color: buttoncolor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Services",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: "Helvatica",
                      color: whitecolor,
                      fontWeight: FontWeight.w600,
                      fontSize: 25),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                elevation: 10,
                color: blackcolor,
                shadowColor: buttoncolor,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 70,
                        width: 50,
                        child: Image.asset(
                          "assets/images/Vector.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 170,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Virtual Mobile Number (VMN)",
                              style: TextStyle(
                                  fontFamily: "Helvatica",
                                  color: Color(0xff55B780),
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  // fontStyle: FontStyle.italic,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "No sim card needed. Receive calls and sms. ",
                              style: TextStyle(
                                  fontFamily: "Helvatica",
                                  color: whitecolor,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  // fontStyle: FontStyle.italic,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Image.asset("assets/images/Vector (1).png"),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "Why VMN",
                                  style: TextStyle(
                                      fontFamily: "Helvatica",
                                      color: buttoncolor,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                      // fontStyle: FontStyle.italic,
                                      fontSize: 14),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Card(
                elevation: 10,
                color: blackcolor,
                shadowColor: buttoncolor,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 70,
                        width: 50,
                        child: Image.asset(
                          "assets/images/message 1.png",
                          //fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 170,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Virtual Email ID (VEID)",
                              style: TextStyle(
                                  fontFamily: "Helvatica",
                                  color: Color(0xff55B780),
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  // fontStyle: FontStyle.italic,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Seamless communication using your MYALTID email ",
                              style: TextStyle(
                                  fontFamily: "Helvatica",
                                  color: whitecolor,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  // fontStyle: FontStyle.italic,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Image.asset("assets/images/Vector (1).png"),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  "Why VEID",
                                  style: TextStyle(
                                      fontFamily: "Helvatica",
                                      color: buttoncolor,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                      // fontStyle: FontStyle.italic,
                                      fontSize: 14),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const SelectPlan()),
                  );
                },
                child: const ButtonScreen(
                  buttontext: "I can't wait- Let's proceed",
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Love it, I will do it later',
                style: TextStyle(
                    decoration: TextDecoration.underline, color: buttoncolor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
