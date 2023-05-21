import 'package:flutter/material.dart';
import 'package:myaltid/views/alternateid.dart';
import 'package:myaltid/views/reasuable/background_screen.dart';
import 'package:myaltid/views/reasuable/theme.dart';

class PaymentSuccessfull extends StatefulWidget {
  const PaymentSuccessfull({super.key});
 
  @override
  State<PaymentSuccessfull> createState() => _PaymentSuccessfullState();
}

class _PaymentSuccessfullState extends State<PaymentSuccessfull> {
  var items = [
    {"name": "Annual ", "number": "pay for full year ", "talktime": "250 / m"},
    {
      "name": "6 Months",
      "number": "pay for 6 Months",
      "talktime": "350 / m",
    },
    { 
      "name": "3 Months",
      "number": "pay for 3 Months",
      "talktime": "550 / m",
    },
    {
      "name": "Monthly",
      "number": "pay for Monthly",
      "talktime": "700 / m",
    },
  ];
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

  @override
  Widget build(BuildContext context) {
    return Backgroundscreen(
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
                  const Text(
                    "Payment",
                    style: TextStyle(
                        fontFamily: "Helvatica",
                        color: whitecolor,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        // fontStyle: FontStyle.italic,
                        fontSize: 20),
                    textAlign: TextAlign.center,
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
              const SizedBox(
                height: 130,
              ),
              Container(
                width: 200,
                decoration: const BoxDecoration(
                  color: buttoncolor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: buttoncolor,
                      blurRadius: 35.0,
                    ),
                  ],

                  // borderRadius: BorderRadius.all(Radius.circular(80)),
                  // border: Border.all(
                  //   color: buttoncolor,
                  // ),
                ),
                child: InkWell(
                  splashColor: buttoncolor, // Splash color
                  onTap: () {},
                  child: SizedBox(
                      width: 126,
                      height: 126,
                      child: Image.asset("assets/images/valid1.png")),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Payment successfully completed",
                style: TextStyle(
                    fontFamily: "Helvatica",
                    color: whitecolor,
                    fontWeight: FontWeight.w600,
                    // fontStyle: FontStyle.italic,
                    fontSize: 24),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 160,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const SelectAlternateID()),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
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
                        "Complete KYC to Activate MYALTID",
                        style: TextStyle(
                            color: blackcolor,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
