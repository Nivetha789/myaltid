import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myaltid/views/activeuserhome.dart';
import 'package:myaltid/views/reasuable/background_screen.dart';
import 'package:myaltid/views/reasuable/bottomnavbar.dart';
import 'package:myaltid/views/reasuable/dialogbox.dart';
import 'package:myaltid/views/reasuable/theme.dart';

class CurrentplanScreen extends StatefulWidget {
  const CurrentplanScreen({super.key});

  @override
  State<CurrentplanScreen> createState() => _CurrentplanScreenState();
}

class _CurrentplanScreenState extends State<CurrentplanScreen> {
  var forIos = true;
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Current Plan",
                    style: TextStyle(
                        fontFamily: "Helvatica",
                        color: whitecolor,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        // fontStyle: FontStyle.italic,
                        fontSize: 20),
                    textAlign: TextAlign.start,
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: ClipOval(
                      child: Material(
                        color: blackcolor, // Button color
                        child: InkWell(
                          splashColor: Colors.red, // Splash color
                          onTap: () {
                            Dialogbox(context);
                          },
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
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                elevation: 10,
                color: blackcolor,
                shadowColor: buttoncolor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Diamond Plan",
                            style: TextStyle(
                                color: goldcolor,
                                fontFamily: "Helvatica",
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                // fontStyle: FontStyle.italic,
                                fontSize: 14),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Image.asset("assets/images/ccall.png"),
                              const SizedBox(
                                width: 30,
                              ),
                              const Text(
                                "1 Virtual number 678 785 4532",
                                style: TextStyle(
                                    color: whitecolor,
                                    fontFamily: "Helvatica",
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    // fontStyle: FontStyle.italic,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Image.asset("assets/images/call.png"),
                              const SizedBox(
                                width: 30,
                              ),
                              const Text(
                                "500 mins talk time",
                                style: TextStyle(
                                    color: whitecolor,
                                    fontFamily: "Helvatica",
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    // fontStyle: FontStyle.italic,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Image.asset("assets/images/wifi.png"),
                              const SizedBox(
                                width: 30,
                              ),
                              const Text(
                                "50 GB data per month",
                                style: TextStyle(
                                    color: whitecolor,
                                    fontFamily: "Helvatica",
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    // fontStyle: FontStyle.italic,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                elevation: 2,
                color: blackcolor,
                shadowColor: buttoncolor,
                child: Container(
                  // height: 60,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Your Plan",
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              color: whitecolor,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              // fontStyle: FontStyle.italic,
                              fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Annual @ 250 Rs /M Billed annually",
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              color: whitecolor,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              // fontStyle: FontStyle.italic,
                              fontSize: 25),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ActiveUserHome()),
                              );
                            },
                            child: Container(
                              width: 140,
                              height: 50,
                              decoration: BoxDecoration(
                                color: buttoncolor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: const EdgeInsets.all(10),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "ACTIVATE",
                                    style: TextStyle(
                                        color: blackcolor,
                                        fontFamily: "Helvatica",
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ActiveUserHome()),
                              );
                            },
                            child: Container(
                              width: 100,
                              height: 50,
                              decoration: BoxDecoration(
                                color: buttoncolor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: const EdgeInsets.all(10),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Home",
                                    style: TextStyle(
                                        color: blackcolor,
                                        fontFamily: "Helvatica",
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const MyStatefulWidget(
          currentindex: 4,
        ),
      ),
    );
  }
}
