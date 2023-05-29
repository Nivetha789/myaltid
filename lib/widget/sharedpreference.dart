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

  clearSharep() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
