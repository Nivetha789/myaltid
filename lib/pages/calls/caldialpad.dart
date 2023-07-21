import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../data/api.dart';
import '../../module/PhoneDialModel.dart';
import '../../reasuable/numpad.dart';
import '../../reasuable/theme.dart';
import '../../utils/check_internet.dart';
import '../../widget/progressloaded.dart';
import '../../widget/sharedpreference.dart';

class CalldialpadScreen extends StatefulWidget {
  const CalldialpadScreen({super.key});

  @override
  State<CalldialpadScreen> createState() => _CalldialpadScreenState();
}

class _CalldialpadScreenState extends State<CalldialpadScreen> {
  final TextEditingController _myController = TextEditingController();
  late String oldvalue;
  bool isvalue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff065F0A),
            Color(0xff000000),
          ],
        )),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                height: 70,
                child: Center(
                    child: TextFormField(
                  controller: _myController,
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10)
                  ], // Limit input to 10 characters
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: _myController.text.isNotEmpty
                        ?const SizedBox(): IconButton(
                      onPressed: () {
                        _myController.text = _myController.text
                            .substring(0, _myController.text.length - 1);
                      },
                      icon: const Icon(
                        Icons.backspace,
                        color: Colors.white,
                      ),
                    )
                    // filled: true,
                  ),
                  onChanged: (value) {
                    if (value.length > 10) {
                      setState(() {
                        _myController.text = value.substring(0, 10);
                        _myController.selection =
                            TextSelection.collapsed(offset: 10);
                      });
                    }
                  },

                  style: const TextStyle(
                      fontSize: 30,
                      fontFamily: "Helvatica",
                      fontWeight: FontWeight.w600,
                      color: whitecolor),

                  // Disable the default soft keybaord
                  keyboardType: TextInputType.none,
                      maxLines: 1,
                      // maxLength: 10,
                )),
              ),
            ),
            // implement the custom NumPad
            NumPad(
              buttonSize: 75,
              buttonColor: const Color(0xff003F03),
              iconColor: Colors.deepOrange,
              controller: _myController,
              delete: () {
                _myController.text = _myController.text
                    .substring(0, _myController.text.length - 1);
              },
              // maxLength: 10,
              // do something with the input numbers
              onSubmit: () {
                debugPrint('Your code: ${_myController.text}');
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          content: Text(
                            "You code is ${_myController.text}",
                            style: const TextStyle(fontSize: 30),
                          ),
                        ));
              },
              onChanged: (value) {
                debugPrint('Your code: ${_myController.text}');
                if (value.length > 10) {
                  _myController.value = TextEditingValue(
                    text: oldvalue, // Reset the value to the previous value
                    selection: TextSelection.fromPosition(
                      TextPosition(offset: 10), // Place the cursor at the end
                    ),
                  );
                } else {
                  oldvalue = value; // Update the previous value
                }
              },
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: buttoncolor,
                shape: BoxShape.circle,

                // borderRadius: BorderRadius.all(Radius.circular(80)),
                // border: Border.all(
                //   color: buttoncolor,
                // ),
              ),
              child: InkWell(
                splashColor: buttoncolor, // Splash color
                onTap: () {
                  print("numberrrr "+_myController.text);
                  check().then((intenet) {
                    if (intenet != null && intenet) {
                      if(_myController.text.length==10){
                        dialPadApi(_myController.text);
                      }else{
                        Fluttertoast.showToast(
                            msg: "Your mobile number should contain 10 digits.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            textColor: Colors.white,
                            backgroundColor: Colors.lightGreen,
                            timeInSecForIosWeb: 1);
                      }
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
                },
                child: const SizedBox(
                    child: Icon(
                  Icons.wifi_calling_3_sharp,
                  color: whitecolor,
                  size: 40,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //dialpad api
  dialPadApi(String number) async {
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

    var parameters = {
      "n_Callee": _myController.text,
    };
    print("paymentDetailsParams :" + parameters.toString());

    dio.options.contentType = Headers.formUrlEncodedContentType;
    final response = await dio.post(
      ApiProvider.dialnumber,
      data: parameters,
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {"Authorization": "Bearer $token",
          "Content-Type": "application/x-www-form-urlencoded"},
      ),
    );
    print("paymentDetailsRes :" + response.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.toString());
      PhoneDialerModel phoneDialModel =
      PhoneDialerModel.fromJson(map);

      if (phoneDialModel.status == 1) {
        ProgressDialog().dismissDialog(context);
        _callNumber(number);
      } else {
        ProgressDialog().dismissDialog(context);
        Fluttertoast.showToast(
            msg: phoneDialModel.message.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            textColor: Colors.white,
            backgroundColor: Colors.lightGreen,
            timeInSecForIosWeb: 1);
      }
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

  _callNumber(String number) async{
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }
}
