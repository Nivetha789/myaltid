import 'package:flutter/material.dart';
import 'package:myaltid/views/calls/calllist.dart';
import 'package:myaltid/views/reasuable/theme.dart';

class CallingAttendPage extends StatefulWidget {
  const CallingAttendPage({super.key});

  @override
  State<CallingAttendPage> createState() => _CallingAttendPageState();
}

class _CallingAttendPageState extends State<CallingAttendPage>
    with SingleTickerProviderStateMixin {
  bool isselected = false;
  var forIos = true;
  List<Widget> myTabs = [
    const SizedBox(
      width: 70.0,
      child: Tab(text: 'All'),
    ),
    const SizedBox(
      width: 70,
      child: Tab(text: 'Incoming'),
    ),
    const SizedBox(
      width: 70,
      child: Tab(text: 'Outgoing'),
    ),
  ];

  late TabController _tabController =
      TabController(vsync: this, length: myTabs.length);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
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
                height: 100,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    "Calling",
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "ABC Mobile...",
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
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
                              child: SizedBox(
                                  child: Image.asset(
                                      "assets/images/microphone-alt-slash (1).png")),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Mute",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
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
                              child: SizedBox(
                                  child: Image.asset(
                                      "assets/images/microphone-alt-slash.png")),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Speaker",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              color: buttoncolor,
                              shape: BoxShape.circle,
                            ),
                            child: InkWell(
                              splashColor: buttoncolor, // Splash color
                              onTap: () {},
                              child: SizedBox(
                                  child: Image.asset(
                                      "assets/images/microphone-alt-slash (2).png")),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Keypad",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
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
                              child: SizedBox(
                                  child: Image.asset(
                                      "assets/images/microphone-alt-slash (3).png")),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Add Call",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const CallistPage()),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.cancel_rounded,
                              color: Colors.red,
                              size: 70,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Cancel",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget allCallList() {
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.account_circle,
                    color: whitecolor,
                    size: 40,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: const Text(
                      "989 897 6754",
                      style: TextStyle(color: whitecolor, fontSize: 16),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        "18 Min",
                        style: TextStyle(color: whitecolor, fontSize: 13),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Today",
                        style: TextStyle(color: whitecolor, fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(
                color: buttoncolor,
              )
            ],
          ),
        );
      },
    );
  }

  Widget incomingCallList() {
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.account_circle,
                    color: whitecolor,
                    size: 40,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: const Text(
                      "989 897 6754",
                      style: TextStyle(color: whitecolor, fontSize: 16),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        "18 Min",
                        style: TextStyle(color: whitecolor, fontSize: 13),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Today",
                        style: TextStyle(color: whitecolor, fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(
                color: buttoncolor,
              )
            ],
          ),
        );
      },
    );
  }

  Widget outgoingCallList() {
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.account_circle,
                    color: whitecolor,
                    size: 40,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: const Text(
                      "989 897 6754",
                      style: TextStyle(color: whitecolor, fontSize: 16),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        "18 Min",
                        style: TextStyle(color: whitecolor, fontSize: 13),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Today",
                        style: TextStyle(color: whitecolor, fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(
                color: buttoncolor,
              )
            ],
          ),
        );
      },
    );
  }
}
