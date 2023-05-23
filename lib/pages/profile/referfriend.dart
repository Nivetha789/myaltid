import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myaltid/pages/profile/whatsapp.dart';
import '../../reasuable/bottomnavbar.dart';
import '../../reasuable/dialogbox.dart';
import '../../reasuable/theme.dart';

import '../../reasuable/background_screen.dart';

class ReferafriendScreen extends StatefulWidget {
  const ReferafriendScreen({super.key});

  @override
  State<ReferafriendScreen> createState() => _ReferafriendScreenState();
}

class _ReferafriendScreenState extends State<ReferafriendScreen> {
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
              debugPrint(value);
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
                  Text(
                    "Refer a Friend",
                    style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                          color: whitecolor,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          // fontStyle: FontStyle.italic,
                          fontSize: 20),
                    ),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Its good to be together",
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              color: whitecolor,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              // fontStyle: FontStyle.italic,
                              fontSize: 14),
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const WhatsappScreen()),
                                );
                              },
                              child: Container(
                                width: 200,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: buttoncolor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.center,
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Recommend via Whatsapp",
                                      style: TextStyle(
                                          color: blackcolor,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: InkWell(
                                onTap: () {
                                  // Navigator.of(context).push(
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           const Congratulations()),
                                  // );
                                },
                                child: Container(
                                  width: 200,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: buttoncolor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Save Preferences",
                                        style: TextStyle(
                                            color: blackcolor,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
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
