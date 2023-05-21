import 'package:flutter/material.dart';
import 'package:myaltid/views/reasuable/background_screen.dart';
import 'package:myaltid/views/reasuable/theme.dart';

class SendMessage extends StatefulWidget {
  const SendMessage({super.key});

  @override
  State<SendMessage> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  @override
  Widget build(BuildContext context) {
    return Backgroundscreen(
      ccontainerchild: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Container(
                  color: blackcolor,
                  // height: 200,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Messages",
                              style: TextStyle(
                                  fontFamily: "Helvatica",
                                  color: whitecolor,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  // fontStyle: FontStyle.italic,
                                  fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                    fontFamily: "Helvatica",
                                    color: buttoncolor,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                    // fontStyle: FontStyle.italic,
                                    fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: whitecolor,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "To:",
                              style: TextStyle(
                                  fontFamily: "Helvatica",
                                  color: whitecolor,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  // fontStyle: FontStyle.italic,
                                  fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                            Image.asset("assets/images/Vector (3).png")
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: whitecolor,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.7,
                  // height: 200,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Write your message here',
                          // filled: true,
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                      const SizedBox(
                        height: 200,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                            onTap: () {
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //       builder: (context) =>
                              //           const Congratulations()),
                              // );
                            },
                            child: Container(
                              width: 110,
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
                                    "SEND",
                                    style: TextStyle(
                                        color: blackcolor,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
