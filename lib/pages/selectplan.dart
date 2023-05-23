import 'package:flutter/material.dart';
import 'package:myaltid/pages/planselection.dart';
import 'package:myaltid/reasuable/background_screen.dart';
import 'package:myaltid/reasuable/theme.dart';

class SelectPlan extends StatefulWidget {
  const SelectPlan({super.key});

  @override
  State<SelectPlan> createState() => _SelectPlanState();
}

class _SelectPlanState extends State<SelectPlan> {
  var items = [
    {
      "name": "Diamond Plan",
      "number": "1 Virtual number",
      "talktime": "300 mins talk time",
      "datapermonth": "30 GB data per month"
    },
    {
      "name": "Gold Plan",
      "number": "1 Virtual number",
      "talktime": "300 mins talk time",
      "datapermonth": "30 GB data per month"
    },
    {
      "name": "Silver Plan",
      "number": "1 Virtual number",
      "talktime": "300 mins talk time",
      "datapermonth": "30 GB data per month"
    },
  ];
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
                    "VNM & VEID",
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
                alignment: Alignment.topLeft,
                child: const Text(
                  "Select your Plan",
                  style: TextStyle(
                      fontFamily: "Helvatica",
                      color: whitecolor,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      // fontStyle: FontStyle.italic,
                      fontSize: 18),
                  textAlign: TextAlign.start,
                ),
              ),
              ListView.builder(
                itemCount: items.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const PlanSelection()),
                      );
                    },
                    child: Column(
                      children: [
                        Card(
                          elevation: 10,
                          color: blackcolor,
                          shadowColor: buttoncolor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      items[index]["name"]!,
                                      style: const TextStyle(
                                          color: goldcolor,
                                          fontFamily: "Helvatica",
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          // fontStyle: FontStyle.italic,
                                          fontSize: 14),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset("assets/images/ccall.png"),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        Text(
                                          items[index]["number"]!,
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
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset("assets/images/call.png"),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        Text(
                                          items[index]["talktime"]!,
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
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset("assets/images/wifi.png"),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        Text(
                                          items[index]["datapermonth"]!,
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
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                elevation: 10,
                                color: cardbackgorundcolor,
                                shadowColor: cardbackgorundcolor,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 130,
                                  width: 100,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      const Text(
                                        "Starts @500 RS",
                                        style: TextStyle(
                                            color: whitecolor,
                                            fontFamily: "Helvatica",
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                            // fontStyle: FontStyle.italic,
                                            fontSize: 12),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: 80,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: buttoncolor,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "Subscribe",
                                          style: TextStyle(
                                              color: blackcolor,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
