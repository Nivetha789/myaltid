import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myaltid/data/api.dart';
import 'package:myaltid/pages/calls/calllist.dart';
import 'package:myaltid/pages/signup.dart';
import 'package:myaltid/reasuable/dialogbox.dart';
import 'package:myaltid/widget/sharedpreference.dart';
import '../reasuable/theme.dart';
import '../../reasuable/bottomnavbar.dart';

import '../reasuable/background_screen.dart';

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
  bool isloading = false;
  var cname,
      dateexpire,
      nsubscrption = "0",
      nsubscrptionprice = "0",
      availabledata = "0",
      availabletalktime = "0",
      nutlizeddata = "0",
      nutlizedtalktime = "0";

  var biometric = true;

  @override
  void initState() {
    GetPlan();
    super.initState();
  }

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

  bool isselected = false;
  var forIos = true;

  @override
  Widget build(BuildContext context) {
    return Backgroundscreen(
      ccontainerchild: Scaffold(
        backgroundColor: Colors.transparent,
        body: isloading == false
            ? const SpinKitFadingCircle(
                color: buttoncolor,
                size: 50.0,
              )
            : SingleChildScrollView(
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
                          "Welcome ${cname ?? ""}",
                          style: const TextStyle(
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
                                    "Plan end date $dateexpire",
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
                              "₹ $nsubscrptionprice",
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
                              "              Billed $nsubscrption Months",
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
                                  "$availabletalktime Minutes",
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
                                  "$availabledata GB      ",
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
                                      percent: 1.0 -
                                          (num.tryParse(nutlizedtalktime)! /
                                                  num.tryParse(
                                                      availabletalktime)!)
                                              .clamp(0.0, 1.0),
                                      center: Text(
                                        "$nutlizedtalktime Min",
                                        style: const TextStyle(
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
                                      percent: 1.0 -
                                          (num.tryParse(nutlizeddata)! /
                                                  num.tryParse(availabledata)!)
                                              .clamp(0.0, 1.0),
                                      center: Text(
                                        "$nutlizeddata GB",
                                        style: const TextStyle(
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
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                          value: biometric,
                          onChanged: (value) =>
                              setState(() => biometric = value),
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

  GetPlan() async {
    try {
      Dio dio = Dio();
      setState(() {
        isloading = false;
      });
      // ProgressDialog().showLoaderDialog(context);
      const SpinKitFadingCircle(
        color: buttoncolor,
        size: 50.0,
      );
      var token = await SharedPreference().gettoken();
      cname = await SharedPreference().getuserName();
      print(token);
      var phonenumber = await SharedPreference().getphonenumber();
      // var parameters = {
      //   "c_Name": cname,
      //   "n_Mobile": phonenumber,
      //   "c_ReferralCode": "",
      //   "n_ActivePlan": ""
      // };
      dio.options.contentType = Headers.formUrlEncodedContentType;

      final response = await dio.get(
        ApiProvider.getdatautlize,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {"Authorization": "Bearer $token"},
        ),
      );
      final response1 = await dio.get(
        ApiProvider.getuser,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {"Authorization": "Bearer $token"},
        ),
      );
      debugPrint("profileee  $cname");
      if (cname == null || cname == "") {
        await SharedPreference()
            .setuserName(response1.data["data"]["c_UserName"]);
        cname = await SharedPreference().getuserName();
      } else {
        cname = await SharedPreference().getuserName();
      }
      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.toString());
        debugPrint("response ${map}");
        if (map["status"] == 1) {
          setState(() {
            isloading = true;
            availabledata = map["data"]["n_AvailableData"].toString();
            availabletalktime = map["data"]["n_AvailableTalkTime"].toString();
            nutlizeddata = map["data"]["n_UtilizedData"].toString();
            nutlizedtalktime = map["data"]["n_UtilizedTalkTime"].toString();
            dateexpire = map["data"]["dt_ExpiredAt"].toString();
            nsubscrption = map["data"]["n_SubscriptionDuration"].toString();
            nsubscrptionprice = map["data"]["n_SubscriptionPrice"].toString();
          });
        } else {
          final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'On Snap!',
              message: response.data["message"],
              contentType: ContentType.failure,
            ),
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        }
      } else {
        var dialog = AlertDialog(
          title: Text('Login',
              style: TextStyle(
                  color: buttoncolor,
                  fontWeight: FontWeight.w700,
                  fontSize: 16)),
          content: Text('Session was expired kindly login again',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 15)),
          actions: [
            ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  backgroundColor: MaterialStateProperty.all(buttoncolor),
                ),
                onPressed: () async {
                  Navigator.pop(context);
                  await SharedPreference().clearSharep().then((v) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => Signup()));
                  });
                },
                child: Text(
                  '  OK  ',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ))
          ],
        );
        showDialog(
            context: context, builder: (BuildContext context) => dialog);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
