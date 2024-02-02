import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  setLogin(String stringValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('imagepath', stringValue);
    return true;
  }

  getLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('imagepath');
    return stringValue;
  }

  setUserId(String stringValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', stringValue);
    return true;
  }

  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('id');
    return stringValue;
  }

  setActivePln(String stringValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('cActivePlan', stringValue);
    return true;
  }

  getActivePln() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('cActivePlan');
    return stringValue;
  }

  setuserName(String stringValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', stringValue);
    return true;
  }

  getuserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('userName');
    return stringValue;
  }

  setphonenumber(String stringValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('PhoneNumber', stringValue);
    return true;
  }

  getphonenumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('PhoneNumber');
    return stringValue;
  }
 setrefferalcode(String stringValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('Refferalcode', stringValue);
    return true;
  }

  getrefferalcode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('Refferalcode');
    return stringValue;
  }
  settoken(String stringValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('TokenNumber', stringValue);
    return true;
  }

  gettoken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('TokenNumber');
    return stringValue;
  }

  //dnd
  setDnd(String stringValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('dnd', stringValue);
    return true;
  }

  getDnd() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('dnd');
    return stringValue;
  }

  setplanid(String stringValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('c_Plan', stringValue);
    return true;
  }

  getplanid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('c_Plan');
    return stringValue;
  }

  setsubscriptionId(String stringValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('c_SubscriptionId', stringValue);
    return true;
  }

  getsubscriptionId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('c_SubscriptionId');
    return stringValue;
  }

  //mail
  setUserEmail(String stringValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', stringValue);
    return true;
  }

  getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('email');
    return stringValue;
  }

  setUserMobile(String stringValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userMobile', stringValue);
    return true;
  }

  getUserMobile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('userMobile');
    return stringValue;
  }

  setNStatus(String stringValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('n_status', stringValue);
    return true;
  }

  getNStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('n_status');
    return stringValue;
  }

  setKycStatus(String stringValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('kyc_status', stringValue);
    return true;
  }

  getKycStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('kyc_status');
    return stringValue;
  }

  clearSharep() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
