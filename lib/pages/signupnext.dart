import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myaltid/pages/otpscreen.dart';
import 'package:myaltid/reasuable/background_screen.dart';
import 'package:myaltid/reasuable/button.dart';
import 'package:myaltid/reasuable/theme.dart';
import 'package:myaltid/widget/mobilenumberformator.dart';
import 'package:myaltid/widget/textfield.dart';

class SignupApp extends StatefulWidget {
  const SignupApp({super.key});

  @override
  State<SignupApp> createState() => _SignupAppState();
}

class _SignupAppState extends State<SignupApp> {
  TextEditingController phonenumber = TextEditingController();

  TextEditingController namecontroller = TextEditingController();
  bool texterror = false, numbererror = false;
  final formKey = GlobalKey<FormState>();
  late String oldvalue;
  @override
  Widget build(BuildContext context) {
    return Backgroundscreen(
      ccontainerchild: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 120,
                ),
                Image.asset("assets/images/myaltidlogo.png"),
                const Text(
                  "Privacy Matters",
                  style: TextStyle(
                      color: Color(0xff55B780),
                      fontFamily: "Helvatica",
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Sign Up",
                  style: TextStyle(
                      fontFamily: "Helvatica",
                      color: whitecolor,
                      fontWeight: FontWeight.w700,
                      fontSize: 28),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: namecontroller,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r"[a-zA-Z]+|\s"),
                    ),
                    // singleNameInputFormatter()
                    // SingleSpaceFormatter()
                  ],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: const TextStyle(
                      color: Color(0xffEBEBF5),
                      fontFamily: "Helvatica",
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please a Enter your Name';
                    }
                    // final words = value.split(' ');
                    // if (words.length < 2) {
                    //   return 'Invalid spacing pattern';
                    // }

                    if (!RegExp(r'^[a-zA-Z ]').hasMatch(value)) {
                      return 'Please a valid Name';
                    }
                    return null;
                  },
                  // onChanged: (value) {
                  //   final List l = value.split(' ');
                  //   if (l.length == 2) {
                  //     setState(() {
                  //       oldvalue = value;
                  //     });
                  //   }
                  //   if (l.length == 3) {
                  //     setState(() {
                  //       namecontroller.text = oldvalue;
                  //     });
                  //   }
                  // },
                  decoration: buildInputDecoration("Name"),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: phonenumber,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(9|8|7|6)[0-9]*$')),
                  ],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: const TextStyle(
                      color: Color(0xffEBEBF5),
                      fontFamily: "Helvatica",
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  decoration: buildInputDecoration("Mobile Number"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please a Enter your Phone number';
                    }
                    if (!RegExp(r'^[0-9]{10}$').hasMatch(value) ||
                        !RegExp(r'^(9|8|7|6)').hasMatch(value)) {
                      return 'Phone number should start with 9, 8, 7, or 6';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Please share your full name and your valid mobile number to know you",
                  style: TextStyle(
                      fontFamily: "Helvatica",
                      color: whitecolor,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      // fontStyle: FontStyle.italic,
                      fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 70,
                ),
                InkWell(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SendOTPScreen(
                              phonenumber: phonenumber.text,
                              name: namecontroller.text),
                        ),
                      );
                      //check if form data are valid,
                      // your process task ahed if all data are valid
                    }
                  },
                  child: const ButtonScreen(
                    buttontext: "Send OTP?",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
