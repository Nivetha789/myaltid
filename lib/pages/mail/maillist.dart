import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailslurp/api.dart';
import 'package:myaltid/pages/mail/editmail.dart';

import '../../reasuable/dialogbox.dart';
import '../../reasuable/theme.dart';

import '../../reasuable/background_screen.dart';

import '../../reasuable/bottomnavbar.dart';
import '../../widget/sharedpreference.dart';

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

  var waitForController = WaitForControllerApi();
  var inboxController = InboxControllerApi();

  String userEmail="";

  @override
  void initState() {
    defaultApiClient.addDefaultHeader("x-api-key", "860844a88b9eef42a61eb7aeaa1a90b210cf42927a9ca1e37b47d6860c798204");
    _tabController = TabController(vsync: this, length: myTabs.length);
    setValue();

    super.initState();
  }

  setValue() async{
    var inbox = await inboxController.createInboxWithOptions(CreateInboxDto());
    if(await SharedPreference().getUserEmail()!=null) {
      userEmail = await SharedPreference().getUserEmail();
    }else{
      userEmail="";
    }
    for(int i=0; i<inbox!.id.length; i++) {
      var email = await waitForController.waitForLatestEmail(inboxId: inbox.id, timeout: 30000, unreadOnly: true);
      print("receivedmsg " +email!.subject!+"Test email");
    }
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
            children: [Column(
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
                    userEmail,
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
                      onTap: () async{
                        if (await SharedPreference().getLogin() == "1") {
                        Dialogbox(context);
                        }else {
                          Fluttertoast.showToast(
                              msg: "Complete your stages to use this feature!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              textColor: Colors.white,
                              backgroundColor: buttoncolor,
                              timeInSecForIosWeb: 1);
                        }
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
    return Container(
      margin: EdgeInsets.only(bottom: 50.0),
      child: Container(
          height: MediaQuery.of(context).size.height / 1.5,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Icon(Icons.mail_outlined, size: 50,color: buttoncolor,),
                ),

                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 15.0),
                  child: Text(
                    "Your Inbox tab is empty..",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Helvetica",
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ])),
    );

      /*ListView.builder(
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
    );*/
  }

  Widget incomingCallList() {
    return Container(
      margin: EdgeInsets.only(bottom: 50.0),
      child: Container(
          height: MediaQuery.of(context).size.height / 1.5,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Icon(Icons.mail_outlined, size: 50,color: buttoncolor,),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 15.0),
                  child: Text(
                    "No Drafts Found!!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Helvetica",
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ])),
    );

      /*ListView.builder(
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
    );*/
  }

  Widget trashList() {
    return Container(
        height: MediaQuery.of(context).size.height / 1.5,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Icon(Icons.mail_outlined, size: 50,color: buttoncolor,),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 15.0),
                child: Text(
                  "No Trashes Found!!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Helvetica",
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ])
    );

      /*Column(
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
    );*/
  }
  Widget outgoingCallList() {
    return Container(
      margin: EdgeInsets.only(bottom: 50.0),
      child: Container(
          height: MediaQuery.of(context).size.height / 1.5,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Icon(Icons.mail_outlined, size: 50,color: buttoncolor,),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 15.0),
                  child: Text(
                    "Sent items not Found!!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Helvetica",
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ])),
    );

    /*Column(
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
    );*/
  }
}
