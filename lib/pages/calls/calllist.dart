import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:myaltid/pages/calls/caldialpad.dart';
import 'package:myaltid/pages/calls/calling.dart';

import '../../data/api.dart';
import '../../module/CallHistory/AllCallsHistoryModel.dart';
import '../../module/DndModel/UpdateDndPreferenceModel.dart';
import '../../module/UserProfileModel/UserProfileModel.dart';
import '../../reasuable/background_screen.dart';
import '../../reasuable/bottomnavbar.dart';
import '../../reasuable/dialogbox.dart';
import '../../reasuable/theme.dart';
import '../../utils/check_internet.dart';
import '../../widget/progressloaded.dart';
import '../../widget/sharedpreference.dart';

class CallistPage extends StatefulWidget {
  const CallistPage({super.key});

  @override
  State<CallistPage> createState() => _CallistPageState();
}

class _CallistPageState extends State<CallistPage>
    with SingleTickerProviderStateMixin {
  bool isselected = false;
  var forIos = false;
  var dndEnabled = 0;

  int disableStatus=0;
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
  int selectedTabPosition = 0;

  bool checkInbox = false;
  bool inboxNoData = false;
  String noDataText = 'No Data found';

  int offset = 0;
  int limit = 10;
  int total = 0;
  bool loadmore = false;
  int totalPage = 0;

  bool progressbar = true;
  List<AllCallHistoryDocs> allCallHistoryDataList = [];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
    _tabController.addListener(() {
      setState(() {
        selectedTabPosition = _tabController.index;
        print("tabbbbb " + selectedTabPosition.toString());
        switch (selectedTabPosition) {
          case 0:
            setState(() {
              check().then((intenet) {
                if (intenet != null && intenet) {
                  getCallsList("all");
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
          case 1:
            setState(() {
              check().then((intenet) {
                if (intenet != null && intenet) {
                  getCallsList("incoming");
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
          case 2:
            setState(() {
              check().then((intenet) {
                if (intenet != null && intenet) {
                  getCallsList("outgoing");
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
    setValue();
      check().then((intenet) {
        if (intenet != null && intenet) {
          getCallsList("outgoing");
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

  setValue() async{
    disableStatus= await SharedPreference().getDnd();
    print("dddnndndndndnndndndnd");
    if(disableStatus==1){
      forIos=true;
    }else{
      forIos=false;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  updateList(List<AllCallHistoryDocs> allCallHistoryDataList1) {
    allCallHistoryDataList.clear();
    setState(() {
      allCallHistoryDataList.addAll(allCallHistoryDataList1);
      // totalPage = (total / limit).ceil();
      // print('totalPage ' + totalPage.toString());
    });
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
        body: Container(
          child: ListView(
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
                        onChanged: (value) {
                          setState(() {
                            forIos = value;
                            print("foridd " + forIos.toString());
                            if (forIos) {
                              dndEnabled = 1;
                            } else {
                              dndEnabled = 0;
                            }
                          });
                          check().then((intenet) {
                            if (intenet != null && intenet) {
                              dndUpdateApi(dndEnabled);
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
                        }),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10.0),
                      child: Text(
                        forIos ? "DND Enabled":"Enable DND",
                        style: TextStyle(
                            color: whitecolor,
                            fontFamily: "Helvatica",
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
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

  refresh() {
    setState(() {
      setValue();
    });
  }

  Widget callWidgets(int position) {
    if (position == 0) {
      return Column(
        children: [
          Visibility(
            visible: checkInbox,
            child: Container(
              child: ListView.builder(
                itemCount: allCallHistoryDataList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  String totalDuration = "";
                  String totalDur =
                      allCallHistoryDataList[index].totalDuration.toString();
                  if (totalDur.length > 1) {
                    var parts = totalDur.split(':');

                    var time = parts[0].trim();
                    var time1 = parts[1].trim();
                    // print("timmeee "+time);
                    // print("timmeee1 "+time1);
                    totalDuration = time + " h " + time1 + " m";
                  } else {
                    totalDuration =
                        allCallHistoryDataList[index].totalDuration.toString() +
                            " m";
                  }

                  //date split
                  String cDate =
                      allCallHistoryDataList[index].receivedAt.toString();
                  var cDate1 = cDate.split(" ");
                  var currentDate = cDate1[0].trim();
                  var currentDate1 = cDate1[1].trim();
                  // DateTime dateTime = DateTime.parse(currentDate);
                  //
                  // var day=DateFormat('EEEE').format(dateTime);
                  //
                  // print("dayyyyyy "+day);
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const CallingPage()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.account_circle,
                                    color: whitecolor,
                                    size: 40,
                                  ),
                                  SizedBox(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        allCallHistoryDataList[index]
                                            .regNumber!,
                                        style: TextStyle(
                                            color: whitecolor, fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    totalDuration,
                                    style: TextStyle(
                                        color: whitecolor, fontSize: 13),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    currentDate,
                                    style: TextStyle(
                                        color: whitecolor, fontSize: 13),
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
                        width: 90, height: 90),
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
    } else if (position == 1) {
      return Column(
        children: [
          Visibility(
            visible: checkInbox,
            child: Container(
              child: ListView.builder(
                itemCount: allCallHistoryDataList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  String totalDuration = "";
                  String totalDur =
                      allCallHistoryDataList[index].totalDuration.toString();
                  if (totalDur.length > 1) {
                    var parts = totalDur.split(':');

                    var time = parts[0].trim();
                    var time1 = parts[1].trim();
                    // print("timmeee "+time);
                    // print("timmeee1 "+time1);
                    totalDuration = time + " h " + time1 + " m";
                  } else {
                    totalDuration =
                        allCallHistoryDataList[index].totalDuration.toString() +
                            " m";
                  }

                  //date split
                  String cDate =
                      allCallHistoryDataList[index].receivedAt.toString();
                  var cDate1 = cDate.split(" ");
                  var currentDate = cDate1[0].trim();
                  var currentDate1 = cDate1[1].trim();

                  // //day in words
                  // String date;
                  // DateTime convertedDate =
                  // DateFormat("DD/MM/YYYY").parse("02/08/2023");
                  // final now = DateTime.now();
                  // final today = DateTime(now.year, now.month, now.day);
                  // final yesterday = DateTime(now.year, now.month, now.day - 1);
                  // final tomorrow = DateTime(now.year, now.month, now.day + 1);
                  //
                  // final dateToCheck = convertedDate;
                  // final checkDate = DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
                  // if (checkDate == today) {
                  //   date = "Today";
                  // } else if (checkDate == yesterday) {
                  //   date = "Yesterday";
                  // } else if (checkDate == tomorrow) {
                  //   date = "Tomorrow";
                  // } else {
                  //   date = currentDate;
                  // }
                  // print("datyyyyyyy"+date);

                  return Container(
                    margin: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.account_circle,
                                  color: whitecolor,
                                  size: 40,
                                ),
                                SizedBox(
                                  // width: MediaQuery.of(context).size.width * 0.4,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      allCallHistoryDataList[index].regNumber!,
                                      style: TextStyle(
                                          color: whitecolor, fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  totalDuration,
                                  style: TextStyle(
                                      color: whitecolor, fontSize: 13),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  currentDate,
                                  style: TextStyle(
                                      color: whitecolor, fontSize: 13),
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
              ),
            ),
          ),
          Visibility(
            visible: inboxNoData,
            child: Container(
              height: MediaQuery.of(context).size.height / 1.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset('assets/images/calls_empty.png',
                        width: 90, height: 90),
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
    } else {
      return Column(
        children: [
          Visibility(
            visible: checkInbox,
            child: Container(
              child: ListView.builder(
                itemCount: allCallHistoryDataList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  String totalDuration = "";
                  String totalDur =
                      allCallHistoryDataList[index].totalDuration.toString();
                  if (totalDur.length > 1) {
                    var parts = totalDur.split(':');

                    var time = parts[0].trim();
                    var time1 = parts[1].trim();
                    // print("timmeee "+time);
                    // print("timmeee1 "+time1);
                    totalDuration = time + " h " + time1 + " m";
                  } else {
                    totalDuration =
                        allCallHistoryDataList[index].totalDuration.toString() +
                            " m";
                  }

                  //date split
                  String cDate =
                      allCallHistoryDataList[index].receivedAt.toString();
                  var cDate1 = cDate.split(" ");
                  var currentDate = cDate1[0].trim();
                  var currentDate1 = cDate1[1].trim();
                  // DateTime dateTime = DateTime.parse(currentDate);
                  //
                  // var day=DateFormat('EEEE').format(dateTime);
                  //
                  // print("dayyyyyy "+day);
                  return Container(
                    margin: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.account_circle,
                                  color: whitecolor,
                                  size: 40,
                                ),
                                SizedBox(
                                  // width: MediaQuery.of(context).size.width * 0.4,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      allCallHistoryDataList[index].regNumber!,
                                      style: TextStyle(
                                          color: whitecolor, fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  totalDuration,
                                  style: TextStyle(
                                      color: whitecolor, fontSize: 13),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  currentDate,
                                  style: TextStyle(
                                      color: whitecolor, fontSize: 13),
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
              ),
            ),
          ),
          Visibility(
            visible: inboxNoData,
            child: Container(
              height: MediaQuery.of(context).size.height / 1.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset('assets/images/calls_empty.png',
                        width: 90, height: 90),
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
    }
  }

  //call history
  getCallsList(String type) async {
    ProgressDialog().showLoaderDialog(context);

    Dio dio = new Dio();

    var token = await SharedPreference().gettoken();
    var parameters = {"n_Offset": offset, "n_Limit": limit, "c_Type": type};
    // print("dashParam: " + parameters.toString());
    dio.options.contentType = Headers.formUrlEncodedContentType;
    final response = await dio.post(ApiProvider.allCalls,
        options:
            Options(contentType: Headers.formUrlEncodedContentType, headers: {
          'Content-Type': "application/json",
          'Authorization': "Bearer " + token,
        }),
        data: parameters);
    print("paramcalllist " + parameters.toString());
    print(response.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.toString());
      AllCallHistoryModel allCallHistoryModel =
          AllCallHistoryModel.fromJson(map);

      if (allCallHistoryModel.status == 1) {
        ProgressDialog().dismissDialog(context);
        if(allCallHistoryModel.data!.total! !=0){
          setState(() {
            checkInbox = true;
            inboxNoData = false;
            offset = allCallHistoryModel.data!.offset!;
            limit = allCallHistoryModel.data!.limit!;
            total = allCallHistoryModel.data!.total!;
            // print("offsettttt t " + offset.toString());
            // print("limittttttt t " + limit.toString());
          });
          // setState(() {
          //   gifLoader = false;
          // });

          updateList(allCallHistoryModel.data!.docs!);
        }else{
          print("111111111111111111");
          setState(() {
            checkInbox = false;
            inboxNoData = true;
            noDataText = "No Calls Found...";
          });
        }
      } else {
        setState(() {
          checkInbox = false;
          inboxNoData = true;
          noDataText = "No Calls Found...";
        });
        ProgressDialog().dismissDialog(context);
      }
    } else {
      setState(() {
          checkInbox = false;
          inboxNoData = true;
          noDataText = "Bad network Connection...!";
      });
      ProgressDialog().dismissDialog(context);
    }
  }

  //dnd update
  dndUpdateApi(int dndValue) async {
    ProgressDialog().showLoaderDialog(context);

    Dio dio = new Dio();

    var token = await SharedPreference().gettoken();
    var parameters = {
      "n_CallAddressBook": 0,
      "n_CallActiveMode": 0,
      "n_SmsPeople": 0,
      "n_SmsAddressBook": 0,
      "n_Dnd": dndValue,
      "n_Biometric": 0
    };
    // print("dashParam: " + parameters.toString());
    dio.options.contentType = Headers.formUrlEncodedContentType;
    final response = await dio.post(ApiProvider.updateDND,
        options:
            Options(contentType: Headers.formUrlEncodedContentType, headers: {
          'Content-Type': "application/json",
          'Authorization': "Bearer " + token,
        }),
        data: parameters);
    print("paramDnd " + parameters.toString());
    print(response.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.toString());
      UpdateDndPreferenceModel updateDndPreferenceModel =
          UpdateDndPreferenceModel.fromJson(map);

      if (updateDndPreferenceModel.status == 1) {
        ProgressDialog().dismissDialog(context);
        await SharedPreference()
            .setDnd(updateDndPreferenceModel.data![0].nDnd.toString());
        Fluttertoast.showToast(
            msg: updateDndPreferenceModel.message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            textColor: Colors.white,
            backgroundColor: buttoncolor,
            timeInSecForIosWeb: 1);
      } else {
        setState(() {
          checkInbox = false;
          inboxNoData = true;
          noDataText = updateDndPreferenceModel.message!;
        });
        ProgressDialog().dismissDialog(context);
      }
    } else {
      setState(() {
        // matchingProfileNoData = true;
        // matchingProfileNoDataTxt = "Bad Network Connection try again..";
        // print("gftftftddsffdf");
      });
      ProgressDialog().dismissDialog(context);
    }
  }
}
