import 'package:flutter/material.dart';
import 'package:myaltid/views/reasuable/background_screen.dart';
import 'package:myaltid/views/reasuable/button.dart';
import 'package:myaltid/views/reasuable/theme.dart';
import 'package:myaltid/views/selectpaymentmode.dart';

class PlanSelection extends StatefulWidget {
  const PlanSelection({super.key});

  @override
  State<PlanSelection> createState() => _PlanSelectionState();
}

class _PlanSelectionState extends State<PlanSelection> {
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
    "Annual",
    "6 Months",
    "3 Months",
    "Monthly",
  ];

  late String select = "0";

  Row addRadioButton(int btnValue, String name, number, talktime) {
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 200,
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        color: whitecolor,
                        fontFamily: "Helvatica",
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        // fontStyle: FontStyle.italic,
                        fontSize: 14),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    number,
                    style: const TextStyle(
                        color: whitecolor,
                        fontFamily: "Helvatica",
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        // fontStyle: FontStyle.italic,
                        fontSize: 12),
                  ),
                ],
              ),
            ),
            Text(
              talktime,
              style: const TextStyle(
                  color: whitecolor,
                  fontFamily: "Helvatica",
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  // fontStyle: FontStyle.italic,
                  fontSize: 14),
            ),
          ],
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
                    "My Alternate ID",
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
              Card(
                elevation: 10,
                color: blackcolor,
                shadowColor: buttoncolor,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Diamond Plan",
                        style: TextStyle(
                            color: goldcolor,
                            fontFamily: "Helvatica",
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            // fontStyle: FontStyle.italic,
                            fontSize: 14),
                      ),
                      Text(
                        "Change Plan",
                        style: TextStyle(
                            color: buttoncolor,
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
              SizedBox(
                height: 400,
                width: MediaQuery.of(context).size.width - 40,
                child: Column(
                  children: [
                    SizedBox(
                      height: 80,
                      child: Card(
                        elevation: 10,
                        color: blackcolor,
                        shadowColor: goldcolor,
                        child: addRadioButton(
                            0, 'Annual', 'pay for full year 1', '250 / m'),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 80,
                      child: Card(
                        elevation: 10,
                        color: blackcolor,
                        shadowColor: goldcolor,
                        child: addRadioButton(
                            1, '6 Months', 'pay for 6 Months', "350 / m"),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 80,
                      child: Card(
                        elevation: 10,
                        color: blackcolor,
                        shadowColor: goldcolor,
                        child: addRadioButton(
                            2, '3 Months', "pay for 3 Months", "550 / m"),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 80,
                      child: Card(
                        elevation: 10,
                        color: blackcolor,
                        shadowColor: goldcolor,
                        child: addRadioButton(
                            3, 'Monthly', "pay for Monthly", "700 / m"),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const PaymentmodeSelection()),
                  );
                },
                child: const ButtonScreen(
                  buttontext: "Make Payment",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
