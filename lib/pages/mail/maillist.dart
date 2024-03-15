import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mailslurp/api.dart';
import 'package:myaltid/pages/mail/editmail.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import '../../data/api.dart';
import '../../module/Message/SendEmailModule/SendEmailListModel.dart';
import '../../module/mailModule/GetInboxListModel.dart';
import '../../reasuable/background_screen.dart';
import '../../reasuable/bottomnavbar.dart';
import '../../reasuable/dialogbox.dart';
import '../../reasuable/theme.dart';
import '../../utils/check_internet.dart';
import '../../widget/progressloaded.dart';
import '../../widget/sharedpreference.dart';
import '../activeuserhome.dart';
import '../signup.dart';

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
  int selectedTabPosition = 0;

  var waitForController = WaitForControllerApi();
  var inboxController = InboxControllerApi();

  String userEmail="";
  String messageContent="";

  List<GetInboxContent> inboxContentList = [];
  List<SendEmailListContent> sentContentList = [];

  int offset = 0;
  int limit = 10;
  int total = 0;
  bool loadmore = false;
  int totalPage = 0;

  bool checkInbox = false;
  bool inboxNoData = false;
  String noDataText = 'Your Inbox tab is empty..';

  List<bool> descTextShowFlag = [];

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: myTabs.length);
    setValue();

    _tabController.addListener(() {
      setState(() {
        selectedTabPosition = _tabController.index;
        print("tabbbbb " + selectedTabPosition.toString());
        switch (selectedTabPosition) {
          case 0:
            check().then((intenet) {
              if (intenet != null && intenet) {
                getMailInboxList();
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
            break;
          case 1:
          // setState(() {
          //   check().then((intenet) {
          //     if (intenet != null && intenet) {
          //       getCallsList("incoming");
          //     } else {
          //       Fluttertoast.showToast(
          //           msg: "Please check your internet connection",
          //           toastLength: Toast.LENGTH_SHORT,
          //           gravity: ToastGravity.BOTTOM,
          //           textColor: Colors.white,
          //           backgroundColor: buttoncolor,
          //           timeInSecForIosWeb: 1);
          //     }
          //   });
          // });

            break;
          case 2:
            setState(() {
              check().then((intenet) {
                if (intenet != null && intenet) {
                  getMailSentList();
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
            });
            break;
        }
      });
    });

    check().then((intenet) {
      if (intenet != null && intenet) {
        getMailInboxList();
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
    super.initState();
  }

  setValue() async{
    if(await SharedPreference().getUserEmail()!=null) {
      userEmail = await SharedPreference().getUserEmail();
    }else{
      userEmail="";
    }
  }

  //inbox
  updateMailList(List<GetInboxContent> incomeSmsList1) {
    setState(() {
      inboxContentList.clear();
      inboxContentList.addAll(incomeSmsList1);
    });
  }

  //sent
  updateSentMailList(List<SendEmailListContent> sentContent1) {
    setState(() {
      sentContentList.clear();
      sentContentList.addAll(sentContent1);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    print("on will pop");
    if (_tabController.index == 0) {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => const ActiveUserHome()),
      );
    }
    Future.delayed(Duration(milliseconds: 200), () {
      print("set index");
      _tabController.index = 0;
    });
    print("return");
    return _tabController.index == 0;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:_onWillPop,
      child: Backgroundscreen(
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
                Container(
                  child: callWidgets(selectedTabPosition),
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
                  MaterialPageRoute(builder: (context) => SendMail("","")),
                );
              },
              child: Image.asset("assets/images/Vector (2).png")),
          bottomNavigationBar: const MyStatefulWidget(currentindex: 0),
        ),
      ),
    );
  }

  Widget callWidgets(int position) {
    if (position == 0) {
      return Column(
        children: [
          Visibility(
            visible: checkInbox,
            child: Container(
              child: ListView.builder(
                itemCount: inboxContentList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  descTextShowFlag.add(false);
                  var cTime = inboxContentList[index].createdAt!.split("T");
                  var currentDate = cTime[0].trim();
                  var currentDate1 = cTime[1].trim();
                  print("cdate "+currentDate);
                  print("cdate1 "+currentDate1);

                  final format = new DateFormat('yyyy-MM-ddTHH:mm:ssZ','en-US').parse(inboxContentList[index].createdAt.toString());
                  DateFormat format1 = new DateFormat("HH:mm:ss");

                  DateTime dt1 = DateTime.parse(inboxContentList[index].createdAt.toString());

                  var str= DateFormat("EEE, d MMM yyyy HH:mm:ss").format(dt1);
                  print("str "+str.toString());

                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SendMail(inboxContentList[index].from,inboxContentList[index].textExcerpt)),
                      );
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
                              Expanded(
                                flex:1,
                                child: Container(
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
                                        inboxContentList[index].from!.isNotEmpty? inboxContentList[index].from![0]:"",
                                        style: TextStyle(
                                            color: blackcolor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex:5,
                                child: Container(
                                  margin: EdgeInsets.only(left: 8.0,right: 5.0),
                                  child: SizedBox(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          inboxContentList[index].from!.isNotEmpty? inboxContentList[index].from!:"",
                                          style: TextStyle(color: whitecolor, fontSize: 15,fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 4,bottom: 5),
                                          child: Text(
                                            inboxContentList[index].subject!.isNotEmpty? inboxContentList[index].subject!:"",
                                            style: TextStyle(color: buttoncolor, fontSize: 15,fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        HtmlWidget(
                                          inboxContentList[index]
                                              .textExcerpt !=
                                              null
                                              ?  inboxContentList[index]
                                              .textExcerpt !
                                              : "",
                                          textStyle: TextStyle(
                                            fontFamily: "Poppins",
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // Expanded(
                              //   flex: 1,
                              //   child: Text(
                              //     inboxContentList[index].createdAt!.isNotEmpty? inboxContentList[index].createdAt! :"",
                              //     style: TextStyle(color: whitecolor, fontSize: 13),
                              //   ),
                              // ),
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
            ),
          ),
          Visibility(
            visible: inboxNoData,
            child: Container(
              height: MediaQuery.of(context).size.height / 1.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset('assets/images/calls_empty.png',
                        width: 80, height: 80),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 15.0),
                    child: Text(
                      noDataText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Helvetica",
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }else if(position==1){
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
    }else if(position==2){
      return Column(
        children: [
          Visibility(
            visible: checkInbox,
            child: Container(
              child: ListView.builder(
                itemCount: sentContentList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  descTextShowFlag.add(false);
                  return Container(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex:1,
                              child: Container(
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
                                      sentContentList[index].from!.isNotEmpty? sentContentList[index].from![0]:"",
                                      style: TextStyle(
                                          color: blackcolor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex:5,
                              child: Container(
                                margin: EdgeInsets.only(left: 8.0,right: 5.0),
                                child: SizedBox(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        sentContentList[index].from!.isNotEmpty? sentContentList[index].from!:"",
                                        style: TextStyle(color: whitecolor, fontSize: 15,fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 4,bottom: 5),
                                        child: Text(
                                          sentContentList[index].subject!.isNotEmpty? sentContentList[index].subject!:"",
                                          style: TextStyle(color: buttoncolor, fontSize: 15,fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      HtmlWidget(
                                        messageContent.isNotEmpty
                                            ? messageContent
                                            : "",
                                        textStyle: TextStyle(
                                          fontFamily: "Poppins",
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Expanded(
                            //   flex: 1,
                            //   child: Text(
                            //     inboxContentList[index].createdAt!.isNotEmpty? inboxContentList[index].createdAt! :"",
                            //     style: TextStyle(color: whitecolor, fontSize: 13),
                            //   ),
                            // ),
                          ],
                        ),
                        const Divider(
                          color: buttoncolor,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Visibility(
            visible: inboxNoData,
            child: Container(
              height: MediaQuery.of(context).size.height / 1.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset('assets/images/calls_empty.png',
                        width: 80, height: 80),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 15.0),
                    child: Text(
                      noDataText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Helvetica",
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }else{
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
    }
  }

  void showHide(int i) {
    setState(() {
      descTextShowFlag[i] = !descTextShowFlag[i];
    });
  }

  //inbox list
  getMailInboxList() async {
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
    var sender_id = await SharedPreference().getSenderId();
    if(sender_id!=null){
      sender_id=sender_id;
    }else{
      sender_id="";
    }
    var parameters = {
      "inboxId":sender_id,
      "page":offset,
      "size":limit,
      "sort":"",
      "unreadOnly":"false",
      "searchFilter":"",
      "since":"",
      "before":""
    };
    final response = await dio.get(ApiProvider.getInboxMail,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
            "x-api-key":"860844a88b9eef42a61eb7aeaa1a90b210cf42927a9ca1e37b47d6860c798204"},
        ),
        data: parameters);
    print("responseMailList" + response.toString());

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.toString());
      GetInboxModel getInboxModel = GetInboxModel.fromJson(map);

        ProgressDialog().dismissDialog(context);

      setState(() {
        checkInbox = true;
        inboxNoData = false;
        offset = getInboxModel.pageable!.offset!;
        limit = offset+10;
        total = getInboxModel.totalPages!;
        // print("offsettttt t " + offset.toString());
        // print("limittttttt t " + limit.toString());
      });
        updateMailList(getInboxModel.content!);
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
      setState(() {
        checkInbox = false;
        inboxNoData = true;
        noDataText = "Your Inbox tab is empty..";
      });
    }
  }

  //sent list
  getMailSentList() async {
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
    var sender_id = await SharedPreference().getSenderId();
    if(sender_id!=null){
      sender_id=sender_id;
    }else{
      sender_id="";
    }
    var parameters = {
      "inboxId":sender_id,
      "page":offset,
      "size":limit,
      "sort":"",
      "unreadOnly":"false",
      "searchFilter":"",
      "since":"",
      "before":""
    };
    final response = await dio.get(ApiProvider.getSentMail,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
            "x-api-key":"860844a88b9eef42a61eb7aeaa1a90b210cf42927a9ca1e37b47d6860c798204"},
        ),
        data: parameters);
    print("responseSentMailList" + response.toString());

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.toString());
      SendEmailListModel sendEmailListModel = SendEmailListModel.fromJson(map);

      setState(() {
        checkInbox = true;
        inboxNoData = false;
        offset = sendEmailListModel.pageable!.offset!;
        limit = offset+10;
        total = sendEmailListModel.totalPages!;
        // print("offsettttt t " + offset.toString());
        // print("limittttttt t " + limit.toString());
      });
      updateSentMailList(sendEmailListModel.content!);
      ProgressDialog().dismissDialog(context);
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
      setState(() {
        checkInbox = false;
        inboxNoData = true;
        noDataText = "Sent items not Found!!";
      });
    }
  }

  //content sent list
  getMailSentContentList(String id) async {
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
      "id":id,
    };
    final response = await dio.get(ApiProvider.getSentContentMail+"/:$id/html",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "text/html",
            "x-api-key":"860844a88b9eef42a61eb7aeaa1a90b210cf42927a9ca1e37b47d6860c798204"},
        ),
    );
    print("responseMailContentList" + response.toString());

    if (response.statusCode == 200) {
     setState(() {
       messageContent=response.data;
     });
    }
    else if(response.statusCode == 404){
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
      Fluttertoast.showToast(
          msg: "Bad Network Connection try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          backgroundColor: buttoncolor,
          timeInSecForIosWeb: 1);
      setState(() {
        checkInbox = false;
        inboxNoData = true;
        noDataText = "Sent items not Found!!";
      });
    }
  }
}
