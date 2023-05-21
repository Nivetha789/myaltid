import 'package:flutter/material.dart';
import 'package:myaltid/views/calls/callingattend.dart';
import 'package:myaltid/views/reasuable/theme.dart';

class CallingPage extends StatefulWidget {
  const CallingPage({super.key});

  @override
  State<CallingPage> createState() => _CallingPageState();
}

class _CallingPageState extends State<CallingPage>
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
                height: 150,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    "John",
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Work",
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 170,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset("assets/images/message.png"),
                            const SizedBox(
                              width: 40,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Text(
                              "Send Message",
                              style: TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Column(
                          children: const [
                            Icon(
                              Icons.cancel_rounded,
                              color: Colors.red,
                              size: 80,
                            ),
                            Text(
                              "Decline",
                              style: TextStyle(
                                fontSize: 19.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CallingAttendPage()),
                          );
                        },
                        child: Column(
                          children: const [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 80,
                            ),
                            Text(
                              "Accept",
                              style: TextStyle(
                                fontSize: 19.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
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
