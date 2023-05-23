import 'package:flutter/material.dart';

import '../../reasuable/numpad.dart';
import '../../reasuable/theme.dart';
class CalldialpadScreen extends StatefulWidget {
  const CalldialpadScreen({super.key});

  @override
  State<CalldialpadScreen> createState() => _CalldialpadScreenState();
}

class _CalldialpadScreenState extends State<CalldialpadScreen> {
  final TextEditingController _myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff065F0A),
            Color(0xff000000),
          ],
        )),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                height: 70,
                child: Center(
                    child: TextField(
                  controller: _myController,
                  textAlign: TextAlign.center,
                  showCursor: false,

                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: _myController.text.isEmpty
                        ? const SizedBox()
                        : IconButton(
                            onPressed: () {
                              _myController.text = _myController.text
                                  .substring(0, _myController.text.length - 1);
                            },
                            icon: const Icon(
                              Icons.backspace,
                              color: whitecolor,
                            ),
                          ),
                    // filled: true,
                  ),

                  style: const TextStyle(
                      fontSize: 30,
                      fontFamily: "Helvatica",
                      fontWeight: FontWeight.w600,
                      color: whitecolor),

                  // Disable the default soft keybaord
                  keyboardType: TextInputType.none,
                )),
              ),
            ),
            // implement the custom NumPad
            NumPad(
              buttonSize: 75,
              buttonColor: const Color(0xff003F03),
              iconColor: Colors.deepOrange,
              controller: _myController,
              delete: () {
                _myController.text = _myController.text
                    .substring(0, _myController.text.length - 1);
              },
              // do something with the input numbers
              onSubmit: () {
                debugPrint('Your code: ${_myController.text}');
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          content: Text(
                            "You code is ${_myController.text}",
                            style: const TextStyle(fontSize: 30),
                          ),
                        ));
              },
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: buttoncolor,
                shape: BoxShape.circle,

                // borderRadius: BorderRadius.all(Radius.circular(80)),
                // border: Border.all(
                //   color: buttoncolor,
                // ),
              ),
              child: InkWell(
                splashColor: buttoncolor, // Splash color
                onTap: () {},
                child: const SizedBox(
                    child: Icon(
                  Icons.wifi_calling_3_sharp,
                  color: whitecolor,
                  size: 40,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
