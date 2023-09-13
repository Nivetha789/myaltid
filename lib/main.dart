import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myaltid/pages/activeuserhome.dart';
import 'package:myaltid/pages/alternateid.dart';
import 'package:myaltid/pages/kyc.dart';
import 'package:myaltid/pages/selectplan.dart';
import 'package:myaltid/pages/signup.dart';
import 'package:myaltid/widget/sharedpreference.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MYALTID',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'My Alt ID'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    print('main init ');
    // autoPress();
    // firebaseAnalytics();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white, // navigation bar color
      statusBarColor: Colors.transparent,
    ));

    return Scaffold(
      body: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Image.asset(
                        'assets/images/myaltidlogo.png',
                        height: 100,
                        width: 200,
                        alignment: Alignment.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  checkLogin() async {
    print("checklogin : " + await SharedPreference().getLogin().toString());
    if (await SharedPreference().getLogin() == "1") {
      Timer(
          Duration(seconds: 3),
          () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => ActiveUserHome()),
              (Route<dynamic> route) => false));
    } else if (await SharedPreference().getLogin() == "2") {
      //payment incomplete
      Timer(
          Duration(seconds: 3),
          () => Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return SelectPlan();
              }), (Route<dynamic> route) => false));
    }
    // else if (await SharedPreference().getLogin() == "3") {
    //   //kyc incomplete
    //   Timer(
    //       Duration(seconds: 3),
    //       () => Navigator.pushAndRemoveUntil(context,
    //               MaterialPageRoute(builder: (BuildContext context) {
    //             return KycScreen();
    //           }), (Route<dynamic> route) => false));
    // }
    else if (await SharedPreference().getLogin() == "4") {
      //virtual incomplete
      Timer(
          Duration(seconds: 3),
          () => Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return SelectAlternateID();
              }), (Route<dynamic> route) => false));
    } else {
      await SharedPreference().setLogin("0");
      Timer(
          Duration(seconds: 3),
          () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) => Signup())));
    }
  }
}
