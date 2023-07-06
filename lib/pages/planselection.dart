// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myaltid/data/api.dart';
import 'package:myaltid/module/PaymentDetailsModel.dart';
import 'package:myaltid/module/plans.dart';
import 'package:myaltid/reasuable/theme.dart';
import 'package:myaltid/widget/sharedpreference.dart';
import 'package:weipl_checkout_flutter/weipl_checkout_flutter.dart';

import '../reasuable/background_screen.dart';
import 'package:myaltid/pages/selectpaymentmode.dart';

import '../reasuable/button.dart';
import '../widget/progressloaded.dart';

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

  WeiplCheckoutFlutter wlCheckoutFlutter = WeiplCheckoutFlutter();

  String selectionAmount="";
  String orderId="";

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

  String username="";
  String mobileNum="";
  String amount="";
  String transactionId="";
  String userId="";
  String hash="";

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
      debugPrint("dfkjsfddkjhpavithra ${response.data}");
      // var data = jsonDecode(response.data);/
      print("dfkjsfddkjh $token");
      if (response.data["status"] == 1) {
        await SharedPreference().setplanid(widget.cid);

        await SharedPreference().setsubscriptionId(selectedOption!.id);

        await SharedPreference().setUserId(response.data["data"]["_id"]);

        // await SharedPreference()
        //     .setUserId(response.data["data"]["c_ActivePlan"]);

       getPaymentDetails();
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
                          print("selectioniddd "+selectedOption!.id);
                          selectionAmount=option.nAmount.toString();
                          orderId=option.id.toString();
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
                      print("planiddd "+widget.Jsubscription.toString());
                      // if (Platform.isIOS) {
                      //   // iOS code
                      //   bool status = await wlCheckoutFlutter.checkInstalledUpiApp(
                      //       "gpay://upi/"); //UPI Schemes :- "phonepe://upi/" OR "gpay://upi/" OR "paytm://".
                      //   // showAlertDialog(context, "WL SDK Response", "$status");
                      //   Navigator.of(context).push(MaterialPageRoute(
                      //       builder: (context) => PaymentmodeSelection(status,selectionAmount,orderId)));
                      // } else if (Platform.isAndroid) {
                      //   // android code
                      //   List response = await wlCheckoutFlutter.upiIntentAppsList();
                      //   // showAlertDialog(context, "WL SDK Response", "$response");
                      //   Navigator.of(context).push(MaterialPageRoute(
                      //       builder: (context) => PaymentmodeSelection(response,selectionAmount,orderId)));
                      // } else {
                      //   showAlertDialog(context, "WL SDK Response",
                      //       "Feature is not available for selected platform.");
                      // }

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

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Okay"),
      onPressed: () {
        Navigator.pop(context, false);
      },
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(left: 25, right: 25),
          title: Center(child: Text(title)),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: SizedBox(
            height: 400,
            width: 300,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Text(message),
                ],
              ),
            ),
          ),
          actions: [
            continueButton,
          ],
        );
      },
    );
  }

  //get payment details
  getPaymentDetails() async {
    ProgressDialog().showLoaderDialog(context);
    // BaseOptions options = new BaseOptions(
    //   baseUrl: ApiProvider().Baseurl,
    //   connectTimeout: 5000,
    //   receiveTimeout: 3000,
    // );
    // Dio dio = new Dio(options);

    Dio dio = new Dio();
    // dio.options.connectTimeout = 5000; //5s
    // dio.options.receiveTimeout = 3000;

    var token = await SharedPreference().gettoken();

    var parameters = {
      "c_PlanId": widget.cid,
      "c_SubscriptionId": selectedOption!.id
    };
    print("paymentDetailsParams :"+parameters.toString());

    dio.options.contentType = Headers.formUrlEncodedContentType;
    final response = await dio.post(
      ApiProvider.getpaymentdetails,
      data: parameters,
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {"Authorization": "Bearer $token"},
      ),
    );
    print("paymentDetailsRes :"+response.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.toString());
      PaymentDetailsModel paymentDetailsModel = PaymentDetailsModel.fromJson(map);

      if (paymentDetailsModel.status == 1) {
        ProgressDialog().dismissDialog(context);
        setState(() {
          username=paymentDetailsModel.data![0].cName!;
          mobileNum=paymentDetailsModel.data![0].nMobileNumber!;
          amount=paymentDetailsModel.data![0].nAmount.toString();
          transactionId=paymentDetailsModel.data![0].nTransactionId!;
          userId=paymentDetailsModel.data![0].cUserId!;
          hash=paymentDetailsModel.data![0].cHash!;
          print("hashhhhhh "+hash.toString());
        });

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PaymentmodeSelection(username,mobileNum,amount,transactionId,userId,hash)));
      } else {
        ProgressDialog().dismissDialog(context);
        Fluttertoast.showToast(
            msg: "Not Found",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            textColor: Colors.white,
            backgroundColor: Colors.lightGreen,
            timeInSecForIosWeb: 1);
      }
    } else {
      ProgressDialog().dismissDialog(context);
      Fluttertoast.showToast(
          msg: "Bad Network Connection try again..",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
          backgroundColor: Colors.lightGreen,
          timeInSecForIosWeb: 1);
    }
  }
}
