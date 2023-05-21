import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myaltid/views/calls/caldialpad.dart';
import 'package:myaltid/views/calls/calling.dart';
import 'package:myaltid/views/reasuable/background_screen.dart';
import 'package:myaltid/views/reasuable/bottomnavbar.dart';
import 'package:myaltid/views/reasuable/dialogbox.dart';
import 'package:myaltid/views/reasuable/theme.dart';

class CallistPage extends StatefulWidget {
  const CallistPage({super.key});

  @override
  State<CallistPage> createState() => _CallistPageState();
}

class _CallistPageState extends State<CallistPage>
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
    return Backgroundscreen(
      ccontainerchild: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Calls",
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
                      onTap: () {
                        Dialogbox(context);
                      },
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
          bottom: TabBar(
            controller: _tabController,
            tabs: myTabs,
            unselectedLabelColor: whitecolor,
            indicatorColor: goldcolor,
            labelColor: goldcolor,
            isScrollable: true,
          ),
          leading: const Icon(Icons.call, color: Colors.transparent),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.centerRight,
                height: 40,
                width: MediaQuery.of(context).size.width,
                color: const Color(0xff1D2C1D),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CupertinoSwitch(
                      activeColor: buttoncolor,
                      thumbColor: whitecolor,
                      trackColor: goldcolor,
                      value: forIos,
                      onChanged: (value) => setState(() => forIos = value),
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
              SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      allCallList(),
                      incomingCallList(),
                      outgoingCallList()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: buttoncolor,
          onPressed: () {
            setState(() {
              // i++;
            });
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => const CalldialpadScreen()),
            );
          },
          child: const Icon(
            Icons.wifi_calling_sharp,
            color: blackcolor,
            size: 30,
          ),
        ),
        bottomNavigationBar: const MyStatefulWidget(currentindex: 2),
      ),
    );
  }

  Widget allCallList() {
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CallingPage()),
            );
          },
          child: Container(
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
