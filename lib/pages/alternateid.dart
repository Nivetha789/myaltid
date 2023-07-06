// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:myaltid/data/api.dart';
import 'package:myaltid/module/alternateid.dart';
import 'package:myaltid/pages/WebViewScreen.dart';
import 'package:myaltid/pages/kyc.dart';
import 'package:myaltid/widget/sharedpreference.dart';
import '../reasuable/dialogbox.dart';
import '../reasuable/theme.dart';

import '../reasuable/background_screen.dart';
import 'htmlscreen.dart';

class SelectAlternateID extends StatefulWidget {
  const SelectAlternateID({super.key});

  @override
  State<SelectAlternateID> createState() => _SelectAlternateIDState();
}

class _SelectAlternateIDState extends State<SelectAlternateID> {
  @override
  void initState() {
    GetPlan();
    super.initState();
  }

  bool isloading = false;
  List<JEmail> jemail = [];
  List<JMobile> jphonenumber = [];
  GetPlan() async {
    try {
      Dio dio = Dio();
      setState(() {
        isloading = false;
      });
      const SpinKitFadingCircle(
        color: buttoncolor,
        size: 50.0,
      );
      var token = await SharedPreference().gettoken();

      dio.options.contentType = Headers.formUrlEncodedContentType;
      final response = await dio.get(
        ApiProvider.getvirutalid,
        // data: parameters,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {"Authorization": "Bearer $token"},
        ),
      );
      debugPrint("pavithra123 ${response.data}");

      if (response.statusCode == 401) {
      } else if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.toString());
        debugPrint("response ${response.data}");
        setState(() {
          isloading = true;
        });
        // setState(() {
        //   ProgressDialog().dismissDialog(context);
        // });
        for (var i = 0; i < map["data"][0]["j_email"].length; i++) {
          debugPrint("response ${map["data"][0]["j_email"][i]}");

          setState(() {
            jemail.add(JEmail.fromJson(map["data"][0]["j_email"][i]));
          });
        }
        debugPrint("response ${map["data"][1]}");
        for (var j = 0; j < map["data"][1]["j_mobile"].length; j++) {
          debugPrint("response ${map["data"][1]["j_mobile"][j]}");

          setState(() {
            jphonenumber.add(JMobile.fromJson(map["data"][1]["j_mobile"][j]));
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
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  var vphoneneumber;
  TextEditingController vemail = TextEditingController();
  updateVirtulId() async {
    try {
      Dio dio = Dio();
      var token = await SharedPreference().gettoken();
      var parameters = {
        "n_Mobile": vphoneneumber,
        "c_Email": vemail.text,
      };
      debugPrint(parameters.toString());
      print("fgdfkjhgfdkjhgdf $token $parameters");
      dio.options.contentType = Headers.formUrlEncodedContentType;
      final response = await dio.post(
        ApiProvider.updatevirutalid,
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
        // paymentgatewaylink();
        // Navigator.of(context).push(
        //   MaterialPageRoute(builder: (context) => const KycScreen()),
        // );
        // await SharedPreference().setplanid(widget.cid);

        // await SharedPreference().setplanid(selectedOption!.id);

        // await SharedPreference().setUserId(response.data["data"]["_id"]);

        // // await SharedPreference()
        // //     .setUserId(response.data["data"]["c_ActivePlan"]);

        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => const PaymentmodeSelection()));
      } else {
        paymentgatewaylink();
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'On Snap!',
            message: response.data["message"][0],
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (e) {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'On Snap!',
          message: "Something went wrong, Please try again later",
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      debugPrint(e.toString());
      print(e);
    }
  }

  paymentgatewaylink() async {
    try {
      Dio dio = Dio();

      var token = await SharedPreference().gettoken();
      var phoneNumber = await SharedPreference().getphonenumber();
      print(phoneNumber);
      var cPlanId = await SharedPreference().getplanid();
      var cSubscriptionId = await SharedPreference().getsubscriptionId();

      var parameters = {
        "c_PlanId": cPlanId,
        "c_SubscriptionId": cSubscriptionId,
      };
      // print(parameters);
      // print(token);
      dio.options.contentType = Headers.formUrlEncodedContentType;
      final response = await dio.post(
        "http://13.59.194.102/app/index.php",
        data: parameters,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {"Authorization": "Bearer $token"},
        ),
      );
      debugPrint("pavithra ${response.data}");
      // var data = jsonDecode(response.data);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => WebViewScreen(response.data!)));

      if (response.data["status"] == 1) {
      print("dfkjsfddkjh" +response.data.toString());

      // await SharedPreference()
        //     .setUserId(response.data["data"]["c_ActivePlan"]);

        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => const PaymentSuccessfull()));
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
              isloading == false
                  ? const SpinKitFadingCircle(
                      color: buttoncolor,
                      size: 50.0,
                    )
                  : Column(
                      children: [
                        Card(
                          elevation: 10,
                          color: blackcolor,
                          shadowColor: buttoncolor,
                          child: Container(
                            height: 60,
                            padding: const EdgeInsets.all(10),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Diamond Plan",
                                  style: TextStyle(
                                      color: goldcolor,
                                      fontFamily: "Helvatica",
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      // fontStyle: FontStyle.italic,
                                      fontSize: 14),
                                ),
                                Text(
                                  "Change Plan",
                                  style: TextStyle(
                                      color: buttoncolor,
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
                        Card(
                          elevation: 10,
                          color: blackcolor,
                          shadowColor: buttoncolor,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Select your preferred Alternate ID",
                                  style: TextStyle(
                                      color: whitecolor,
                                      fontFamily: "Helvatica",
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      // fontStyle: FontStyle.italic,
                                      fontSize: 14),
                                ),

                                ListView.builder(
                                  itemCount: jphonenumber.length,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          vphoneneumber = jphonenumber[index]
                                              .nMobile
                                              .toString();
                                        });
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            jphonenumber[index]
                                                .nMobile
                                                .toString(),
                                            style: TextStyle(
                                                color: vphoneneumber ==
                                                        jphonenumber[index]
                                                            .nMobile
                                                            .toString()
                                                    ? buttoncolor
                                                    : whitecolor,
                                                fontFamily: "Helvatica",
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                // fontStyle: FontStyle.italic,
                                                fontSize: 14),
                                          ),
                                          const Divider(
                                            color: whitecolor,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),

                                // Text(
                                //   "909090909",
                                //   style: TextStyle(
                                //       color: whitecolor,
                                //       fontFamily: "Helvatica",
                                //       fontWeight: FontWeight.w400,
                                //       fontStyle: FontStyle.normal,
                                //       // fontStyle: FontStyle.italic,
                                //       fontSize: 14),
                                // ),
                                // Divider(
                                //   color: whitecolor,
                                // ),
                                // Text(
                                //   "887878878",
                                //   style: TextStyle(
                                //       color: whitecolor,
                                //       fontFamily: "Helvatica",
                                //       fontWeight: FontWeight.w400,
                                //       fontStyle: FontStyle.normal,
                                //       // fontStyle: FontStyle.italic,
                                //       fontSize: 14),
                                // ),
                                // Divider(
                                //   color: whitecolor,
                                // ),
                                // Text(
                                //   "565656565",
                                //   style: TextStyle(
                                //       color: whitecolor,
                                //       fontFamily: "Helvatica",
                                //       fontWeight: FontWeight.w400,
                                //       fontStyle: FontStyle.normal,
                                //       // fontStyle: FontStyle.italic,
                                //       fontSize: 14),
                                // ),
                                // SizedBox(
                                //   height: 20,
                                // ),
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
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Select Email",
                                  style: TextStyle(
                                      color: whitecolor,
                                      fontFamily: "Helvatica",
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      // fontStyle: FontStyle.italic,
                                      fontSize: 16),
                                ),
                                ListView.builder(
                                  itemCount: jemail.length,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          // vemail.text =
                                          //     jemail[index].cEmail.toString();
                                        });
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            jemail[index].cEmail.toString(),
                                            style: const TextStyle(
                                                color: whitecolor,
                                                fontFamily: "Helvatica",
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                // fontStyle: FontStyle.italic,
                                                fontSize: 14),
                                          ),
                                          const Divider(
                                            color: whitecolor,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                TextFormField(
                                  style: const TextStyle(color: whitecolor),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  minLines: 1,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please a Enter Your Email';
                                    }
                                    if (!RegExp(
                                            r'^[^.][a-z0-9._]+@[a-z0-9]+\.[a-z]+$',
                                            caseSensitive: false)
                                        .hasMatch(value)) {
                                      return 'Please a valid Email';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Write your own',
                                    hintStyle: TextStyle(
                                        color: whitecolor, fontSize: 15),
                                    // filled: true,
                                  ),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 1,
                                  onChanged: (value) {
                                    vemail.text = value;
                                  },
                                ),
                                const Text(
                                  "----------------------------------",
                                  style: TextStyle(
                                      color: whitecolor,
                                      fontFamily: "Helvatica",
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      // fontStyle: FontStyle.italic,
                                      fontSize: 14),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
              InkWell(
                  onTap: () {
                    if (vemail.text.isEmpty || vphoneneumber == null) {
                      final snackBar = SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'On Snap!',
                          message: "Please select your virtual id and email",
                          contentType: ContentType.failure,
                        ),
                      );

                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    } else {
                      updateVirtulId();
                    }
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
                      children: [
                        Text(
                          "ACTIVATE",
                          style: TextStyle(
                              color: blackcolor,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
