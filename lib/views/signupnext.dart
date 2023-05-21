import 'package:flutter/material.dart';
import 'package:myaltid/views/otpscreen.dart';
import 'package:myaltid/views/reasuable/background_screen.dart';
import 'package:myaltid/views/reasuable/button.dart';
import 'package:myaltid/views/reasuable/theme.dart';

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
                  style: const TextStyle(
                      color: Color(0xffEBEBF5),
                      fontFamily: "Helvatica",
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please a Enter your FirstName';
                    }
                    if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                      return 'Please a valid Name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    filled: true,
                    hintStyle: const TextStyle(
                        color: Color(0xffEBEBF5),
                        fontFamily: "Helvatica",
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    hintText: "Name",
                    fillColor: const Color(0xff1C1C1E),
                    // errorText: texterror ? "Enter Correct Name" : null,
                    errorStyle: const TextStyle(color: Colors.red),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: phonenumber,
                  style: const TextStyle(
                      color: Color(0xffEBEBF5),
                      fontFamily: "Helvatica",
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    filled: true,
                    hintStyle: const TextStyle(
                        color: Color(0xffEBEBF5),
                        fontFamily: "Helvatica",
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    hintText: "Mobile Number",
                    fillColor: const Color(0xff1C1C1E),
                    errorText:
                        numbererror ? "Enter Correct Mobile Number" : null,
                    errorStyle: const TextStyle(color: Colors.red),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please a Enter your Phone number';
                    }
                    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      return 'Please a valid Number';
                    }
                    return null;
                  },
                  // validator: (value) {
                  //   if (value!.isEmpty ||
                  //       !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                  //           .hasMatch(value)) {
                  //     setState(() {
                  //       numbererror = true;
                  //     });
                  //     //  r'^[0-9]{10}$' pattern plain match number with length 10
                  //     return "Enter Correct Phone Number";
                  //   } else {
                  //     setState(() {
                  //       numbererror = false;
                  //     });
                  //     return null;
                  //   }
                  // },
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
                            builder: (context) =>
                                SendOTPScreen(phonenumber: phonenumber.text)),
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
