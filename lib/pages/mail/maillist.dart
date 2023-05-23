import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myaltid/pages/mail/editmail.dart';

import '../../reasuable/dialogbox.dart';
import '../../reasuable/theme.dart';

import '../../reasuable/background_screen.dart';

import '../../reasuable/bottomnavbar.dart';

class MaillistPage extends StatefulWidget {
  const MaillistPage({super.key});

  @override
  State<MaillistPage> createState() => _MaillistPageState();
}

class _MaillistPageState extends State<MaillistPage>
    with SingleTickerProviderStateMixin {
  bool isselected = false;
  var forIos = true;
  List<Widget> myTabs = [
    const SizedBox(
      width: 60.0,
      child: Tab(text: 'Inbox'),
    ),
    const SizedBox(
      width: 60,
      child: Tab(text: 'Drafts'),
    ),
    const SizedBox(
      width: 60,
      child: Tab(text: 'Sent'),
    ),
    const SizedBox(
      width: 60,
      child: Tab(text: 'Trash'),
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
            const  Column(
                children:  [
                  Text(
                    "MyAltId Emails",
                    style: TextStyle(
                        fontFamily: "Helvatica",
                        color: whitecolor,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        // fontStyle: FontStyle.italic,
                        fontSize: 20),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    "jhon.doe@myaltid.com",
                    style: TextStyle(
                        fontFamily: "Helvatica",
                        color: whitecolor,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.normal,
                        // fontStyle: FontStyle.italic,
                        fontSize: 14),
                    textAlign: TextAlign.start,
                  ),
                ],
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
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    color: const Color(0xff1C1C1E),
                    borderRadius: BorderRadius.circular(5)),
                child: const Center(
                  child: TextField(
                    decoration: InputDecoration(
                        // prefixIcon: const Icon(
                        //   Icons.search,
                        //   color: whitecolor,
                        // ),
                        // suffixIcon: IconButton(
                        //   icon: const Icon(Icons.clear),
                        //   onPressed: () {
                        //     /* Clear the search field */
                        //   },
                        // ),
                        hintText: 'Search Email...',
                        hintStyle: TextStyle(color: whitecolor),
                        border: InputBorder.none),
                    style: TextStyle(color: whitecolor),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      allCallList(),
                      incomingCallList(),
                      outgoingCallList(),
                      trashList()
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
                MaterialPageRoute(builder: (context) => const SendMail()),
              );
            },
            child: Image.asset("assets/images/Vector (2).png")),
        bottomNavigationBar: const MyStatefulWidget(currentindex: 0),
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
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "32 Min",
                          style: TextStyle(color: whitecolor, fontSize: 13),
                        ),
                        Icon(Icons.delete, color: Color(0xffFDFF9E)),
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
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 80,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(0xffFFF4E0),
              ),
              child: const Center(child: Text('To')),
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
              child: const Center(child: Text('Attachment')),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 50,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(0xffFFF4E0),
              ),
              child: const Center(child: Text('Date')),
            ),
          ],
        ),
        ListView.builder(
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
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Airtel",
                                style:
                                    TextStyle(color: whitecolor, fontSize: 16),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Airtel Packing your bags for inter....",
                                overflow: TextOverflow.ellipsis,
                                style:
                                    TextStyle(color: whitecolor, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
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
        ),
      ],
    );
  }

  Widget trashList() {
    return Column(
      children: [
        const Text(
          'This bin will be cleared every 45 days. ',
          style: TextStyle(
              color: Color(0xffFDFF9E),
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
        ListView.builder(
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
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Airtel",
                                style:
                                    TextStyle(color: whitecolor, fontSize: 16),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Airtel Packing your bags for inter....",
                                overflow: TextOverflow.ellipsis,
                                style:
                                    TextStyle(color: whitecolor, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
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
        ),
      ],
    );
  }
}
