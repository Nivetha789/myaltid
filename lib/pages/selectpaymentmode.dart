// ignore_for_file: unnecessary_null_comparison

import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myaltid/data/api.dart';
import 'package:myaltid/pages/paymentsuccessfull.dart';
import 'package:myaltid/reasuable/theme.dart';
import 'package:myaltid/widget/sharedpreference.dart';

import '../reasuable/background_screen.dart';
import '../reasuable/button.dart';

class PaymentmodeSelection extends StatefulWidget {
  const PaymentmodeSelection({super.key});

  @override
  State<PaymentmodeSelection> createState() => _PaymentmodeSelectionState();
}

class _PaymentmodeSelectionState extends State<PaymentmodeSelection> {
  List gender = [
    "UPI",
    "Credit / Debit Card",
    "Net Banking",
    "Wallet",
    "Crypto"
  ];

  late String select = "0";

  late String selectoption = "0";
  var randomnumber;
  @override
  void initState() {
    randomnumber = generateRandomNumber();
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
      var cPlanId = await SharedPreference().getplanid();
      var cSubscriptionId = await SharedPreference().getsubscriptionId();

      var parameters = {
        "c_PlanId": cPlanId,
        "c_SubscriptionId": cSubscriptionId,
        "c_PaymentId": randomnumber.toString(),
        "c_paymentStatus": "Sucesss"
      };
      print(parameters);
      print(token);
      dio.options.contentType = Headers.formUrlEncodedContentType;
      final response = await dio.post(
        ApiProvider.addsubscrptiondetils,
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
        // await SharedPreference()
        //     .setUserId(response.data["data"]["c_ActivePlan"]);

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const PaymentSuccessfull()));
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

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: buttoncolor,
          fillColor: MaterialStateProperty.all<Color>(buttoncolor),
          value: gender[btnValue],
          groupValue: select,
          onChanged: (value) {
            setState(() {
              debugPrint(value);
              select = value;
              selectoption = value;
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

  String generateRandomNumber() {
    final random = Random();
    final maxDigits = 18;
    final buffer = StringBuffer();

    for (var i = 0; i < maxDigits; i++) {
      buffer.write(random.nextInt(10)); // Generates a random digit from 0 to 9
    }

    return buffer.toString();
  }

  void main() {
    final randomNumber = generateRandomNumber();
    print(randomNumber);
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
                    "Select Payment Mode",
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
              const Card(
                elevation: 10,
                color: blackcolor,
                shadowColor: buttoncolor,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "pay to MyAltID",
                        style: TextStyle(
                            color: whitecolor,
                            fontFamily: "Helvatica",
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            // fontStyle: FontStyle.italic,
                            fontSize: 14),
                      ),
                      Text(
                        "Order # 001",
                        style: TextStyle(
                            color: whitecolor,
                            fontFamily: "Helvatica",
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            // fontStyle: FontStyle.italic,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
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
                    SizedBox(
                      height: 270,
                      width: MediaQuery.of(context).size.width - 40,
                      child: Column(
                        children: [
                          addRadioButton(0, 'UPI'),
                          addRadioButton(1, 'Credit / Debit Card'),
                          addRadioButton(2, 'Net Banking'),
                          addRadioButton(3, 'Wallet'),
                          addRadioButton(4, 'Crypto'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 160,
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          child: SizedBox(
            width: double.infinity,
            child: selectoption == "0"
                ? InkWell(
                    onTap: () {
                      final snackBar = SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Oh Hey!',
                          message: 'Please select your Paymentmode',
                          contentType: ContentType.failure,
                        ),
                      );

                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: buttoncolor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Payable (inc GST)",
                            style: TextStyle(
                                color: blackcolor,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Rs.45",
                            style: TextStyle(
                                color: blackcolor,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () async {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //       builder: (context) => const PaymentSuccessfull()),
                      // );
                      UserRegister();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: buttoncolor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Payable (inc GST)",
                            style: TextStyle(
                                color: blackcolor,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Rs.45",
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
        ),
      ),
    );
  }
}
