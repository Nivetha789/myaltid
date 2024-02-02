import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../data/api.dart';
import '../../module/Message/MessageTemplatesModel.dart';
import '../../module/Message/SendMessageModel.dart';
import '../../reasuable/background_screen.dart';
import '../../reasuable/theme.dart';
import '../../utils/check_internet.dart';
import '../../widget/progressloaded.dart';
import '../../widget/sharedpreference.dart';

class SendMessage extends StatefulWidget {
  var virNumber;
  SendMessage(this.virNumber);

  @override
  State<SendMessage> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  List<MessageTemplatesData> messageTemplatesList = [];
  String msgTemName = "";
  String msgTemId = "";
  String virtualNum = "";
  String userName = "";
  final mobilenumberController = TextEditingController();
  int _selectedIndex = 0;

  //pass api
  String sendSmsString="";


  @override
  void initState() {
    check().then((intenet) {
      if (intenet != null && intenet) {
        getMessageTemplates();
      } else {
        Fluttertoast.showToast(
            msg: "Please check your internet connection",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.white,
            backgroundColor: Colors.lightGreen,
            timeInSecForIosWeb: 1);
      }
    });
    getValue();
    super.initState();
  }

  getValue() async {
    if (await SharedPreference().getUserMobile() != null) {
      virtualNum = await SharedPreference().getUserMobile();
      print("virtualNum  "+virtualNum);
    } else {
      virtualNum = "";
      print("virtualNum 1 "+virtualNum);
    }
    if (await SharedPreference().getuserName() != null) {
      userName = await SharedPreference().getuserName();
    } else {
      userName = "";
    }
    if(widget.virNumber !="") {
      mobilenumberController.text = widget.virNumber.toString();
    }
  }

  updatePackage(List<MessageTemplatesData> messageTemplatesList1) {
    setState(() {
      messageTemplatesList.clear();
      messageTemplatesList.addAll(messageTemplatesList1);
    });
  }

  _onSelected(int index) {
    setState(() {
      _selectedIndex = index;
      final find = '[VAR2]';
      String msgTemName1= messageTemplatesList[index].message!.replaceAll(find, '1000');

      final find1='[VAR1]';
      String vNumChange=msgTemName1.replaceAll(find1, virtualNum);

      sendSmsString=vNumChange;
      print("sendedSms "+sendSmsString);
      msgTemName=messageTemplatesList[index].templateName!;
      msgTemId=messageTemplatesList[index].templateId!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Backgroundscreen(
      ccontainerchild: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: blackcolor,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
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
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    height: 45,
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    child: TextFormField(
                                      textAlign: TextAlign.left,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      controller: mobilenumberController,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[0-9]")),
                                      ],
                                      maxLength: 10,
                                      buildCounter: (BuildContext? context,
                                              {int? currentLength,
                                              int? maxLength,
                                              bool? isFocused}) =>
                                          null,
                                      decoration: InputDecoration(

                                        labelText: "Mobile Number",
                                        labelStyle: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.white,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xff495271)
                                                  .withOpacity(0.3),
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          // width: 0.0 produces a thin "hairline" border
                                          borderSide: BorderSide(
                                              color: Colors.grey[300]!,
                                              width: 1.0),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 20.0, 20.0, 20.0),
                                      ),
                                      style: new TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Image.asset("assets/images/Vector (3).png")
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.0,
                  color: whitecolor,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: messageTemplatesList.length,
                    itemBuilder: (BuildContext context, int index) {

                      final find = '[VAR2]';
                      String msgTemName= messageTemplatesList[index].message!.replaceAll(find, '1000');

                      final find1='[VAR1]';
                      String vNumChange=msgTemName.replaceAll(find1, virtualNum);
                      // print("msgggggrgrgrgr "+msgTemName);

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _onSelected(index);
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.9, color: _selectedIndex != null &&
                                      _selectedIndex == index
                                      ? buttoncolor
                                      : Colors.grey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          margin: EdgeInsets.only(
                              top: 10.0, bottom: 10.0, left: 35.0, right: 35.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              vNumChange,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: _selectedIndex != null &&
                                          _selectedIndex == index
                                      ? buttoncolor
                                      : Colors.black,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                      onTap: () {
                        if (mobilenumberController.text.isNotEmpty) {
                          if (msgTemId.isNotEmpty) {
                            if (mobilenumberController.text.length == 10) {
                              sendSmsApi();
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Mobile number length should 10",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  textColor: Colors.black,
                                  backgroundColor: buttoncolor,
                                  timeInSecForIosWeb: 1);
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: "Select your message",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                textColor: Colors.black,
                                backgroundColor: buttoncolor,
                                timeInSecForIosWeb: 1);
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: "Mobile number should not empty",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              textColor: Colors.black,
                              backgroundColor: buttoncolor,
                              timeInSecForIosWeb: 1);
                        }
                      },
                      child: Container(
                        width: 110,
                        height: 50,
                        margin: EdgeInsets.only(right: 16.0),
                        decoration: BoxDecoration(
                          color: buttoncolor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                ),
              ),
              SizedBox(height: 30,)
            ],
          )),
    );
  }

  //temp
  getMessageTemplates() async {
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
    final response = await dio.get(ApiProvider.messageTemplate,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            'Accept': "application/json",
            "Authorization": "Bearer "+ token},
        ));
    print("responseMessageList" + response.toString());

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.toString());
      MessageTemplatesModel packageModel = MessageTemplatesModel.fromJson(map);

      if (packageModel.status == 0) {
        ProgressDialog().dismissDialog(context);
        updatePackage(packageModel.data!);
      } else {
        ProgressDialog().dismissDialog(context);
        Fluttertoast.showToast(
            msg: packageModel.message.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.black,
            backgroundColor: buttoncolor,
            timeInSecForIosWeb: 1);
      }
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

  //send sms
  sendSmsApi() async {
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
      "n_Mobile_no": mobilenumberController.text,
      "n_template_id":msgTemId,
      "c_message":sendSmsString,
      "c_template_name":msgTemName};
    print("msgTemMessageParam "+parameters.toString());
    final response = await dio.post(ApiProvider.sendMessage,
        data: parameters,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            'Accept': "application/json",
            "Authorization": "Bearer "+ token},
        ));
    print("paramMessageList" + response.toString());

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.toString());
      SendMessageModel sendMessageModel = SendMessageModel.fromJson(map);

      if (sendMessageModel.status == 1) {
        ProgressDialog().dismissDialog(context);
        Fluttertoast.showToast(
            msg: sendMessageModel.message.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.black,
            backgroundColor: buttoncolor,
            timeInSecForIosWeb: 1);
        Navigator.pop(context,true);
      } else {
        ProgressDialog().dismissDialog(context);
        Fluttertoast.showToast(
            msg: sendMessageModel.message.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.black,
            backgroundColor: buttoncolor,
            timeInSecForIosWeb: 1);
      }
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
