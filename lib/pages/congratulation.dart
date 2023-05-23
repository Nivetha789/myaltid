import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myaltid/pages/activeuserhome.dart';
import '../reasuable/dialogbox.dart';
import '../reasuable/theme.dart';

import '../reasuable/background_screen.dart';

import '../../reasuable/bottomnavbar.dart';

class Congratulations extends StatefulWidget {
  const Congratulations({super.key});

  @override
  State<Congratulations> createState() => CongratulationsState();
}

class CongratulationsState extends State<Congratulations> {
  List gender = [
    "UPI",
    "Credit / Debit Card",
    "Net Banking",
    "Wallet",
    "Crypto"
  ];

  late String select = "0";

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: whitecolor,
          fillColor: MaterialStateProperty.all<Color>(whitecolor),
          value: gender[btnValue],
          groupValue: select,
          onChanged: (value) {
            setState(() {
              select = value;
            });
          },
        ),
        Text(
          title,
          style: const TextStyle(
              fontFamily: "Helvatica",
              color: whitecolor,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              // fontStyle: FontStyle.italic,
              fontSize: 16),
          textAlign: TextAlign.start,
        ),
      ],
    );
  }

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
                    "Welcome Jhon Alex",
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
                        "Congratulations",
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              color: goldcolor,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              // fontStyle: FontStyle.italic,
                              fontSize: 28),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Your ALT ID has been successfully activated. You can start calling and emailing",
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              color: whitecolor,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              // fontStyle: FontStyle.italic,
                              fontSize: 14),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
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
                        "Your Virtual Mobile Number is",
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
                        "678 785 4532",
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              color: whitecolor,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              // fontStyle: FontStyle.italic,
                              fontSize: 28),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
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
                        "Your Virtual Email ID is",
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
                        "Jhon.doe@myaltid.com",
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
                    ],
                  ),
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
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:  [
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
                              child:const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:  [
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
              Row(
                children: [
                  CupertinoSwitch(
                    activeColor: buttoncolor,
                    thumbColor: whitecolor,
                    trackColor: goldcolor,
                    value: forIos,
                    onChanged: (value) => setState(() => forIos = value),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    "Enable Biometric Login",
                    style: TextStyle(
                        color: whitecolor,
                        fontFamily: "Helvatica",
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500),
                  )
                ],
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
