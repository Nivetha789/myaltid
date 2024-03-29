import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myaltid/data/api.dart';
import 'package:myaltid/pages/activeuserhome.dart';
import 'package:myaltid/pages/signup.dart';
import 'package:myaltid/widget/sharedpreference.dart';
import '../reasuable/dialogbox.dart';
import '../reasuable/theme.dart';
import '../reasuable/background_screen.dart';
import '../../reasuable/bottomnavbar.dart';

class Congratulations extends StatefulWidget {
  const Congratulations({super.key});

  @override
  State<Congratulations> createState() => CongratulationsState();
}

class CongratulationsState extends State<Congratulations> {
  bool isloading = false;
  var cemail, cname, cmobile, nsubscrption = "0", nsubscrptionprice = "0";

  @override
  void initState() {
    GetPlan();
    super.initState();
  }

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
                        Row(
                          children: [
                            const Text(
                              "Welcome ",
                              style: TextStyle(
                                  fontFamily: "Helvatica",
                                  color: whitecolor,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  // fontStyle: FontStyle.italic,
                                  fontSize: 20),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              cname ?? "",
                              style: const TextStyle(
                                  fontFamily: "Helvatica",
                                  color: whitecolor,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  // fontStyle: FontStyle.italic,
                                  fontSize: 20),
                              textAlign: TextAlign.start,
                            ),
                          ],
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Congratulations",
                              style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    color: goldcolor,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                    // fontStyle: FontStyle.italic,
                                    fontSize: 28),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Text(
                              "Your ALT ID has been successfully activated. You can start calling and emailing",
                              style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    color: whitecolor,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    // fontStyle: FontStyle.italic,
                                    fontSize: 14),
                              ),
                              textAlign: TextAlign.center,
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
                    Card(
                      elevation: 2,
                      color: blackcolor,
                      shadowColor: buttoncolor,
                      child: Container(
                        // height: 60,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Your Virtual Mobile Number is",
                              style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    color: whitecolor,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                    // fontStyle: FontStyle.italic,
                                    fontSize: 20),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              cmobile != "" ? cmobile : "-",
                              style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    color: whitecolor,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                    // fontStyle: FontStyle.italic,
                                    fontSize: 28),
                              ),
                              textAlign: TextAlign.center,
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
                    Card(
                      elevation: 2,
                      color: blackcolor,
                      shadowColor: buttoncolor,
                      child: Container(
                        // height: 60,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Your Virtual Email ID is",
                              style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    color: whitecolor,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                    // fontStyle: FontStyle.italic,
                                    fontSize: 20),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              cemail != "" ? cemail : "-",
                              style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    color: whitecolor,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                    // fontStyle: FontStyle.italic,
                                    fontSize: 25),
                              ),
                              textAlign: TextAlign.center,
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
                    Card(
                      elevation: 2,
                      color: blackcolor,
                      shadowColor: buttoncolor,
                      child: Container(
                        // height: 60,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Your Plan",
                              style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    color: whitecolor,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                    // fontStyle: FontStyle.italic,
                                    fontSize: 20),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              " ${nsubscrption ?? ""} Months, @ ${nsubscrptionprice ?? ""} Rs  Billed",
                              style: GoogleFonts.openSans(
                                textStyle: const TextStyle(
                                    color: whitecolor,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                    // fontStyle: FontStyle.italic,
                                    fontSize: 25),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    // GetPlan();
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ActiveUserHome()),
                                    );
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "ACTIVATE",
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
                                  width: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ActiveUserHome()),
                                    );
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: buttoncolor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    alignment: Alignment.center,
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Home",
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
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Text(
                                            'Are you sure, do you want to logout?',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w500),),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            child: Text('No'),
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: buttoncolor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1.7),
                                                )),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:buttoncolor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width / 2),
                                                )),
                                            child: Text('Yes'),
                                            onPressed: () async {
                                              await SharedPreference()
                                                  .clearSharep()
                                                  .then((v) {
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                        MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                Signup()));
                                              });
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: Container(
                                margin:
                                    EdgeInsets.only(top: 15.0, bottom: 15.0),
                                width: 140,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.logout,
                                      size: 22.0,
                                      color: buttoncolor,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 5.0),
                                      child: Text(
                                        "LOGOUT",
                                        style: TextStyle(
                                            color: buttoncolor,
                                            fontFamily: "Helvatica",
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
      print(token);
      // var phonenumber = await SharedPreference().getphonenumber();
      // var parameters = {
      //   "c_Name": name,
      //   "n_Mobile": phonenumber,
      //   "c_ReferralCode": "",
      //   "n_ActivePlan": ""
      // };
      dio.options.contentType = Headers.formUrlEncodedContentType;
      final response = await dio.get(
        ApiProvider.getuser,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {"Authorization": "Bearer $token"},
        ),
      );
      final response1 = await dio.get(
        ApiProvider.getdatautlize,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {"Authorization": "Bearer $token"},
        ),
      );
      debugPrint("pavithra123 ${response1.data}");

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
        debugPrint("response ${map}");
        await SharedPreference().setuserName(map["data"]["c_UserName"]);
        setState(() {
          isloading = true;
          cemail = map["data"]["c_virtualEmail"];
          cname = map["data"]["c_UserName"];
          cmobile = map["data"]["c_VirtualMobile"].toString();
          nsubscrption = map["data"]["n_SubscriptionDuration"].toString();
          nsubscrptionprice = map["data"]["n_SubscriptionPrice"].toString();
        });

        // setState(() {
        //   ProgressDialog().dismissDialog(context);
        // });
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
}
