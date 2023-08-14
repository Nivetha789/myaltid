import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/api.dart';
import '../../module/DndModel/UpdateDndPreferenceModel.dart';
import '../../module/UserProfileModel/UserProfileModel.dart';
import '../../reasuable/background_screen.dart';
import '../../reasuable/bottomnavbar.dart';
import '../../reasuable/dialogbox.dart';
import '../../reasuable/theme.dart';
import '../../utils/check_internet.dart';
import '../../widget/progressloaded.dart';
import '../../widget/sharedpreference.dart';

class EnableDndScreen extends StatefulWidget {

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

  var enablednd = false;
  var callaler1 = true;
  var callaler2 = true;
  var msgalert1 = true;
  var msgalert2 = true;
  var disablednd = false;
  var disabledndclalert1 = false;
  var disabledndclalert2 = false;
  var disabledndmsgalert1 = false;
  var disabledndmsgalert2 = false;

  var dndEnabled = 0;

  @override
  void initState() {
    check().then((intenet) {
      if (intenet != null && intenet) {
        userProfileApi();
      } else {
        Fluttertoast.showToast(
            msg: "Please check your internet connection",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.white,
            backgroundColor: buttoncolor,
            timeInSecForIosWeb: 1);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:(){
        Navigator.pop(context);
        return Future.value(false);
        },
      child: Backgroundscreen(
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
                        enablednd
                            ? Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        CupertinoSwitch(
                                            activeColor: buttoncolor,
                                            thumbColor: whitecolor,
                                            trackColor: Colors.grey,
                                            value: enablednd,
                                            onChanged: (value) {
                                              setState(() {
                                                enablednd = value;
                                                if (enablednd) {
                                                  dndEnabled = 1;
                                                } else {
                                                  dndEnabled = 0;
                                                }
                                              });
                                            }),
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
                                  ],
                                ),
                              ):Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CupertinoSwitch(
                                      activeColor: buttoncolor,
                                      thumbColor: whitecolor,
                                      trackColor: Colors.grey,
                                      value: disablednd,
                                      onChanged: (value) {
                                        setState(() {
                                          disablednd = value;
                                          if (disablednd) {
                                            enablednd=true;
                                            callaler1 = true;
                                            callaler2 = true;
                                            msgalert1 = true;
                                            msgalert2 = true;
                                            dndEnabled = 1;
                                          } else {
                                            enablednd=true;
                                            callaler1 = true;
                                            callaler2 = true;
                                            msgalert1 = true;
                                            msgalert2 = true;
                                            dndEnabled = 1;
                                          }
                                        });
                                      }),
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
                                    onChanged: (value) => setState(
                                            () => disabledndclalert1 = value),
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
                                    onChanged: (value) => setState(
                                            () => disabledndclalert2 = value),
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
                                    onChanged: (value) => setState(
                                            () => disabledndmsgalert1 = value),
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
                                    onChanged: (value) => setState(
                                            () => disabledndmsgalert2 = value),
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
                        )
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
                              check().then((intenet) {
                                if (intenet != null && intenet) {
                                  dndUpdateApi(dndEnabled);
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                      "Please check your internet connection",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      textColor: Colors.white,
                                      backgroundColor: buttoncolor,
                                      timeInSecForIosWeb: 1);
                                }
                              });
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
      ),
    );
  }

  //dnd update
  dndUpdateApi(int dndValue) async {
    ProgressDialog().showLoaderDialog(context);

    Dio dio = new Dio();

    var token = await SharedPreference().gettoken();
    var parameters = {
      "n_CallAddressBook": 0,
      "n_CallActiveMode": 0,
      "n_SmsPeople": 0,
      "n_SmsAddressBook": 0,
      "n_Dnd": dndValue,
      "n_Biometric": 0
    };
    // print("dashParam: " + parameters.toString());
    dio.options.contentType = Headers.formUrlEncodedContentType;
    final response = await dio.post(ApiProvider.updateDND,
        options:
            Options(contentType: Headers.formUrlEncodedContentType, headers: {
          'Content-Type': "application/json",
          'Authorization': "Bearer " + token,
        }),
        data: parameters);
    print("paramDnd " + parameters.toString());
    print(response.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.toString());
      UpdateDndPreferenceModel updateDndPreferenceModel =
          UpdateDndPreferenceModel.fromJson(map);

      if (updateDndPreferenceModel.status == 1) {
        await SharedPreference()
            .setDnd(updateDndPreferenceModel.data![0].nDnd.toString());
        ProgressDialog().dismissDialog(context);
        Fluttertoast.showToast(
            msg: updateDndPreferenceModel.message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            textColor: Colors.white,
            backgroundColor: buttoncolor,
            timeInSecForIosWeb: 1);
        Navigator.pop(context);
      } else {
        setState(() {
          // checkInbox = false;
          // inboxNoData = true;
          // noDataText = updateDndPreferenceModel.message!;
        });
        ProgressDialog().dismissDialog(context);
      }
    } else {
      setState(() {
        // matchingProfileNoData = true;
        // matchingProfileNoDataTxt = "Bad Network Connection try again..";
        // print("gftftftddsffdf");
      });
      ProgressDialog().dismissDialog(context);
    }
  }

  //profile
  userProfileApi() async {
    ProgressDialog().showLoaderDialog(context);

    Dio dio = new Dio();

    var token = await SharedPreference().gettoken();
    // print("dashParam: " + parameters.toString());
    dio.options.contentType = Headers.formUrlEncodedContentType;
    final response = await dio.get(
      ApiProvider.getuser,
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {"Authorization": "Bearer $token"},
      ),
    );
    print("resProfile " + response.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.toString());
      UserProfileModel userProfileModel = UserProfileModel.fromJson(map);

      if (userProfileModel.status == 1) {
        ProgressDialog().dismissDialog(context);
        int dndStatus = userProfileModel.data!.nDnd!;
        print("dndStatus11111 " + dndStatus.toString());
        await SharedPreference()
            .setDnd(dndStatus.toString());
        if (dndStatus == 1) {
          setState(() {
            enablednd = true;
            callaler1 = true;
            callaler2 = true;
            msgalert1 = true;
            msgalert2 = true;
          });
        } else {
          setState(() {
            disablednd = true;
            disabledndclalert1 = true;
            disabledndclalert2 = true;
            disabledndmsgalert1 = true;
            disabledndmsgalert2 = true;
          });
        }
      } else {
        ProgressDialog().dismissDialog(context);
      }
    } else {
      setState(() {
        // matchingProfileNoData = true;
        // matchingProfileNoDataTxt = "Bad Network Connection try again..";
        // print("gftftftddsffdf");
      });
      ProgressDialog().dismissDialog(context);
    }
  }
}
