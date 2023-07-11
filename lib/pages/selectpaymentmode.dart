import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myaltid/data/api.dart';
import 'package:myaltid/pages/payment_success_screen.dart';
import 'package:myaltid/pages/paymentsuccessfull.dart';
import 'package:myaltid/reasuable/theme.dart';
import 'package:myaltid/widget/sharedpreference.dart';
import 'package:weipl_checkout_flutter/weipl_checkout_flutter.dart';
import '../module/TransactionVerifyModel.dart';
import '../reasuable/background_screen.dart';
import '../widget/progressloaded.dart';
import 'WebViewScreen.dart';

class PaymentmodeSelection extends StatefulWidget {
  String username,mobileNum,mailId,amount,transactionId,userId,hash,merchantId,primaryColor,secondColor,btnColor1,btnColor2;
  PaymentmodeSelection(this.username,this.mobileNum,this.mailId,this.amount,this.transactionId,
      this.userId,this.hash,this.merchantId,this.primaryColor,this.secondColor,this.btnColor1,this.btnColor2);

  @override
  State<PaymentmodeSelection> createState() => _PaymentmodeSelectionState();
}

class _PaymentmodeSelectionState extends State<PaymentmodeSelection> {
  List gender = [
    "UPI",
    "Credit / Debit Card",
    "Net Banking",
    "Wallet",
    "Crypto"
  ];

  late String select = "0";

  late String selectoption = "0";
  var randomnumber;

  //payment gateway
  WeiplCheckoutFlutter wlCheckoutFlutter = WeiplCheckoutFlutter();

  String transactionID="";

  @override
  void initState() {
    randomnumber = generateRandomNumber();
    // UserRegister();
    // paymentgatewaylink();
    super.initState();
  }

  var data;
  paymentgatewaylink() async {
    try {
      Dio dio = Dio();

      var token = await SharedPreference().gettoken();
      var phoneNumber = await SharedPreference().getphonenumber();
      print(phoneNumber);
      var cPlanId = await SharedPreference().getplanid();
      var cSubscriptionId = await SharedPreference().getsubscriptionId();

      var parameters = {
        "c_PlanId": cPlanId,
        "c_SubscriptionId": cSubscriptionId,
      };
      print(parameters);
      print(token);
      dio.options.contentType = Headers.formUrlEncodedContentType;
      final response = await dio.post(
        "http://13.59.194.102/app/index.php",
        data: parameters,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {"Authorization": "Bearer $token"},
        ),
      );
      debugPrint("pavithra ${response.data}");
      // var data = jsonDecode(response.data);
      // print("dfkjsfddkjh $data");
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => WebViewScreen(response.data!)));

      if (response.data["status"] == 1) {
      // await SharedPreference()
        //     .setUserId(response.data["data"]["c_ActivePlan"]);

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const PaymentSuccessfull()));
      } else {
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'On Snap!',
            message: response.data["error"][0],
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (e) {
      print(e);
    }
  }

  UserRegister() async {
    try {
      Dio dio = Dio();

      var token = await SharedPreference().gettoken();
      var cPlanId = await SharedPreference().getplanid();
      var cSubscriptionId = await SharedPreference().getsubscriptionId();

      var parameters = {
        "c_PlanId": cPlanId,
        "c_SubscriptionId": cSubscriptionId,
        "c_PaymentId": randomnumber.toString(),
        "c_paymentStatus": "Sucesss"
      };
      print(parameters);
      print(token);
      dio.options.contentType = Headers.formUrlEncodedContentType;
      final response = await dio.post(
        ApiProvider.addsubscrptiondetils,
        data: parameters,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {"Authorization": "Bearer $token"},
        ),
      );
      debugPrint("pavithra ${response.data}");
      // var data = jsonDecode(response.data);/
      // print("dfkjsfddkjh $data");
      if (response.data["status"] == 1) {
        // await SharedPreference()
        //     .setUserId(response.data["data"]["c_ActivePlan"]);

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const PaymentSuccessfull()));
      } else {
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'On Snap!',
            message: response.data["error"][0],
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (e) {
      print(e);
    }
  }

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: buttoncolor,
          fillColor: MaterialStateProperty.all<Color>(buttoncolor),
          value: gender[btnValue],
          groupValue: select,
          onChanged: (value) {
            setState(() {
              debugPrint(value);
              select = value;
              selectoption = value;
            });
          },
        ),
        Text(
          title,
          style: const TextStyle(
              fontFamily: "Helvatica",
              color: whitecolor,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              // fontStyle: FontStyle.italic,
              fontSize: 16),
          textAlign: TextAlign.start,
        ),
      ],
    );
  }

  String generateRandomNumber() {
    final random = Random();
    final maxDigits = 18;
    final buffer = StringBuffer();

    for (var i = 0; i < maxDigits; i++) {
      buffer.write(random.nextInt(10)); // Generates a random digit from 0 to 9
    }

    return buffer.toString();
  }

  void main() {
    final randomNumber = generateRandomNumber();
    print(randomNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Backgroundscreen(
      ccontainerchild: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Select Payment Mode",
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
                          onTap: () {},
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
              const SizedBox(
                height: 20,
              ),
              Card(
                elevation: 10,
                color: blackcolor,
                shadowColor: buttoncolor,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "pay to MyAltID",
                        style: TextStyle(
                            color: whitecolor,
                            fontFamily: "Helvatica",
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            // fontStyle: FontStyle.italic,
                            fontSize: 14),
                      ),
                      Text(
                        "Order # "+widget.userId.toString(),
                        style: TextStyle(
                            color: whitecolor,
                            fontFamily: "Helvatica",
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            // fontStyle: FontStyle.italic,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                elevation: 10,
                color: blackcolor,
                shadowColor: buttoncolor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 270,
                      width: MediaQuery.of(context).size.width - 40,
                      child: Column(
                        children: [
                          addRadioButton(0, 'UPI'),
                          addRadioButton(1, 'Credit / Debit Card'),
                          addRadioButton(2, 'Net Banking'),
                          addRadioButton(3, 'Wallet'),
                          addRadioButton(4, 'Crypto'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 160,
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          child: SizedBox(
            width: double.infinity,
            child: selectoption == "0"
                ? InkWell(
                    onTap: () {
                      // paymentgatewaylink();
                      final snackBar = SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Oh Hey!',
                          message: 'Please select your Paymentmode',
                          contentType: ContentType.failure,
                        ),
                      );

                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: buttoncolor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Payable (inc GST)",
                            style: TextStyle(
                                color: blackcolor,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Rs."+widget.amount.toString(),
                            style: TextStyle(
                                color: blackcolor,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () async {
                      String deviceID = ""; // initiaze varibale
                      var token = await SharedPreference().gettoken();
                      if (Platform.isAndroid) {
                        deviceID = "AndroidSH2"; // Android-specific deviceId, supported options are "AndroidSH1" & "AndroidSH2"
                      } else if (Platform.isIOS) {
                        deviceID = "iOSSH2"; // iOS-specific deviceId, supported options are "iOSSH1" & "iOSSH2"
                      }

                      var reqJson = {
                        "features": {
                          "enableAbortResponse": true,
                          "enableExpressPay": true,
                          "enableInstrumentDeRegistration": true,
                          "enableMerTxnDetails": true
                        },
                        "consumerData": {
                          "deviceId": deviceID,   //supported values "ANDROIDSH1" or "ANDROIDSH2" for Android, supported values "iOSSH1" or "iOSSH2" for iOS and supported values
                          "token":
                          widget.hash,
                          "paymentMode": "all",
                          "merchantLogoUrl":
                          "https://www.paynimo.com/CompanyDocs/company-logo-vertical.png", //provided merchant logo will be displayed
                          "merchantId": widget.merchantId,
                          "currency": "INR",
                          "consumerId": widget.userId,
                          "consumerMobileNo": widget.mobileNum,
                          "consumerEmailId": widget.mailId,
                          "txnId": widget.transactionId, //Unique merchant transaction ID
                          "items": [
                            {"itemId": "first", "amount": widget.amount, "comAmt": "0"}
                          ],
                          "customStyle": {
                            "PRIMARY_COLOR_CODE":
                            widget.primaryColor, //merchant primary color code
                            "SECONDARY_COLOR_CODE":
                            widget.secondColor, //provide merchant"s suitable color code
                            "BUTTON_COLOR_CODE_1":
                            widget.btnColor1, //merchant"s button background color code
                            "BUTTON_COLOR_CODE_2":
                            widget.btnColor2 //provide merchant"s suitable color code for button text
                          }
                        }
                      };

                      wlCheckoutFlutter.on(
                          WeiplCheckoutFlutter.wlResponse, handleResponse);
                      wlCheckoutFlutter.open(reqJson);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: buttoncolor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Payable (inc GST)",
                            style: TextStyle(
                                color: blackcolor,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Rs."+widget.amount.toString(),
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
        ),
      ),
    );
  }

  void handleResponse(Map<dynamic, dynamic> response) {
    // showAlertDialog(context, "WL SDK Response", "$response");
    print("responsepayment "+response.toString());

    List<String> clist =  response.toString().split("|");

    print("splitListsplitList "+clist.toString());

    final dateList = clist.toString().split(",");
    // print("split " + dateList[3]);
    print("split2" + dateList[1]);
    if(dateList[1].toString() == " success"){
      updatePaymentDetails(dateList[3],dateList[5]);
    }else{
      Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
              builder: (BuildContext context) => PaymentSuccessScreen(
                  "SORRY !",
                  false,
                  "Your Package Payment Unsuccessfully !!",
                  "")));
    }

  }


  //update payment details
  updatePaymentDetails(String paymentID,String transactionID) async {
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

    var parameters = {"c_PaymentId": paymentID,"c_TxnId":transactionID};
    print("updatePaymentDetailsParams :" + parameters.toString());

    dio.options.contentType = Headers.formUrlEncodedContentType;
    final response = await dio.post(
      ApiProvider.updatepaymentdetails,
      data: parameters,
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {"Authorization": "Bearer $token"},
      ),
    );
    print("updatePaymentDetailsRes :" + response.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.toString());
      TransactionVerifyModel transactionVerifyModel =
      TransactionVerifyModel.fromJson(map);

      if (transactionVerifyModel.status == 1) {
        ProgressDialog().dismissDialog(context);
        Fluttertoast.showToast(
            msg: transactionVerifyModel.message.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            textColor: Colors.white,
            backgroundColor: Colors.lightGreen,
            timeInSecForIosWeb: 1);
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => PaymentSuccessfull()));
      } else {
        ProgressDialog().dismissDialog(context);
        Fluttertoast.showToast(
            msg: "Not Found",
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

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Okay"),
      onPressed: () {
        Navigator.pop(context, false);
      },
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(left: 25, right: 25),
          title: Center(child: Text(title)),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: SizedBox(
            height: 400,
            width: 300,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Text(message),
                ],
              ),
            ),
          ),
          actions: [
            continueButton,
          ],
        );
      },
    );
  }
}
