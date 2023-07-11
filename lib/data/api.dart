// ignore_for_file: constant_identifier_names

class ApiProvider {
  static const String BASE_URL = "http://13.59.194.102:3003/api/v1/";

  static const String checkuser = "${BASE_URL}users/checkUser";

  static const String sendotp = "${BASE_URL}users/sendOtp";

  static const String verifyotp = "${BASE_URL}users/verifyOtp";

  static const String resendotp = "${BASE_URL}users/resendOtp";

  static const String checkrefferalcode = "${BASE_URL}users/checkReferral";

  static const String getplans = "${BASE_URL}plans/get";

  static const String userregister = "${BASE_URL}users/register";

  static const String getvirutalid = "${BASE_URL}subcription/getVirtualId";

  static const String updatevirutalid = "${BASE_URL}users/updateVirtulId";

  static const String updatekyc = "${BASE_URL}users/updateKyc";

  static const String verifykyc = "${BASE_URL}users/verifyAadhar";

  static const String getuser = "${BASE_URL}users/profile";

  static const String getdatautlize = "${BASE_URL}subcription/userplanget";

  static const String getpaymentdetails = "${BASE_URL}subscription/PaymentDetails";

  static const String updatepaymentdetails = "${BASE_URL}subscription/verify";

  static const String addsubscrptiondetils =
      "${BASE_URL}subcription/subscriptionbuy";
}
