// ignore_for_file: constant_identifier_names

class ApiProvider {
  static const String BASE_URL = "http://13.59.194.102:3003/api/v1/";

  static const String sendotp = "${BASE_URL}users/checkUser";

  static const String verifyotp = "${BASE_URL}users/verifyOtp";

  static const String resendotp = "${BASE_URL}users/resendOtp";

  static const String getplans = "${BASE_URL}plans/get";

  static const String userregister = "${BASE_URL}users/register";

  static const String updatekyc = "${BASE_URL}users/updateKyc";
}
