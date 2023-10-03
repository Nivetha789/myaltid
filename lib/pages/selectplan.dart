// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myaltid/pages/planselection.dart';
import 'package:myaltid/pages/signup.dart';
import 'package:myaltid/reasuable/background_screen.dart';
import 'package:myaltid/reasuable/theme.dart';
import 'package:myaltid/widget/sharedpreference.dart';

import '../data/api.dart';
import '../module/plans.dart';
import '../reasuable/dialogbox.dart';

class SelectPlan extends StatefulWidget {
  @override
  State<SelectPlan> createState() => _SelectPlanState();
}

class _SelectPlanState extends State<SelectPlan> {
  List<Plan> plans = [];
  var items = [
    {
      "name": "Diamond Plan",
      "number": "1 Virtual number",
      "talktime": "300 mins talk time",
      "datapermonth": "30 GB data per month"
    },
    {
      "name": "Gold Plan",
      "number": "1 Virtual number",
      "talktime": "300 mins talk time",
      "datapermonth": "30 GB data per month"
    },
    {
      "name": "Silver Plan",
      "number": "1 Virtual number",
      "talktime": "300 mins talk time",
      "datapermonth": "30 GB data per month"
    },
  ];

  @override
  void initState() {
    GetPlan();
    super.initState();
  }

  bool isloading = false;

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

      // var phonenumber = await SharedPreference().getphonenumber();
      // var parameters = {
      //   "c_Name": name,
      //   "n_Mobile": phonenumber,
      //   "c_ReferralCode": "",
      //   "n_ActivePlan": ""
      // };
      dio.options.contentType = Headers.formUrlEncodedContentType;
      final response = await dio.get(
        ApiProvider.getplans,
        // data: parameters,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {"Authorization": "Bearer $token"},
        ),
      );
      debugPrint("pavithra123 ${response.data}");

      if (response.statusCode == 401) {
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
        showDialog(context: context, builder: (BuildContext context) => dialog);
      } else if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.toString());
        debugPrint("response ${response.data}");
        if (map["status"] == 1) {
          setState(() {
            isloading = true;
          });
          // setState(() {
          //   ProgressDialog().dismissDialog(context);
          // });
          for (var i = 0; i < map["data"].length; i++) {
            debugPrint("response ${map["data"][i]}");

            setState(() {
              plans.add(Plan.fromJson(map["data"][i]));
            });
          }
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
    } catch (e) {
      debugPrint(e as String?);
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
                    "VNM & VEID",
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
                          onTap: () async{
                            if (await SharedPreference().getLogin() == "1") {
                            Dialogbox(context);
                            } else {
                            Fluttertoast.showToast(
                            msg: "Select your Plan",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            textColor: Colors.white,
                            backgroundColor: buttoncolor,
                            timeInSecForIosWeb: 1);
                            }
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
                alignment: Alignment.topLeft,
                child: const Text(
                  "Select your Plan",
                  style: TextStyle(
                      fontFamily: "Helvatica",
                      color: whitecolor,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      // fontStyle: FontStyle.italic,
                      fontSize: 18),
                  textAlign: TextAlign.start,
                ),
              ),
              isloading == false
                  ? const SpinKitFadingCircle(
                      color: buttoncolor,
                      size: 50.0,
                    )
                  : ListView.builder(
                      itemCount: plans.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            print("plan_iddd " + plans[index].id);

                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => PlanSelection(
                                    cid: plans[index].id,
                                    Jsubscription: plans[index].jSubscription,
                                    cname: plans[index].cPlan,
                                  ),
                                ),
                                (Route<dynamic> route) => false);
                          },
                          child: Column(
                            children: [
                              Card(
                                elevation: 10,
                                color: blackcolor,
                                shadowColor: buttoncolor,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            plans[index].cPlan,
                                            style: const TextStyle(
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
                                              Image.asset(
                                                  "assets/images/ccall.png"),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              Text(
                                                "${plans[index].nVirtualNumber} Virtual number",
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
                                          Row(
                                            children: [
                                              Image.asset(
                                                  "assets/images/call.png"),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              Text(
                                                "${plans[index].nTalktime} mins talk time",
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
                                          Row(
                                            children: [
                                              Image.asset(
                                                  "assets/images/wifi.png"),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              Text(
                                                "${plans[index].nData} data per month",
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
                                        ],
                                      ),
                                    ),
                                    Card(
                                      elevation: 10,
                                      color: cardbackgorundcolor,
                                      shadowColor: cardbackgorundcolor,
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 130,
                                        width: 100,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            Text(
                                              plans[index].nStartsFrom == null
                                                  ? "Starts @ 0 RS"
                                                  : "Starts @ ${plans[index].nStartsFrom} RS",
                                              style: const TextStyle(
                                                  color: whitecolor,
                                                  fontFamily: "Helvatica",
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: FontStyle.normal,
                                                  // fontStyle: FontStyle.italic,
                                                  fontSize: 12),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              width: 80,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: buttoncolor,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              alignment: Alignment.center,
                                              child: const Text(
                                                "Subscribe",
                                                style: TextStyle(
                                                    color: blackcolor,
                                                    fontSize: 12.0,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
