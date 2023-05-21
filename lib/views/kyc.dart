import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myaltid/views/congratulation.dart';
import 'package:myaltid/views/reasuable/background_screen.dart';
import 'package:myaltid/views/reasuable/theme.dart';
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
    print("PAIVTHRA");
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
      print("PAVITHRA ${response.data}");

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
          /// need to set following properties for best effect of awesome_snackbar_content
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'On Hey!',
            message: 'OTP has been sended registered mobile number!',

            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
            contentType: ContentType.success,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        print(response.data["data"]["requestId"]);
        setState(() {
          requestid = response.data["data"]["requestId"];
          print("requestid $requestid");
        });
      } else {
        final snackBar = SnackBar(
          /// need to set following properties for best effect of awesome_snackbar_content
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'On Snap!',
            message: 'Please enter valid aadhar number!',

            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
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

  var requestid;

  OTPcheck() async {
    print("pavithra ${requestid}");

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
      print("pavithra ${response.data}");

      if (response.statusCode == 401) {
      } else if (response.statusCode == 200) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const Congratulations()),
        );
      } else {
        final snackBar = SnackBar(
          /// need to set following properties for best effect of awesome_snackbar_content
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'On Snap!',
            message: 'Please enter valid otp!',

            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
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
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.always
            
            
            ,
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
                  "Enter PAN Num",
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
                  inputFormatters: [UpperCaseTextFormatter()],
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
                    hintText: "PAN Num",
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
                  "Enter Aadhar Num",
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
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(12),
                  ],
                  validator: (value) {
                    return value.toString().length == 12
                        ? aadharOTPsend()
                        : 'Minimum character length is 12';
                  },
                  onChanged: (value) {
                    value.toString().length == 12
                        ? aadharOTPsend()
                        : 'Minimum character length is 12';
                  },
                  keyboardType: TextInputType.number,
                  maxLength: 12,
                  decoration: const InputDecoration(
                    hintText: "Aadhar Num",
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
                    print("Completed: " + pin + otp);
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
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
