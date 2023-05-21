import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myaltid/views/calls/calllist.dart';
import 'package:myaltid/views/reasuable/background_screen.dart';
import 'package:myaltid/views/reasuable/bottomnavbar.dart';
import 'package:myaltid/views/reasuable/dialogbox.dart';
import 'package:myaltid/views/reasuable/theme.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ActiveUserHome extends StatefulWidget {
  const ActiveUserHome({super.key});

  @override
  State<ActiveUserHome> createState() => _ActiveUserHomeState();
}

class _ActiveUserHomeState extends State<ActiveUserHome> {
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
              print(value);
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

  bool isselected = false;
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
              Container(
                alignment: Alignment.centerRight,
                height: 40,
                width: MediaQuery.of(context).size.width,
                color: const Color(0xff1D2C1D),
                child: isselected == false
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            isselected = true;
                          });
                        },
                        child: const Text(
                          'Set DND Preferences',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: goldcolor),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CupertinoSwitch(
                            activeColor: buttoncolor,
                            thumbColor: whitecolor,
                            trackColor: goldcolor,
                            value: forIos,
                            onChanged: (value) =>
                                setState(() => forIos = value),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text(
                            "DND Enabled",
                            style: TextStyle(
                                color: whitecolor,
                                fontFamily: "Helvatica",
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                elevation: 0,
                color: const Color(0xff0B100C),
                child: Container(
                  // height: 60,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Current Plan & Beniits",
                            style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                  color: whitecolor,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  // fontStyle: FontStyle.italic,
                                  fontSize: 16),
                            ), 
                          ),
                          SizedBox(
                            width: 80,
                            child: Text(
                              "Plan end date 01 July 2023",
                              style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    color: whitecolor,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    // fontStyle: FontStyle.italic,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "₹ 250 / PM",
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              color: whitecolor,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              // fontStyle: FontStyle.italic,
                              fontSize: 25),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "              Billed Annually",
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              color: whitecolor,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              // fontStyle: FontStyle.italic,
                              fontSize: 12),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Divider(
                        color: buttoncolor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Talk time",
                            style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                  color: whitecolor,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  // fontStyle: FontStyle.italic,
                                  fontSize: 14),
                            ),
                          ),
                          Text(
                            "Data             ",
                            style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                  color: whitecolor,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  // fontStyle: FontStyle.italic,
                                  fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "500 Minutes",
                            style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                  color: whitecolor,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  // fontStyle: FontStyle.italic,
                                  fontSize: 16),
                            ),
                          ),
                          Text(
                            "50 GB        ",
                            style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                  color: whitecolor,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  // fontStyle: FontStyle.italic,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                elevation: 0,
                color: const Color(0xff0B100C),
                child: Container(
                  // height: 60,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Utilization",
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              color: whitecolor,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              // fontStyle: FontStyle.italic,
                              fontSize: 16),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Talk time",
                                style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                      color: whitecolor,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      // fontStyle: FontStyle.italic,
                                      fontSize: 16),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              CircularPercentIndicator(
                                radius: 60.0,
                                animation: true,
                                animationDuration: 1200,
                                lineWidth: 7.0,
                                percent: 0.4,
                                center: const Text(
                                  "200 Min",
                                  style: TextStyle(
                                      color: whitecolor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0),
                                ),
                                circularStrokeCap: CircularStrokeCap.butt,
                                backgroundColor: const Color(0xffF5C324),
                                progressColor: const Color(0xffFF8A65),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Data",
                                style: GoogleFonts.openSans(
                                  textStyle: const TextStyle(
                                      color: whitecolor,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      // fontStyle: FontStyle.italic,
                                      fontSize: 16),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              CircularPercentIndicator(
                                radius: 60.0,
                                animation: true,
                                animationDuration: 1200,
                                lineWidth: 7.0,
                                percent: 0.4,
                                center: const Text(
                                  "40 GB",
                                  style: TextStyle(
                                      color: whitecolor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0),
                                ),
                                circularStrokeCap: CircularStrokeCap.butt,
                                backgroundColor: const Color(0xffF5C324),
                                progressColor: const Color(0xffFF8A65),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              color: Color(0xffF5C324),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Utilized limit",
                            style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                  color: whitecolor,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  // fontStyle: FontStyle.italic,
                                  fontSize: 13),
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              color: Color(0xffFF8A65),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Available limit",
                            style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                  color: whitecolor,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  // fontStyle: FontStyle.italic,
                                  fontSize: 13),
                            ),
                          ),
                        ],
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
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const CallistPage()),
                  );
                },
                child: Container(
                  width: 150,
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
                        "Review Plan",
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
                height: 10,
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
