import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailslurp/api.dart';
import 'package:uuid/uuid.dart';
import '../../data/api.dart';
import '../../reasuable/background_screen.dart';
import '../../reasuable/theme.dart';
import '../../utils/check_internet.dart';
import '../../widget/progressloaded.dart';
import '../../widget/sharedpreference.dart';


class SendMail extends StatefulWidget {
  var emailId,bodyText;
  SendMail(this.emailId,this.bodyText);

  @override
  State<SendMail> createState() => _SendMailState();
}

class _SendMailState extends State<SendMail> {

  var inboxController = InboxControllerApi();

  final messageController = new TextEditingController();
  final replyMsgController = new TextEditingController();
  final subjectController = new TextEditingController();
  final receiverController = new TextEditingController();

  String senderVirtualNum="";
  String senderName="";
  String senderId="";

  @override
  void initState() {
    getValue();
    if(widget.emailId!=""){
      receiverController.text=widget.emailId;
    }else{
      receiverController.text="";
    }
    super.initState();
  }

  getValue()async{
    senderVirtualNum=await SharedPreference().getUserMobile();
    senderName=await SharedPreference().getuserName();
  }

  @override
  Widget build(BuildContext context) {
    return Backgroundscreen(
      ccontainerchild: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Container(
                  color: blackcolor,
                  // height: 200,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "New Mail",
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
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Expanded(
                               flex:1,
                               child: Text(
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
                             ),
                            Expanded(
                              flex: 8,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '1234567891@mailslurp.com',
                                  hintStyle: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey
                                          .withOpacity(0.8)),
                                  // filled: true,
                                ),
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                controller: receiverController,
                                style: TextStyle(color: Colors.white,fontSize: 16.0),
                              ),
                            ),
                            // Expanded(
                            //     flex: 1,
                            //     child: Image.asset("assets/images/Vector (3).png"))
                          ],
                        ),
                      ),
                      const Divider(
                        color: whitecolor,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            Expanded(
                              child: Text(
                                "Subject:",
                                style: TextStyle(
                                    fontFamily: "Helvatica",
                                    color: whitecolor,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                    // fontStyle: FontStyle.italic,
                                    fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                              flex: 1,
                            ),
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '',
                                  // filled: true,
                                ),
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                controller: subjectController,
                                style: TextStyle(color: Colors.white,fontSize: 16.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: whitecolor,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.7,
                  // height: 200,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                       TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Write your message here',
                          // filled: true,
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                         controller: messageController,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        widget.bodyText!=""? widget.bodyText:"",
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                      const SizedBox(
                        height: 200,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: () async{

                              },
                              child: Container(
                                width: 110,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xffE4C793),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.center,
                                child:const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    Text(
                                      "Attach Files",
                                      style: TextStyle(
                                          color: blackcolor,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                                onTap: () async{
                                  if(receiverController.text.isNotEmpty){
                                    if(subjectController.text.isNotEmpty){
                                      if(messageController.text.isNotEmpty){
                                        // var inboxController = InboxControllerApi();
                                        //
                                        //  inbox = await inboxController.createInboxWithOptions(CreateInboxDto());

                                        // var confirmation = await inboxController.sendEmailAndConfirm(inbox!.id,
                                        //     SendEmailOptions(
                                        //         to: [receiverController.text],
                                        //         subject: subjectController.text,
                                        //         body: messageController.text,
                                        //         isHTML: true
                                        //     )
                                        // );

                                        check().then((intenet) {
                                          if (intenet != null && intenet) {
                                            createMailApi();
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
                                      } else{
                                        Fluttertoast.showToast(
                                            msg: "Enter your message",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            textColor: Colors.white,
                                            backgroundColor: buttoncolor,
                                            timeInSecForIosWeb: 1);
                                      }
                                    } else{
                                      Fluttertoast.showToast(
                                          msg: "Subject shouldn't empty",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          textColor: Colors.white,
                                          backgroundColor: buttoncolor,
                                          timeInSecForIosWeb: 1);
                                    }
                                  } else{
                                    Fluttertoast.showToast(
                                        msg: "To Address shouldn't empty",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        textColor: Colors.white,
                                        backgroundColor: buttoncolor,
                                        timeInSecForIosWeb: 1);
                                  }
                                },
                                child: Container(
                                  width: 110,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: buttoncolor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  child:const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:  [
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
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  //Create mail
  createMailApi() async {
    ProgressDialog().showLoaderDialog(context);
    // BaseOptions options = new BaseOptions(
    //   baseUrl: ApiProvider().Baseurl,
    //   connectTimeout: 5000,
    //   receiveTimeout: 3000,
    // );
    // Dio dio = new Dio(options);

    Dio dio = new Dio();
    // dio.options.connectTimeout = 5000; //5s
    // dio.options.receiveTimeout = 3000;

    var token = await SharedPreference().gettoken();

    Map<String, String> parameters =  {
        "emailAddress":senderVirtualNum+"@mailslurp.com",
        "tags":"",
        "tags":"",
        "name":senderName,
        "description":"test",
        "useDomainPool":"",
        "favourite":"",
        "expiresAt":"",
        "expiresIn":"",
        "allowTeamAccess":"true",
        "inboxType":""
    };

    print("createmailParam :" + parameters.toString());

    final response = await dio.post(
      ApiProvider.createMail,
      options: Options(
          headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "x-api-key":"860844a88b9eef42a61eb7aeaa1a90b210cf42927a9ca1e37b47d6860c798204"},
      ),
      data: jsonEncode(parameters));

    print("createmailRes :" + response.toString());
    if (response.statusCode == 201) {

        ProgressDialog().dismissDialog(context);
        setState(() {
          senderId=response.data["id"];
          print("senderId "+senderId);
        });
        await SharedPreference().setSenderId(senderId);
        sendMailApi(senderId);
    } else {
      ProgressDialog().dismissDialog(context);
      Fluttertoast.showToast(
          msg: "Bad Network Connection try again..",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
          backgroundColor: Colors.lightGreen,
          timeInSecForIosWeb: 1);
    }
  }

  //send mail
  sendMailApi(String uuid) async {
    ProgressDialog().showLoaderDialog(context);
    // BaseOptions options = new BaseOptions(
    //   baseUrl: ApiProvider().Baseurl,
    //   connectTimeout: 5000,
    //   receiveTimeout: 3000,
    // );
    // Dio dio = new Dio(options);

    Dio dio = new Dio();
    // dio.options.connectTimeout = 5000; //5s
    // dio.options.receiveTimeout = 3000;

    var token = await SharedPreference().gettoken();

    Map<String, String> parameters =  {
      "to"  : receiverController.text,
      "senderId" : uuid,
      "body" : messageController.text,
      "subject" : subjectController.text
    } ;

    print("sendmailParam :" + parameters.toString());

    final response = await dio.post(
      ApiProvider.sendMail,
      options: Options(
          headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "x-api-key":"860844a88b9eef42a61eb7aeaa1a90b210cf42927a9ca1e37b47d6860c798204"},
      ),
      data: jsonEncode(parameters));

    print("sendmailRes :" + response.toString());
    if (response.statusCode == 201) {
        ProgressDialog().dismissDialog(context);
        Fluttertoast.showToast(
            msg: "Mail send Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            textColor: Colors.white,
            backgroundColor: Colors.lightGreen,
            timeInSecForIosWeb: 1);
        Navigator.pop(context);
    } else {
      ProgressDialog().dismissDialog(context);
      Fluttertoast.showToast(
          msg: "Bad Network Connection try again..",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
          backgroundColor: Colors.lightGreen,
          timeInSecForIosWeb: 1);
    }
  }
}
