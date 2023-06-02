// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myaltid/data/api.dart';
import 'package:myaltid/pages/congratulation.dart';
import 'package:myaltid/widget/mobilenumberformator.dart';
import 'package:myaltid/widget/sharedpreference.dart';
import '../reasuable/theme.dart';

import '../reasuable/background_screen.dart';

import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class KycScreen extends StatefulWidget {
  const KycScreen({super.key});

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  TextEditingController username = TextEditingController();

  TextEditingController pannumber = TextEditingController();
  TextEditingController aadharnumber = TextEditingController();

  final formKey = GlobalKey<FormState>();
  var otp;
  aadharOTPsend() async {
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
        const snackBar = SnackBar(
          backgroundColor: Colors.green,
          content: Text('OTP has been sended registered mobile number'),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        debugPrint(response.data["data"]["requestId"]);
        setState(() {
          requestid = response.data["data"]["requestId"];
          debugPrint("requestid $requestid");
        });
      } else {
        const snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: Text('Please enter valid aadhaar number'),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (e) {
      debugPrint(e as String?);
    }
  }

  var requestid;
  var dob;

  OTPcheck() async {
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
        const snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: Text('Please enter valid otp'),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (e) {
      debugPrint(e as String?);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  UserRegister() async {
    try {
      Dio dio = Dio();

      var userid = await SharedPreference().getUserId();
      var parameters = {
        "c_UserId": userid,
        "c_Pan": pannumber.text,
        "c_Email": username.text,
        "n_Aadhar": aadharnumber.text.toString(),
        "c_Dob": dob
      };
      dio.options.contentType = Headers.formUrlEncodedContentType;
      final response = await dio.post(
        ApiProvider.updatekyc,
        data: parameters,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      debugPrint("pavithra ${response.data}");

      if (response.statusCode == 401) {
      } else if (response.statusCode == 200) {
        if (response.data["status"] == 1) {
          // await SharedPreference().setplanid(widget.cid);

          // await SharedPreference().setplanid(selectedOption!.id);

          // await SharedPreference().setUserId(response.data["data"]["_id"]);

          // await SharedPreference()
          //     .setUserId(response.data["data"]["c_ActivePlan"]);

          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const Congratulations()),
          );
        } else {
          final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'On Snap!',
              message: response.data["error"],
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
                  "Email ID (other than MYALTID)",
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
                  style: const TextStyle(color: whitecolor, fontSize: 16),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // inputFormatters: [
                  //   FilteringTextInputFormatter.allow(
                  //     RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]"),
                  //   ),
                  // ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please a Enter Your Email';
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
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
                    // FilteringTextInputFormatter.allow(
                    //   RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$'),
                    // ),
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
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Enter Aadhar Number",
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
                      return 'Please a Enter your Aadhar number';
                    }
                    if (!RegExp(r'^[0-9]{12}$').hasMatch(value)) {
                      return 'Please a valid Number';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    value.toString().length == 12
                        ? aadharOTPsend()
                        : 'Minimum character length is 12';
                  },
                  keyboardType: TextInputType.number,
                  maxLength: 12,
                  decoration: const InputDecoration(
                    hintText: "Aadhar Number",
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
                const SizedBox(
                  height: 10,
                ),
                OTPTextField(
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
                    debugPrint("Completed: $pin" + otp);
                  },
                  otpFieldStyle: OtpFieldStyle(
                    borderColor: const Color(0xff1C1C1E),
                    backgroundColor: const Color(0xff1C1C1E),
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
                      if (formKey.currentState!.validate()) {
                        OTPcheck();
                      }
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
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Submit KYC",
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
      ),
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
