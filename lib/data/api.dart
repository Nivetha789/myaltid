// ignore_for_file: constant_identifier_names

class ApiProvider {
  static const String BASE_URL = "http://13.59.194.102:3003/api/v1/";
  static const String BASE_URL_MAIL = "https://api.mailslurp.com/";

  static const String checkuser = "${BASE_URL}users/checkUser";

  static const String sendotp = "${BASE_URL}users/sendOtp";

  static const String verifyotp = "${BASE_URL}users/verifyOtp";

  static const String resendotp = "${BASE_URL}users/resendOtp";

  static const String checkrefferalcode = "${BASE_URL}users/checkReferral";

  static const String getplans = "${BASE_URL}plans/get";

  static const String userregister = "${BASE_URL}users/register";

  static const String getvirutalid = "${BASE_URL}subscription/getVirtualId";

  static const String updatevirutalid = "${BASE_URL}users/updateVirtulId";

  static const String updatekyc = "${BASE_URL}users/updateKyc";

  static const String verifykyc = "${BASE_URL}users/verifyAadhar";

  static const String getuser = "${BASE_URL}users/profile";

  static const String getdatautlize = "${BASE_URL}subscription/userplanget";

  static const String getpaymentdetails = "${BASE_URL}subscription/PaymentDetails";

  static const String updatepaymentdetails = "${BASE_URL}subscription/verify";

  static const String dialnumber = "${BASE_URL}call/MakeCall";

  static const String allCalls = "${BASE_URL}call/history";

  static const String updateDND = "${BASE_URL}users/updatePreference";

  //static const String messageTemplate = "${BASE_URL}message/Templates";

  static const String messageTemplate = "${BASE_URL}sms/tempalte";

  static const String sendMessage = "${BASE_URL}sms/sendSms";

  static const String incomeSms = "${BASE_URL}sms/incomSms";

  static const String addsubscrptiondetils =
      "${BASE_URL}subcription/subscriptionbuy";

  static const String getSignzyUrl =
      "${BASE_URL}signzy/getDigiUrl";

  static const String faceRegApi =
      "${BASE_URL}signzy/faceReconization";

  static const String uploadPhoto =
      "${BASE_URL}signzy/newUpload";

  static const String sendMail =
      "${BASE_URL_MAIL}sendEmail";
}
