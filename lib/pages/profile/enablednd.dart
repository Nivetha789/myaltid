import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../reasuable/bottomnavbar.dart';

import '../../reasuable/dialogbox.dart';
import '../../reasuable/theme.dart';

import '../../reasuable/background_screen.dart';

class EnableDndScreen extends StatefulWidget {
  const EnableDndScreen({super.key});

  @override
  State<EnableDndScreen> createState() => _EnableDndScreenState();
}

class _EnableDndScreenState extends State<EnableDndScreen> {
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
  var enablednd = true;
  var callaler1 = true;
  var callaler2 = true;
  var msgalert1 = true;
  var msgalert2 = true;
  var disablednd = false;
  var disabledndclalert1 = false;
  var disabledndclalert2 = false;
  var disabledndmsgalert1 = false;
  var disabledndmsgalert2 = false;
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
                    "Preferences",
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
                        "Enabling DND means less disturbance. Please explain little about DND here",
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
                        height: 10,
                      ),
                      Row(
                        children: [
                          CupertinoSwitch(
                            activeColor: buttoncolor,
                            thumbColor: whitecolor,
                            trackColor: Colors.grey,
                            value: enablednd,
                            onChanged: (value) =>
                                setState(() => enablednd = value),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Enable DND",
                            style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                  color: goldcolor,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  // fontStyle: FontStyle.italic,
                                  fontSize: 14),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Call alerts",
                        style: TextStyle(
                            fontFamily: "Helvatica",
                            color: whitecolor,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            // fontStyle: FontStyle.italic,
                            fontSize: 16),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          CupertinoSwitch(
                            activeColor: buttoncolor,
                            thumbColor: whitecolor,
                            trackColor: Colors.grey,
                            value: callaler1,
                            onChanged: (value) =>
                                setState(() => callaler1 = value),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              "No call alerts for VMN when on APP DND",
                              style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    color: whitecolor,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    // fontStyle: FontStyle.italic,
                                    fontSize: 14),
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          CupertinoSwitch(
                            activeColor: buttoncolor,
                            thumbColor: whitecolor,
                            trackColor: Colors.grey,
                            value: callaler2,
                            onChanged: (value) =>
                                setState(() => callaler2 = value),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              "Allow VMN call alerts if caller is in my Phone Book even when on APP DND",
                              style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    color: whitecolor,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    // fontStyle: FontStyle.italic,
                                    fontSize: 14),
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "SMS alerts",
                        style: TextStyle(
                            fontFamily: "Helvatica",
                            color: whitecolor,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            // fontStyle: FontStyle.italic,
                            fontSize: 16),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          CupertinoSwitch(
                            activeColor: buttoncolor,
                            thumbColor: whitecolor,
                            trackColor: Colors.grey,
                            value: msgalert1,
                            onChanged: (value) =>
                                setState(() => msgalert1 = value),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              "Don’t give any alert notifications for sms when on DND",
                              style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    color: whitecolor,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    // fontStyle: FontStyle.italic,
                                    fontSize: 14),
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          CupertinoSwitch(
                            activeColor: buttoncolor,
                            thumbColor: whitecolor,
                            trackColor: Colors.grey,
                            value: msgalert2,
                            onChanged: (value) =>
                                setState(() => msgalert2 = value),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              "Allow alert notifications for VMN sms  when on DND only if sender is in my phone book",
                              style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    color: whitecolor,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    // fontStyle: FontStyle.italic,
                                    fontSize: 14),
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: whitecolor,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          CupertinoSwitch(
                            activeColor: buttoncolor,
                            thumbColor: whitecolor,
                            trackColor: Colors.grey,
                            value: disablednd,
                            onChanged: (value) =>
                                setState(() => disablednd = value),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Disable DND",
                            style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                  color: goldcolor,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  // fontStyle: FontStyle.italic,
                                  fontSize: 14),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Call alerts",
                        style: TextStyle(
                            fontFamily: "Helvatica",
                            color: whitecolor,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            // fontStyle: FontStyle.italic,
                            fontSize: 16),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          CupertinoSwitch(
                            activeColor: buttoncolor,
                            thumbColor: whitecolor,
                            trackColor: Colors.grey,
                            value: disabledndclalert1,
                            onChanged: (value) =>
                                setState(() => disabledndclalert1 = value),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              "Only allow calls from my address book",
                              style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    color: whitecolor,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    // fontStyle: FontStyle.italic,
                                    fontSize: 14),
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          CupertinoSwitch(
                            activeColor: buttoncolor,
                            thumbColor: whitecolor,
                            trackColor: Colors.grey,
                            value: disabledndclalert2,
                            onChanged: (value) =>
                                setState(() => disabledndclalert2 = value),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              "Allow all calls when in Active mode",
                              style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    color: whitecolor,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    // fontStyle: FontStyle.italic,
                                    fontSize: 14),
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "SMS alerts",
                        style: TextStyle(
                            fontFamily: "Helvatica",
                            color: whitecolor,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            // fontStyle: FontStyle.italic,
                            fontSize: 16),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          CupertinoSwitch(
                            activeColor: buttoncolor,
                            thumbColor: whitecolor,
                            trackColor: Colors.grey,
                            value: disabledndmsgalert1,
                            onChanged: (value) =>
                                setState(() => disabledndmsgalert1 = value),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              "Allow sms notifications for sms from people in my address book ",
                              style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    color: whitecolor,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    // fontStyle: FontStyle.italic,
                                    fontSize: 14),
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          CupertinoSwitch(
                            activeColor: buttoncolor,
                            thumbColor: whitecolor,
                            trackColor: Colors.grey,
                            value: disabledndmsgalert2,
                            onChanged: (value) =>
                                setState(() => disabledndmsgalert2 = value),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              "Only allow sms notifications from my address book",
                              style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    color: whitecolor,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    // fontStyle: FontStyle.italic,
                                    fontSize: 14),
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //       builder: (context) =>
                        //           const Congratulations()),
                        // );
                      },
                      child: Container(
                        width: 150,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xffE4C793),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Reset Preferences",
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
                    width: 10,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                        onTap: () {
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           const Congratulations()),
                          // );
                        },
                        child: Container(
                          width: 150,
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
        bottomNavigationBar: const MyStatefulWidget(
          currentindex: 4,
        ),
      ),
    );
  }
}
