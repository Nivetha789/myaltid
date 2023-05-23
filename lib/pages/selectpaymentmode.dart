import 'package:flutter/material.dart';
import 'package:myaltid/pages/paymentsuccessfull.dart';
import 'package:myaltid/reasuable/theme.dart';

import '../reasuable/background_screen.dart';

class PaymentmodeSelection extends StatefulWidget {
  const PaymentmodeSelection({super.key});

  @override
  State<PaymentmodeSelection> createState() => _PaymentmodeSelectionState();
}

class _PaymentmodeSelectionState extends State<PaymentmodeSelection> {
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
                    "Select Payment Mode",
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
              const Card(
                elevation: 10,
                color: blackcolor,
                shadowColor: buttoncolor,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "pay to MyAltID",
                        style: TextStyle(
                            color: whitecolor,
                            fontFamily: "Helvatica",
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            // fontStyle: FontStyle.italic,
                            fontSize: 14),
                      ),
                      Text(
                        "Order # 001",
                        style: TextStyle(
                            color: whitecolor,
                            fontFamily: "Helvatica",
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            // fontStyle: FontStyle.italic,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                elevation: 10,
                color: blackcolor,
                shadowColor: buttoncolor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 270,
                      width: MediaQuery.of(context).size.width - 40,
                      child: Column(
                        children: [
                          addRadioButton(0, 'UPI'),
                          addRadioButton(1, 'Credit / Debit Card'),
                          addRadioButton(2, 'Net Banking'),
                          addRadioButton(3, 'Wallet'),
                          addRadioButton(4, 'Crypto'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 160,
              ),
              InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const PaymentSuccessfull()),
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
                    child:const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        Text(
                          "Total Payable (inc GST)",
                          style: TextStyle(
                              color: blackcolor,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Rs.45",
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
    );
  }
}
