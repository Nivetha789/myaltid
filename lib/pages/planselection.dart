// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myaltid/data/api.dart';
import 'package:myaltid/module/plans.dart';
import 'package:myaltid/reasuable/theme.dart';
import 'package:myaltid/widget/sharedpreference.dart';

import '../reasuable/background_screen.dart';
import 'package:myaltid/pages/selectpaymentmode.dart';

import '../reasuable/button.dart';

class PlanSelection extends StatefulWidget {
  final cid;
  final List<JSubscription> Jsubscription;
  final cname;
  const PlanSelection(
      {super.key, this.cid, required this.Jsubscription, this.cname});

  @override
  State<PlanSelection> createState() => _PlanSelectionState();
}

class _PlanSelectionState extends State<PlanSelection> {
  List<JSubscription> subscriptionOptions = [];

//  Getsubscription() {
//     for (var i = 0; i < widget.Jsubscription.length; i++) {
//       debugPrint(widget.Jsubscription[i]);
//       subscriptionOptions.add(JSubscription.fromJson(widget.Jsubscription[i]));
//     }
//   }
  var items = [
    {"name": "Annual ", "number": "pay for full year ", "talktime": "250 / m"},
    {
      "name": "6 Months",
      "number": "pay for 6 Months",
      "talktime": "350 / m",
    },
    {
      "name": "3 Months",
      "number": "pay for 3 Months",
      "talktime": "550 / m",
    },
    {
      "name": "Monthly",
      "number": "pay for Monthly",
      "talktime": "700 / m",
    },
  ];
  JSubscription? selectedOption;

  List gender = [
    "Annual",
    "6 Months",
    "3 Months",
    "Monthly",
  ];

  late String select = "0";

  Row addRadioButton(int btnValue, String name, number, talktime) {
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 200,
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        color: whitecolor,
                        fontFamily: "Helvatica",
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        // fontStyle: FontStyle.italic,
                        fontSize: 14),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    number.toString(),
                    style: const TextStyle(
                        color: whitecolor,
                        fontFamily: "Helvatica",
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        // fontStyle: FontStyle.italic,
                        fontSize: 12),
                  ),
                ],
              ),
            ),
            Text(
              talktime,
              style: const TextStyle(
                  color: whitecolor,
                  fontFamily: "Helvatica",
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  // fontStyle: FontStyle.italic,
                  fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void initState() {
    // UserRegister();
    super.initState();
  }

  UserRegister() async {
    try {
      Dio dio = Dio();
      var name = await SharedPreference().getuserName();

      var phonenumber = await SharedPreference().getphonenumber();
      var refferalcode = await SharedPreference().getrefferalcode();
      var token = await SharedPreference().gettoken();
      var parameters = {
        "c_Name": name,
        "n_Mobile": phonenumber,
        "c_Plan": widget.cid,
        "c_ReferralCode": refferalcode,
        "c_SubscriptionId": selectedOption!.id
      };
      dio.options.contentType = Headers.formUrlEncodedContentType;
      final response = await dio.post(
        ApiProvider.userregister,
        data: parameters,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {"Authorization": "Bearer $token"},
        ),
      );
      debugPrint("pavithra ${response.data}");
      // var data = jsonDecode(response.data);/
      // print("dfkjsfddkjh $data");
      if (response.data["status"] == 1) {
        await SharedPreference().setplanid(widget.cid);

        await SharedPreference().setplanid(selectedOption!.id);

        await SharedPreference().setUserId(response.data["data"]["_id"]);

        // await SharedPreference()
        //     .setUserId(response.data["data"]["c_ActivePlan"]);

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const PaymentmodeSelection()));
      } else {
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
    } catch (e) {
      print(e);
    }
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
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "My Alternate ID",
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
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                elevation: 10,
                color: blackcolor,
                shadowColor: buttoncolor,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${widget.cname} Plan",
                        style: const TextStyle(
                            color: goldcolor,
                            fontFamily: "Helvatica",
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            // fontStyle: FontStyle.italic,
                            fontSize: 14),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Change Plan",
                          style: TextStyle(
                              color: buttoncolor,
                              fontFamily: "Helvatica",
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              // fontStyle: FontStyle.italic,
                              fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: widget.Jsubscription.map((option) {
                  return Card(
                    elevation: 10,
                    color: blackcolor,
                    shadowColor: goldcolor,
                    child: RadioListTile<JSubscription>(
                      activeColor: buttoncolor,
                      fillColor: MaterialStateProperty.all<Color>(buttoncolor),
                      title: Container(
                        width: MediaQuery.of(context).size.width - 200,
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  option.cTerm == 12
                                      ? "Annual"
                                      : "${option.cTerm} Months",
                                  style: const TextStyle(
                                      color: whitecolor,
                                      fontFamily: "Helvatica",
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      // fontStyle: FontStyle.italic,
                                      fontSize: 14),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Pay for ${option.cTerm} Months",
                                  style: const TextStyle(
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
                            Text(
                              "${option.nAmount.toString()} / m",
                              style: const TextStyle(
                                color: whitecolor,
                                fontFamily: "Helvatica",
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                // fontStyle: FontStyle.italic,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      value: option,
                      groupValue: selectedOption,
                      onChanged: (newValue) {
                        setState(() {
                          selectedOption = newValue;
                          print(selectedOption!.id);
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: SizedBox(
            width: double.infinity,
            child: selectedOption == null
                ? InkWell(
                    onTap: () {
                      final snackBar = SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Oh Hey!',
                          message: 'Please select your plan',
                          contentType: ContentType.failure,
                        ),
                      );

                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    },
                    child: const ButtonScreen(
                      buttontext: "Make Payment",
                    ),
                  )
                : InkWell(
                    onTap: () async {
                      UserRegister();
                    },
                    child: const ButtonScreen(
                      buttontext: "Make Payment",
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
