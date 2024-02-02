import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myaltid/module/Message/IncomeSmsListModel.dart';
import 'package:myaltid/pages/message/editmessage.dart';
import '../../data/api.dart';
import '../../reasuable/bottomnavbar.dart';

import '../../reasuable/dialogbox.dart';
import '../../reasuable/theme.dart';

import '../../reasuable/background_screen.dart';
import '../../utils/check_internet.dart';
import '../../widget/progressloaded.dart';
import '../../widget/sharedpreference.dart';
import '../signup.dart';

class MessagelistPage extends StatefulWidget {
  const MessagelistPage({super.key});

  @override
  State<MessagelistPage> createState() => _MessagelistPageState();
}

class _MessagelistPageState extends State<MessagelistPage>
    with SingleTickerProviderStateMixin {
  bool isselected = false;
  var forIos = true;
  List<IncomeSmsListData> incomeSmsList = [];

  List<bool> descTextShowFlag = [];

  List<Widget> myTabs = [
    Container(
      alignment: Alignment.center,
      width: 70.0,
      child: Tab(text: 'All'),
    ),
    Container(
      alignment: Alignment.center,
      width: 70,
      child: Tab(text: 'Known\nSenders'),
    ),
    Container(
      alignment: Alignment.center,
      width: 70,
      child: Tab(text: 'Unknown\nSenders'),
    ),
  ];

  late TabController _tabController =
      TabController(vsync: this, length: myTabs.length);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
    check().then((intenet) {
      if (intenet != null && intenet) {
        getMessageList();
      } else {
        Fluttertoast.showToast(
            msg: "Please check your internet connection",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.white,
            backgroundColor: buttoncolor,
            timeInSecForIosWeb: 1);
      }
    });
  }

  updateIncomeSms(List<IncomeSmsListData> incomeSmsList1) {
    setState(() {
      incomeSmsList.clear();
      incomeSmsList.addAll(incomeSmsList1);
    });
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
                      onTap: () async {
                        if (await SharedPreference().getLogin() == "1") {
                          Dialogbox(context);
                        } else {
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
        body: ListView(
          shrinkWrap: false,
          physics: NeverScrollableScrollPhysics(),
          // crossAxisAlignment: CrossAxisAlignment.center,
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
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Row(
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
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.4,
              child: TabBarView(
                controller: _tabController,
                children: [
                  allCallList(),
                  incomingCallList(),
                  outgoingCallList()
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: buttoncolor,
            onPressed: () {
              setState(() {
                // i++;
              });

              Navigator.of(context).push(new MaterialPageRoute(builder: (_)=>new SendMessage("")),)
                  .then((val)=>val?getMessageList():null);
            },
            child: Image.asset("assets/images/Vector (2).png")),
        bottomNavigationBar: const MyStatefulWidget(currentindex: 1),
      ),
    );
  }

  Widget allCallList() {
    return Container(
      margin: EdgeInsets.only(bottom: 50.0),
      child: ListView.builder(
        itemCount: incomeSmsList.length,
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          descTextShowFlag.add(false);
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
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: Center(
                            child: Text(
                              incomeSmsList[index].cSenderName!.isNotEmpty? incomeSmsList[index].cSenderName![0]:"T",
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
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              incomeSmsList[index].cSenderName!,
                              style: TextStyle(color: whitecolor, fontSize: 16),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              incomeSmsList[index].cMessage.toString(),
                              maxLines: descTextShowFlag[index] ? 8 : 1,textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: whitecolor, fontSize: 14),
                            ),
                            InkWell(
                              onTap: (){ setState(() {
                                showHide(index);
                              }); },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  descTextShowFlag[index] ? Padding(
                                    padding: const EdgeInsets.only(top: 4.0,bottom: 4.0),
                                    child: Text("Show Less",style: TextStyle(color: Colors.lightBlueAccent),),
                                  ) :  Padding(
                                    padding: const EdgeInsets.only(top: 4.0,bottom: 4.0),
                                    child: Text("Show More",style: TextStyle(color: Colors.lightBlueAccent)),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          incomeSmsList[index].dtSendTime!,
                          style: TextStyle(color: whitecolor, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(new MaterialPageRoute(builder: (_)=>new SendMessage(incomeSmsList[index].nFromNumber)),)
                          .then((val)=>val?getMessageList():null);
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 40,
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                   Text(
                                    "Reply",
                                    style: TextStyle(
                                        fontFamily: "Helvatica",
                                        color: buttoncolor,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Icon(Icons.send,size: 20,color: buttoncolor,),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
    );
  }

  Widget incomingCallList() {
    return Container(
      margin: EdgeInsets.only(bottom: 50.0),
      child: ListView.builder(
        itemCount: incomeSmsList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          descTextShowFlag.add(false);
          return InkWell(
            onTap: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(builder: (context) => const CallingPage()),
              // );
            },
            child: Container(
              padding: EdgeInsets.all(5),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(),
                        width: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xffFFF4E0),
                          shape: BoxShape.circle,
                        ),
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: Center(
                            child: Text(
                              incomeSmsList[index].cSenderName!.isNotEmpty? incomeSmsList[index].cSenderName![0]:"T",
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
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              incomeSmsList[index].nToNumber.toString(),
                              style: TextStyle(color: whitecolor, fontSize: 16),
                            ),
                            SizedBox(
                              height: 5,
                            ),

                            Text(
                              incomeSmsList[index].cMessage.toString(),
                              maxLines: descTextShowFlag[index] ? 8 : 1,textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: whitecolor, fontSize: 14),
                            ),
                            InkWell(
                              onTap: (){
                                setState(() {
                                descTextShowFlag[index] = !descTextShowFlag[index];
                              });
                                },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  descTextShowFlag[index] ? Padding(
                                    padding: const EdgeInsets.only(top: 4.0,bottom: 4.0),
                                    child: Text("Show Less",style: TextStyle(color: Colors.lightBlueAccent),),
                                  ) :  Padding(
                                    padding: const EdgeInsets.only(top: 4.0,bottom: 4.0),
                                    child: Text("Show More",style: TextStyle(color: Colors.lightBlueAccent)),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            incomeSmsList[index].dtSendTime!,
                            style: TextStyle(color: whitecolor, fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                color: blackcolor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(0xff00F00B),
                                  width: 2,
                                )),
                            alignment: Alignment.center,
                            child: const Text(
                              "Reply",
                              style: TextStyle(
                                  fontFamily: "Helvatica",
                                  color: buttoncolor,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
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
    );
  }

  void showHide(int i) {
    setState(() {
      descTextShowFlag[i] = !descTextShowFlag[i];
    });
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
              child: Icon(Icons.message_outlined, size: 45,color: buttoncolor,),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 15.0),
              child: Text(
                "No Messages Found!!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Helvetica",
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          ])),
      /*ListView.builder(
        itemCount: 0,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          String Time= incomeSmsList[index].dtDateTime!;
          var parts = Time.split(':');

          var time = parts[0].trim();
          var time1 = parts[1].trim();
          var parts11 = time.split('T');
          // print("parts1 "+parts11[0]);
          // print("parts2 "+parts11[1]);
          // print("timeee "+time);
          // print("timeee111 "+time1);
          incomeTime=parts11[1]+":"+time1;

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
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: Center(
                            child: Text(
                              incomeSmsList[index].cName!.isNotEmpty? incomeSmsList[index].cName![0]:"T",
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
                          children: [
                            Text(
                              incomeSmsList[index].nToNumber.toString(),
                              style: TextStyle(color: whitecolor, fontSize: 16),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              incomeSmsList[index].cMessage.toString(),
                              maxLines: descTextShowFlag ? 8 : 1,textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: whitecolor, fontSize: 14),
                            ),
                            InkWell(
                              onTap: (){ setState(() {
                                descTextShowFlag = !descTextShowFlag;
                              }); },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  descTextShowFlag ? Padding(
                                    padding: const EdgeInsets.only(top: 4.0,bottom: 4.0),
                                    child: Text("Show Less",style: TextStyle(color: Colors.lightBlueAccent),),
                                  ) :  Padding(
                                    padding: const EdgeInsets.only(top: 4.0,bottom: 4.0),
                                    child: Text("Show More",style: TextStyle(color: Colors.lightBlueAccent)),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            incomeTime,
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
      ),*/
    );
  }

  //temp
  getMessageList() async {
    ProgressDialog().showLoaderDialog(context);
    // BaseOptions options = new BaseOptions(
    //   baseUrl: ApiProvider().Baseurl,
    //   connectTimeout: 5000,
    //   receiveTimeout: 3000,
    // );

    Dio dio = new Dio();
    // dio.options.connectTimeout = 5000;
    // dio.options.receiveTimeout = 3000;
    var token = await SharedPreference().gettoken();
    var parameters = {
      "n_Skip": 0,
      "n_Limit": 1000
    };
    dio.options.contentType = Headers.formUrlEncodedContentType;
    final response = await dio.post(ApiProvider.incomeSms,
        options:
        Options(contentType: Headers.formUrlEncodedContentType, headers: {
          'Content-Type': "application/json",
          'Authorization': "Bearer " + token,
        }),
        data: parameters);
    print("responseMessageList" + response.toString());

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.toString());
      IncomeSmsListModel incomeSmsListModel = IncomeSmsListModel.fromJson(map);

      if (incomeSmsListModel.status == 1) {
        ProgressDialog().dismissDialog(context);
        updateIncomeSms(incomeSmsListModel.data!);
      } else {
        ProgressDialog().dismissDialog(context);
        Fluttertoast.showToast(
            msg: incomeSmsListModel.message.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.black,
            backgroundColor: buttoncolor,
            timeInSecForIosWeb: 1);
      }
    }
    else if(response.statusCode == 404){
      ProgressDialog().dismissDialog(context);
      var dialog = AlertDialog(
        title: Text('Login',
            style: TextStyle(
                color: buttoncolor,
                fontWeight: FontWeight.w700,
                fontSize: 16)),
        content: Text('Session was expired kindly login again',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 15)),
        actions: [
          ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                backgroundColor: MaterialStateProperty.all(buttoncolor),
              ),
              onPressed: () async {
                Navigator.pop(context);
                await SharedPreference().clearSharep().then((v) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => Signup()));
                });
              },
              child: Text(
                '  OK  ',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ))
        ],
      );
      showDialog(
          context: context, builder: (BuildContext context) => dialog);
    } else {
      ProgressDialog().dismissDialog(context);
      Fluttertoast.showToast(
          msg: "Bad Network Connection try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          backgroundColor: buttoncolor,
          timeInSecForIosWeb: 1);
    }
  }
}
