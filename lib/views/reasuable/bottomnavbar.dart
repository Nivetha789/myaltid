// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:myaltid/views/calls/calllist.dart';
import 'package:myaltid/views/mail/maillist.dart';
import 'package:myaltid/views/message/messagelist.dart';
import 'package:myaltid/views/reasuable/theme.dart';

class MyStatefulWidget extends StatefulWidget {
  final currentindex;
  const MyStatefulWidget({Key? key, this.currentindex}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with SingleTickerProviderStateMixin {
  late int currentIndex = 4;

  _updateIndex(index) {
    setState(() {
      currentIndex = index;
    });
    if (currentIndex == 2) {
      print("DSsdfsdfsdf");
      const CallistPage();
    }
  }

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentindex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        // color: blackcolor,
        boxShadow: [
          BoxShadow(
            color: buttoncolor,
            blurRadius: 1.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                currentIndex = 0;
              });
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const MaillistPage()),
              );
            },
            child: Container(
              color: currentIndex == 0 ? tabbgcolor : blackcolor,
              height: 70,
              width: MediaQuery.of(context).size.width * 0.33,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Image.asset("assets/images/tmail.png"),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Email",
                    style: TextStyle(
                        color: Color(0xff55B780),
                        fontFamily: "Helvatica",
                        fontSize: 10.0,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                currentIndex = 1;
              });
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const MessagelistPage()),
              );
            },
            child: Container(
              color: currentIndex == 1 ? tabbgcolor : blackcolor,
              height: 70,
              width: MediaQuery.of(context).size.width * 0.33,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Image.asset("assets/images/message.png"),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Text Message",
                    style: TextStyle(
                        color: Color(0xff55B780),
                        fontFamily: "Helvatica",
                        fontSize: 10.0,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                currentIndex = 2;
                _updateIndex(currentIndex);
              });
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CallistPage()),
              );
            },
            child: Container(
              color: currentIndex == 2 ? tabbgcolor : blackcolor,
              height: 70,
              width: MediaQuery.of(context).size.width * 0.33,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Image.asset("assets/images/tcall.png"),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Calls",
                    style: TextStyle(
                        color: Color(0xff55B780),
                        fontFamily: "Helvatica",
                        fontSize: 10.0,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
