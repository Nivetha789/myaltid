// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
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
  bool dateofbirth = false;
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
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Oh Hey!',
            message: 'Otp has been sended registered mobile number!',
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
  }

  @override
  void initState() {
    super.initState();
  }

  UserRegister() async {
    print(_selectedDate);
    try {
      Dio dio = Dio();

      var token = await SharedPreference().gettoken();
      var parameters = {
        "c_Pan": pannumber.text,
        "c_Email": username.text,
        "n_Aadhar": aadharnumber.text.toString(),
        "c_Dob": _selectedDate + "/" + _selectedMonth + "/" + _selectedYear
      };
      print("PAVITHRA $parameters");
      dio.options.contentType = Headers.formUrlEncodedContentType;
      final response = await dio.post(
        ApiProvider.updatekyc,
        data: parameters,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {"Authorization": "Bearer $token"},
        ),
      );
      debugPrint("pavithra ${response.data}");

      if (response.data["status"] == 1) {
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Oh Hey!',
            message: 'Otp has been sended registered mobile number!',
            contentType: ContentType.success,
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        // Navigator.of(context).push(
        //   MaterialPageRoute(builder: (context) => const Congratulations()),
        // );
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
      debugPrint(e.toString());
    }
  }

  verifykyc() async {
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
      debugPrint("pavithra123 ${response.data}");

      if (response.data["status"] == 1) {
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
            message: "Please enter valid otp",
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

  OtpFieldController otpController = OtpFieldController();
  // int _selectedDay = 14;
  // int _selectedMonth = 10;
  // int _selectedYear = 1993;
  final List<String> _dates =
      List.generate(31, (index) => (index + 1).toString());
  final List<String> _months = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
  ];
  final List<String> _years =
      List.generate(50, (index) => (2023 - index).toString());

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
                Container(
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
                        child: _buildDropdownButton(
                          'Date',
                          _dates,
                          _selectedDate,
                          (String? value) {
                            setState(() {
                              _selectedDate = value;
                            });
                          },
                        ),
                      ),
                      Container(
                        width: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xff1C1C1E),
                        ),
                        child: _buildDropdownButton(
                          'Month',
                          _months,
                          _selectedMonth,
                          (String? value) {
                            setState(() {
                              _selectedMonth = value;
                            });
                          },
                        ),
                      ),
                      Container(
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xff1C1C1E),
                        ),
                        child: _buildDropdownButton(
                          'Year',
                          _years,
                          _selectedYear,
                          (String? value) {
                            setState(() {
                              _selectedYear = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                dateofbirth == true
                    ? const Text(
                        "Please select your date of birth",
                        style: TextStyle(color: Colors.red),
                      )
                    : const Text(""),
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
                    'Minimum character length is 12';
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
                    debugPrint("Completed: $pin" + otp);
                    verifykyc();
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
                      if (formKey.currentState!.validate() ||
                          _selectedDate != null ||
                          _selectedMonth != null ||
                          _selectedYear != null) {
                        // print("dffdh $otp");
                        // if (otp == null) {
                        UserRegister();
                        // } else {
                        //   verifykyc();
                        // }

                        setState(() {
                          dateofbirth = false;
                        });
                      } else {
                        print("dfgdfghdfgd");
                        setState(() {
                          dateofbirth = true;
                        });
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

  var _selectedDate;
  var _selectedMonth;
  var _selectedYear;

  Widget _buildDropdownButton(String label, List<String> items, String? value,
      void Function(String?)? onChanged) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      padding: EdgeInsets.only(left: 10),
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
