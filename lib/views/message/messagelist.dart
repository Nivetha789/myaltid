import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myaltid/views/message/editmessage.dart';
import 'package:myaltid/views/reasuable/background_screen.dart';
import 'package:myaltid/views/reasuable/bottomnavbar.dart';
import 'package:myaltid/views/reasuable/dialogbox.dart';
import 'package:myaltid/views/reasuable/theme.dart';

class MessagelistPage extends StatefulWidget {
  const MessagelistPage({super.key});

  @override
  State<MessagelistPage> createState() => _MessagelistPageState();
}

class _MessagelistPageState extends State<MessagelistPage>
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
      child: Tab(text: 'known Senders'),
    ),
    const SizedBox(
      width: 70,
      child: Tab(text: 'Unknown Senders'),
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
                "Messages",
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
          leading: const SizedBox(
            height: 0,
          ),
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
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color(0xffFFF4E0),
                    ),
                    child: const Center(child: Text('Unread')),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 80,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color(0xffFFF4E0),
                    ),
                    child: const Center(child: Text('Read')),
                  ),
                ],
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
                MaterialPageRoute(builder: (context) => const SendMessage()),
              );
            },
            child: Image.asset("assets/images/Vector (2).png")),
        bottomNavigationBar: const MyStatefulWidget(currentindex: 1),
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
            // Navigator.of(context).push(
            //   MaterialPageRoute(builder: (context) => const CallingPage()),
            // );
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xffFFF4E0),
                        shape: BoxShape.circle,
                      ),
                      child: const SizedBox(
                        height: 40,
                        width: 40,
                        child: Center(
                          child: Text(
                            "A",
                            style: TextStyle(
                                color: blackcolor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Airtel",
                            style: TextStyle(color: whitecolor, fontSize: 16),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Airtel Packing your bags for inter....",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: whitecolor, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          "32 Min",
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
        return InkWell(
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(builder: (context) => const CallingPage()),
            // );
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xffFFF4E0),
                        shape: BoxShape.circle,
                      ),
                      child: const SizedBox(
                        height: 40,
                        width: 40,
                        child: Center(
                          child: Text(
                            "A",
                            style: TextStyle(
                                color: blackcolor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Airtel",
                            style: TextStyle(color: whitecolor, fontSize: 16),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Airtel Packing your bags for inter....",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: whitecolor, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          "32 Min",
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

  Widget outgoingCallList() {
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(builder: (context) => const CallingPage()),
            // );
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xffFFF4E0),
                        shape: BoxShape.circle,
                      ),
                      child: const SizedBox(
                        height: 40,
                        width: 40,
                        child: Center(
                          child: Text(
                            "A",
                            style: TextStyle(
                                color: blackcolor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Airtel",
                            style: TextStyle(color: whitecolor, fontSize: 16),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Airtel Packing your bags for inter....",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: whitecolor, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          "32 Min",
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
}
