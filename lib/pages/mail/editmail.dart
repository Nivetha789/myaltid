
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailslurp/api.dart';
import '../../reasuable/background_screen.dart';
import '../../reasuable/theme.dart';


class SendMail extends StatefulWidget {
  const SendMail({super.key});

  @override
  State<SendMail> createState() => _SendMailState();
}

class _SendMailState extends State<SendMail> {

  var inboxController = InboxControllerApi();

  final messageController = new TextEditingController();
  final subjectController = new TextEditingController();
  final receiverController = new TextEditingController();

  @override
  void initState() {
    defaultApiClient.addDefaultHeader("x-api-key", "860844a88b9eef42a61eb7aeaa1a90b210cf42927a9ca1e37b47d6860c798204");
    super.initState();
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
                                  hintText: '1234567891@myaltid.com',
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
                                        var inboxController = InboxControllerApi();

                                        var inbox = await inboxController.createInboxWithOptions(CreateInboxDto());

                                        var confirmation = await inboxController.sendEmailAndConfirm(inbox!.id,
                                            SendEmailOptions(
                                                to: [receiverController.text],
                                                subject: subjectController.text,
                                                body: messageController.text,
                                                isHTML: true
                                            )
                                        );
                                        print("mailslurp "+confirmation!.inboxId+", "+inbox.id);
                                        Fluttertoast.showToast(
                                            msg: "Mail sent successfully",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            textColor: Colors.white,
                                            backgroundColor: buttoncolor,
                                            timeInSecForIosWeb: 1);
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
}
