import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myaltid/views/reasuable/background_screen.dart';
import 'package:myaltid/views/reasuable/theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
              print(value);
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

  bool isselected = false;
  var forIos = true;
  @override
  Widget build(BuildContext context) {
    return Backgroundscreen(
      ccontainerchild: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.9),
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
                  const Text(
                    "Welcome Jhon Alex",
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
                    alignment: Alignment.bottomRight,
                    child: ClipOval(
                      child: Material(
                        color: blackcolor, // Button color
                        child: InkWell(
                          splashColor: Colors.red, // Splash color
                          onTap: () {},
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
              Container(
                alignment: Alignment.centerRight,
                height: 40,
                width: MediaQuery.of(context).size.width,
                color: const Color(0xff1D2C1D),
                child: isselected == false
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            isselected = true;
                          });
                        },
                        child: const Text(
                          'Set DND Preferences',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: goldcolor),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CupertinoSwitch(
                            activeColor: buttoncolor,
                            thumbColor: whitecolor,
                            trackColor: goldcolor,
                            value: forIos,
                            onChanged: (value) =>
                                setState(() => forIos = value),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text(
                            "DND Enabled",
                            style: TextStyle(
                                color: whitecolor,
                                fontFamily: "Helvatica",
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
