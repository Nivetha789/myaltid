// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myaltid/data/api.dart';
import 'package:myaltid/pages/congratulation.dart';
import 'package:myaltid/pages/signup.dart';
import 'package:myaltid/widget/mobilenumberformator.dart';
import 'package:myaltid/widget/progressloaded.dart';
import 'package:myaltid/widget/sharedpreference.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

import '../reasuable/background_screen.dart';
import '../reasuable/theme.dart';

class KycScreen extends StatefulWidget {
  const KycScreen({super.key});

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  TextEditingController username = TextEditingController();

  TextEditingController pannumber = TextEditingController();
  TextEditingController aadharnumber = TextEditingController();

  bool otpField = false;
  String btnText = "Submit";

  final formKey = GlobalKey<FormState>();
  var otp;
  bool dateofbirth = false;

  /*aadharOTPsend() async {
    debugPrint("PAIVTHRA");
    try {
      Dio dio = Dio();

      var parameters = {
        "aadhaarNumber": aadharnumber.text.toString(),
      };
      dio.options.contentType = Headers.formUrlEncodedContentType;
      final response = await dio.post(
          "https://api-preproduction.signzy.app/api/v3/getOkycOtp",
          data: parameters,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': "q7L2rmqQfn9A21KphPyAXKLt32yVfz99",
          }));
      debugPrint("PAVITHRA ${response.data}");

      if (response.statusCode == 401) {
        final snackBar = SnackBar(
          /// need to set following properties for best effect of awesome_snackbar_content
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'On Snap!',
            message:
                'This is an example error message that will be shown in the body of snackbar!',

            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      } else if (response.statusCode == 200) {
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Oh Hey!',
            message: "Success",
            contentType: ContentType.success,
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);

        // ScaffoldMessenger.of(context)
        //   ..hideCurrentSnackBar()
        //   ..showSnackBar(snackBar);
        debugPrint(response.data["data"]["requestId"]);
        setState(() {
          requestid = response.data["data"]["requestId"];
          btnText = "Verify OTP";
          debugPrint("requestid $requestid");
        });
      } else {
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'On Snap!',
            message: 'Please enter valid aadhaar number',
            contentType: ContentType.failure,
          ),
        );
        // const snackBar = SnackBar(
        //   backgroundColor: Colors.red,
        //   content: Text('Please enter valid aadhaar number'),
        //   duration: Duration(seconds: 2),
        // );
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (e) {
      debugPrint(e as String?);
    }
  }*/

  var requestid;
  var dob;

  /*OTPcheck() async {
    debugPrint("pavithra12343 $requestid");

    try {
      Dio dio = Dio();

      var parameters = {"requestId": requestid, "otp": otp};
      dio.options.contentType = Headers.formUrlEncodedContentType;
      final response = await dio.post(
          "https://api-preproduction.signzy.app/api/v3/fetchOkycData",
          data: parameters,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': "q7L2rmqQfn9A21KphPyAXKLt32yVfz99",
          }));
      debugPrint("pavithra ${response.data}");

      if (response.statusCode == 401) {
      } else if (response.data["data"]["dob"] != null) {
        setState(() {
          dob = response.data["data"]["dob"];
          print("dob $dob");
        });
        UserRegister();
        // Navigator.of(context).push(
        //   MaterialPageRoute(builder: (context) => const Congratulations()),
        // );
      } else {
        otpController.clear();
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'On Snap!',
            message: 'Please enter valid otp!',
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }*/

  @override
  void initState() {
    super.initState();
  }

  var selectedMonth;
  var selectedDate;
  var selectedYear;

  List<int> getMonths() {
    return List<int>.generate(12, (index) => index + 1);
  }

  List<int> getDaysInMonth(int month, int year) {
    if (month == 2) {
      if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
        return List<int>.generate(29, (index) => index + 1);
      } else {
        return List<int>.generate(28, (index) => index + 1);
      }
    } else if ([4, 6, 9, 11].contains(month)) {
      return List<int>.generate(30, (index) => index + 1);
    } else {
      return List<int>.generate(31, (index) => index + 1);
    }
  }

  List<int> getYears() {
    int currentYear = DateTime.now().year;
    return List<int>.generate(100, (index) => currentYear - index);
  }

  bool isage = false;

  bool isAbove18Years(int year, int month, int day) {
    DateTime currentDate = DateTime.now();
    DateTime selectedDate = DateTime(year, month, day);
    Duration difference = currentDate.difference(selectedDate);
    int age = (difference.inDays / 365).floor();
    if (age >= 18) {
      print("fdhghgdfhgdfg $age");
      setState(() {
        isage = false;
      });
    } else {
      print("fdg $age");
      setState(() {
        isage = true;
      });
    }

    return age >= 18;
  }

  UserRegister() async {
    ProgressDialog().showLoaderDialog(context);
    Dio dio = Dio();

    var token = await SharedPreference().gettoken();
    print("tokennnnn " + token);
    var parameters = {
      "c_Pan": pannumber.text,
      "c_Email": username.text,
      "n_Aadhar": aadharnumber.text.toString(),
      "c_Dob": selectedDate.toString() +
          "/" +
          selectedMonth.toString() +
          "/" +
          selectedYear.toString()
    };
    print("updatekycParam $parameters");
    dio.options.contentType = Headers.formUrlEncodedContentType;
    final response = await dio.post(ApiProvider.updatekyc,
        options:
            Options(contentType: Headers.formUrlEncodedContentType, headers: {
          'Content-Type': "application/json",
          'Authorization': "Bearer " + token,
        }),
        data: parameters);
    debugPrint("updatekycRes ${response.data}");

    if (response.statusCode == 200) {
      if (response.data["status"] == 1) {
        ProgressDialog().dismissDialog(context);
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Oh Hey!',
            message: 'Otp has been sent to registered mobile number!',
            contentType: ContentType.success,
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        setState(() {
          otpField = true;
          btnText = "Verify OTP";
        });
        // Navigator.of(context).push(
        //   MaterialPageRoute(builder: (context) => const Congratulations()),
        // );
      } else {
        otpField = false;
        ProgressDialog().dismissDialog(context);
          final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'On Snap!',
              message: response.data["error"].toString(),
              contentType: ContentType.failure,
            ),
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
      }
    } else if (response.statusCode == 401) {
      ProgressDialog().dismissDialog(context);
      var dialog = AlertDialog(
        title: Text('Login',
            style: TextStyle(
                color: buttoncolor, fontWeight: FontWeight.w700, fontSize: 16)),
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
      ProgressDialog().dismissDialog(context);
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'On Snap!',
          message: "Something went wrong... try again...",
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  verifykyc() async {
    ProgressDialog().showLoaderDialog(context);
    try {
      Dio dio = Dio();
      var token = await SharedPreference().gettoken();
      print(token);
      var parameters = {
        "n_otp": otp,
      };
      dio.options.contentType = Headers.formUrlEncodedContentType;
      final response = await dio.post(
        ApiProvider.verifykyc,
        data: parameters,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {"Authorization": "Bearer $token"},
        ),
      );

      print("kycResponse : " + response.toString());
      if (response.statusCode == 200) {
        if (response.data["status"] == 1) {
          ProgressDialog().dismissDialog(context);
          await SharedPreference().setLogin("1");
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Congratulations()),
          );
        } else {
          print("errrorrrr "+response.data["error"].toString());
          ProgressDialog().dismissDialog(context);
          otpController = new OtpFieldController();
          if(response.data["error"].toString().contains("Verification Failed")){
            final snackBar = SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: 'On Snap!',
                message: "Invalid OTP!",
                contentType: ContentType.failure,
              ),
            );

            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar);
          }else{
            final snackBar = SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: 'On Snap!',
                message: response.data["error"].toString(),
                contentType: ContentType.failure,
              ),
            );

            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar);
          }
        }
      } else if (response.statusCode == 401) {
        ProgressDialog().dismissDialog(context);
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
      ProgressDialog().dismissDialog(context);
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
    }
  }

  OtpFieldController otpController = OtpFieldController();

  // int _selectedDay = 14;
  // int _selectedMonth = 10;
  // int _selectedYear = 1993;
  // final List<String> _dates =
  //     List.generate(31, (index) => (index + 1).toString());
  // final List<String> _months = [
  //   '1',
  //   '2',
  //   '3',
  //   '4',
  //   '5',
  //   '6',
  //   '7',
  //   '8',
  //   '9',
  //   '10',
  //   '11',
  //   '12',
  // ];
  // final List<String> _years =
  //     List.generate(50, (index) => (2023 - index).toString());

  @override
  Widget build(BuildContext context) {
    return Backgroundscreen(
      ccontainerchild: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Image.asset("assets/images/myaltidlogo.png"),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Complete your KYC",
                  style: TextStyle(
                      fontFamily: "Helvatica",
                      color: whitecolor,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      // fontStyle: FontStyle.italic,
                      fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 0,
                ),
                const Text(
                  "Email ID (Aadhaar linked email)",
                  style: TextStyle(
                    fontFamily: "Helvatica",
                    color: whitecolor,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    // fontStyle: FontStyle.italic,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: username,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: whitecolor, fontSize: 16),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // inputFormatters: [
                  //   FilteringTextInputFormatter.allow(
                  //     RegExp(r'^[^.][a-z0-9._]+@[a-z0-9]+\.[a-z]+$',
                  //         caseSensitive: false),
                  //   ),
                  // ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please a Enter Your Email';
                    }
                    if (!RegExp(r'^[^.][a-z0-9._]+@[a-z0-9]+\.[a-z]+$',
                            caseSensitive: false)
                        .hasMatch(value)) {
                      return 'Please a valid Email';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Email id",
                    hintStyle: TextStyle(color: whitecolor, fontSize: 14),
                    fillColor: Color(0xff1C1C1E),
                    filled: true,
                    border: OutlineInputBorder(
                      //Outline border type for TextFeild
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      //Outline border type for TextFeild
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Enter PAN Number",
                  style: TextStyle(
                    fontFamily: "Helvatica",
                    color: whitecolor,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    // fontStyle: FontStyle.italic,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: pannumber,
                  textCapitalization: TextCapitalization.characters,
                  maxLength: 10,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                    UpperCaseTextFormatter(),
                  ],
                  // inputFormatters: [UpperCaseTextFormatter()],
                  style: const TextStyle(color: whitecolor, fontSize: 16),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please a Enter Your PAN Number';
                    }
                    if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$')
                        .hasMatch(value)) {
                      return 'Please a valid PAN Number (Eg:ABCDE1234H)';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "PAN Number",
                    hintStyle: TextStyle(color: whitecolor, fontSize: 14),
                    fillColor: Color(0xff1C1C1E),
                    filled: true,
                    border: OutlineInputBorder(
                      //Outline border type for TextFeild
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      //Outline border type for TextFeild
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                ),
                const Text(
                  "Date of Birth (as per KYC)",
                  style: TextStyle(
                    fontFamily: "Helvatica",
                    color: whitecolor,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    // fontStyle: FontStyle.italic,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xff1C1C1E),
                        ),
                        child: DropdownButton<int>(
                            padding: const EdgeInsets.only(left: 10),
                            isExpanded: true,
                            value: selectedDate,
                            hint: const Text(
                              'Date',
                              style: TextStyle(
                                fontFamily: "Helvatica",
                                color: whitecolor,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                // fontStyle: FontStyle.italic,
                                fontSize: 14,
                              ),
                            ),
                            onChanged: (newValue) {
                              setState(() {
                                selectedDate = newValue;
                              });
                            },
                            dropdownColor: const Color(0xff1C1C1E),
                            underline: const SizedBox(),
                            items: getDaysInMonth(0, 0 ?? DateTime.now().year)
                                .map((int value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: Text(
                                  value.toString(),
                                  style: const TextStyle(
                                    fontFamily: "Helvatica",
                                    color: whitecolor,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    // fontStyle: FontStyle.italic,
                                    fontSize: 14,
                                  ),
                                ),
                              );
                            }).toList()),
                      ),
                      Container(
                        width: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xff1C1C1E),
                        ),
                        child: DropdownButton<int>(
                          padding: const EdgeInsets.only(left: 10),
                          isExpanded: true,
                          value: selectedMonth,
                          hint: const Text(
                            'Month',
                            style: TextStyle(
                              fontFamily: "Helvatica",
                              color: whitecolor,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              // fontStyle: FontStyle.italic,
                              fontSize: 14,
                            ),
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              selectedMonth = newValue;
                              print("monthhhhhh " +
                                  selectedMonth.toString() +
                                  ", " +
                                  selectedDate.toString());
                              if (selectedDate == 29 && selectedMonth == 2 ||
                                  selectedDate == 30 && selectedMonth == 2 ||
                                  selectedDate == 31 && selectedMonth == 2) {
                                Fluttertoast.showToast(
                                    msg: "Please change date...",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    textColor: Colors.white,
                                    backgroundColor: buttoncolor,
                                    timeInSecForIosWeb: 1);
                                selectedDate = null;
                              } else if (selectedDate == 31 &&
                                  selectedMonth == 6) {
                                Fluttertoast.showToast(
                                    msg: "Please change date...",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    textColor: Colors.white,
                                    backgroundColor: buttoncolor,
                                    timeInSecForIosWeb: 1);
                                selectedDate = null;
                              } else if (selectedDate == 31 &&
                                  selectedMonth == 4) {
                                Fluttertoast.showToast(
                                    msg: "Please change date...",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    textColor: Colors.white,
                                    backgroundColor: buttoncolor,
                                    timeInSecForIosWeb: 1);
                                selectedDate = null;
                              } else if (selectedDate == 31 &&
                                  selectedMonth == 9) {
                                Fluttertoast.showToast(
                                    msg: "Please change date...",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    textColor: Colors.white,
                                    backgroundColor: buttoncolor,
                                    timeInSecForIosWeb: 1);
                                selectedDate = null;
                              } else if (selectedDate == 31 &&
                                  selectedMonth == 11) {
                                Fluttertoast.showToast(
                                    msg: "Please change date...",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    textColor: Colors.white,
                                    backgroundColor: buttoncolor,
                                    timeInSecForIosWeb: 1);
                                selectedDate = null;
                              } else {
                                selectedDate = selectedDate;
                              }
                            });
                          },
                          dropdownColor: const Color(0xff1C1C1E),
                          underline: const SizedBox(),
                          items: getMonths().map((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(
                                value.toString(),
                                style: const TextStyle(
                                  fontFamily: "Helvatica",
                                  color: whitecolor,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  // fontStyle: FontStyle.italic,
                                  fontSize: 14,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xff1C1C1E),
                        ),
                        child: DropdownButton<int>(
                          padding: const EdgeInsets.only(left: 10),
                          isExpanded: true,
                          value: selectedYear,
                          hint: const Text(
                            'Year',
                            style: TextStyle(
                              fontFamily: "Helvatica",
                              color: whitecolor,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              // fontStyle: FontStyle.italic,
                              fontSize: 14,
                            ),
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              selectedYear = newValue;
                            });
                          },
                          dropdownColor: const Color(0xff1C1C1E),

                          underline: const SizedBox(),
                          // decoration: InputDecoration(
                          //   enabledBorder: InputBorder.none, // Remove the border
                          //   focusedBorder:
                          //       InputBorder.none, // Remove the border when focused
                          //   hintText: "Seleted year",
                          // ),
                          items: getYears().map((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(
                                value.toString(),
                                style: const TextStyle(
                                  fontFamily: "Helvatica",
                                  color: whitecolor,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  // fontStyle: FontStyle.italic,
                                  fontSize: 14,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                dateofbirth == true || isage == true
                    ? const Text(
                        "Select valid date of birth & age should be above 18 years",
                        style: TextStyle(color: Colors.red),
                      )
                    : const Text("testttt"),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Enter Aadhaar Number",
                  style: TextStyle(
                    fontFamily: "Helvatica",
                    color: whitecolor,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    // fontStyle: FontStyle.italic,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: aadharnumber,
                  style: const TextStyle(color: whitecolor, fontSize: 16),
                  inputFormatters: [MobileNumberInputFormatter()],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please a Enter your Aadhaar number';
                    }
                    if (!RegExp(r'^[0-9]{12}$').hasMatch(value)) {
                      return 'Please a valid Number';
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    print("valueeeee " + value);
                    if (value.length == 12) {
                      btnText = "Send OTP";
                    } else {
                      btnText = "Submit KYC";
                      otpField = false;
                    }
                  },
                  onChanged: (value) {
                    'Minimum character length is 12';
                    if (aadharnumber.text.length == 12) {
                      btnText = "Send OTP";
                    } else {
                      btnText = "Submit KYC";
                      otpField = false;
                    }
                  },
                  keyboardType: TextInputType.number,
                  maxLength: 12,
                  decoration: const InputDecoration(
                    hintText: "Aadhaar Number",
                    hintStyle: TextStyle(color: whitecolor, fontSize: 14),
                    fillColor: Color(0xff1C1C1E),
                    filled: true,
                    border: OutlineInputBorder(
                      //Outline border type for TextFeild
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      //Outline border type for TextFeild
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: otpField,
                  child: Text(
                    "Enter OTP",
                    style: TextStyle(
                      fontFamily: "Helvatica",
                      color: whitecolor,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      // fontStyle: FontStyle.italic,
                      fontSize: 14,
                    ),
                  ),
                ),
                Visibility(
                  visible: otpField,
                  child: const SizedBox(
                    height: 10,
                  ),
                ),
                Visibility(
                  visible: otpField,
                  child: OTPTextField(
                    controller: otpController,
                    length: 6,
                    width: MediaQuery.of(context).size.width,
                    fieldWidth: 50,
                    fieldStyle: FieldStyle.box,
                    style: const TextStyle(
                        color: whitecolor,
                        fontSize: 15,
                        fontFamily: "Helvatica",
                        fontWeight: FontWeight.w500),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    onCompleted: (pin) {
                      otp = pin;
                      btnText = "Submit KYC";
                      debugPrint("Completed: $pin" + otp);
                      if (btnText == "Submit KYC") {
                        verifykyc();
                      }
                    },
                    otpFieldStyle: OtpFieldStyle(
                      borderColor: const Color(0xff1C1C1E),
                      backgroundColor: const Color(0xff1C1C1E),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                    onTap: () {
                      // if (isloading == false) {
                      if (formKey.currentState!.validate() &&
                          selectedDate != null &&
                          selectedMonth != null &&
                          selectedYear != null &&
                          isAbove18Years(
                              selectedYear, selectedMonth, selectedDate)) {
                        print("btnText " + btnText.toString());
                        if (btnText == "Send OTP") {
                          UserRegister();
                        } else if (btnText == "Verify OTP") {
                          if (otp == null) {
                            Fluttertoast.showToast(
                                msg: "Enter OTP!!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                textColor: Colors.white,
                                backgroundColor: buttoncolor,
                                timeInSecForIosWeb: 1);
                          } else {
                            if (otp.length == 6 && btnText == "Submit KYC") {
                              verifykyc();
                            }
                          }
                        }
                        setState(() {
                          dateofbirth = false;
                        });
                      } else {
                        setState(() {
                          dateofbirth = true;
                        });
                      }
                      // } else {}
                    },
                    child: Container(
                      width: 140,
                      height: 40,
                      decoration: BoxDecoration(
                        color: buttoncolor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            btnText,
                            style: TextStyle(
                                color: blackcolor,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  var _selectedDate;
  var _selectedMonth;
  var _selectedYear;

  Widget _buildDropdownButton(String label, List<String> items, String? value,
      void Function(String?)? onChanged) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      padding: const EdgeInsets.only(left: 10),
      value: value,
      dropdownColor: const Color(0xff1C1C1E),
      onChanged: onChanged,
      // underline: SizedBox(),
      decoration: InputDecoration(
        enabledBorder: InputBorder.none, // Remove the border
        focusedBorder: InputBorder.none, // Remove the border when focused
        hintText: label,
      ),
      items: [
        DropdownMenuItem<String>(
          value: null,
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: "Helvatica",
              color: whitecolor,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              // fontStyle: FontStyle.italic,
              fontSize: 14,
            ),
          ),
        ),
        ...items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(
                fontFamily: "Helvatica",
                color: whitecolor,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                // fontStyle: FontStyle.italic,
                fontSize: 14,
              ),
            ),
          );
        }),
      ],
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
