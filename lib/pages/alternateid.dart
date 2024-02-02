import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myaltid/data/api.dart';
import 'package:myaltid/module/alternateid.dart';
import 'package:myaltid/pages/WebViewScreen.dart';
import 'package:myaltid/pages/signup.dart';
import 'package:myaltid/widget/sharedpreference.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../reasuable/dialogbox.dart';
import '../reasuable/theme.dart';

import '../reasuable/background_screen.dart';
import 'kyc.dart';

class SelectAlternateID extends StatefulWidget {
  const SelectAlternateID({super.key});

  @override
  State<SelectAlternateID> createState() => _SelectAlternateIDState();
}

class _SelectAlternateIDState extends State<SelectAlternateID> {
  bool isloading = false;
  List<JEmail> jemail = [];
  List<JMobile> jphonenumber = [];
  var vphoneneumber;
  TextEditingController vemail = TextEditingController();

  @override
  void initState() {
    GetPlan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Backgroundscreen(
      ccontainerchild: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.only(top: 30.0),
                  child: Row(
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
                        alignment: Alignment.centerRight,
                        child: ClipOval(
                          child: Material(
                            color: blackcolor, // Button color
                            child: InkWell(
                              splashColor: Colors.red, // Splash color
                              onTap: () async {
                                if (await SharedPreference().getLogin() == "1") {
                                  Dialogbox(context);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Select your Alternate ID",
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
                ),
              ),
              isloading == false
                  ? const SpinKitFadingCircle(
                      color: buttoncolor,
                      size: 50.0,
                    )
                  : Expanded(
                      flex: 9,
                      child: Container(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Card(
                              elevation: 10,
                              color: blackcolor,
                              shadowColor: buttoncolor,
                              child: Container(
                                height: 60,
                                padding: const EdgeInsets.all(10),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                            Container(
                              margin: EdgeInsets.only(
                                  left: 16.0, top: 10.0, bottom: 10.0),
                              child: const Text(
                                "Select your preferred Alternate ID",
                                style: TextStyle(
                                    color: whitecolor,
                                    fontFamily: "Helvatica",
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    // fontStyle: FontStyle.italic,
                                    fontSize: 14),
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
                                    ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: jphonenumber.length,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(
                                          onTap: () async{
                                            setState(() {
                                              vphoneneumber =
                                                  jphonenumber[index]
                                                      .nMobile
                                                      .toString();
                                              vemail.text = vphoneneumber +
                                                  "@myaltid.com";
                                            });
                                            await SharedPreference().setUserMobile(vphoneneumber);
                                            await SharedPreference().setUserEmail(vemail.text);
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
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                elevation: 10,
                                color: blackcolor,
                                shadowColor: buttoncolor,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Your Email ID",
                                        style: TextStyle(
                                            color: whitecolor,
                                            fontFamily: "Helvatica",
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                            // fontStyle: FontStyle.italic,
                                            fontSize: 16),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10.0),
                                        child: TextFormField(
                                          autofocus: false,
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.text,
                                          controller: vemail,
                                          maxLines: 1,
                                          enabled: false,
                                          maxLengthEnforcement:
                                              MaxLengthEnforcement.enforced,
                                          style: const TextStyle(
                                              color: whitecolor,
                                              fontFamily: "Helvatica",
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal,
                                              // fontStyle: FontStyle.italic,
                                              fontSize: 14),
                                        ),
                                      ),
                                      const Text(
                                        "----------------------------------",
                                        style: TextStyle(
                                            color: whitecolor,
                                            fontFamily: "Helvatica",
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            // fontStyle: FontStyle.italic,
                                            fontSize: 15),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ),
              InkWell(
                  onTap: () {
                    if (vphoneneumber == null) {
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

  GetPlan() async {
    try {
      Dio dio = Dio();
      isloading = false;
      const SpinKitFadingCircle(
        color: buttoncolor,
        size: 50.0,
      );
      var token = await SharedPreference().gettoken();
      print("tokensubcription/getVirtualId " + token);

      dio.options.contentType = Headers.formUrlEncodedContentType;
      final response = await dio.get(
        ApiProvider.getvirutalid,
        // data: parameters,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {"Authorization": "Bearer $token"},
        ),
      );
      debugPrint("getvirutalid ${response.data}");

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
      }
      else if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.toString());
        debugPrint("response ${response.data}");
        if (map["status"] == 1) {
          isloading = true;
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
        }else if(map["message"] == "Invalid token."){
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
        } else {
          isloading = false;
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
        showDialog(context: context, builder: (BuildContext context) => dialog);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  updateVirtulId() async {
    try {
      Dio dio = Dio();
      var token = await SharedPreference().gettoken();
      var parameters = {
        "n_Mobile": vphoneneumber,
        "c_Email": vemail.text,
      };
      debugPrint(parameters.toString());
      print("virtualiddparams $token $parameters");
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
        await SharedPreference().setLogin("4");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => KycScreen()),
            (Route<dynamic> route) => false);
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
      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => WebViewScreen(response.data!,"")));

      if (response.data["status"] == 1) {
        print("dfkjsfddkjh" + response.data.toString());

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
}
