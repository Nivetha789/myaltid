class PaymentDetailsModel {
  int? status;
  List<String>? message;
  List<PaymentDetailsData>? data;
  List<String>? error;

  PaymentDetailsModel({this.status, this.message, this.data, this.error});

  PaymentDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['message'] != null) {
      message = <String>[];
      json['message'].forEach((v) {
      });
    }
    if (json['data'] != null) {
      data = <PaymentDetailsData>[];
      json['data'].forEach((v) {
        data!.add(new PaymentDetailsData.fromJson(v));
      });
    }
    if (json['error'] != null) {
      error = <String>[];
      json['error'].forEach((v) {
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.message != null) {
    }
    if (this.data != null) {
    }
    if (this.error != null) {
    }
    return data;
  }
}

class PaymentDetailsData {
  String? cName;
  String? cEmail;
  String? nMobileNumber;
  int? nAmount;
  String? nTransactionId;
  String? cUserId;
  String? cMerchantId;
  String? cHash;
  String? cPrimaryColorCode;
  String? cSecondaryColorCode;
  String? cButtonColorCode1;
  String? cButtonColorCode2;

  PaymentDetailsData(
      {this.cName,
        this.cEmail,
        this.nMobileNumber,
        this.nAmount,
        this.nTransactionId,
        this.cUserId,
        this.cMerchantId,
        this.cHash,
        this.cPrimaryColorCode,
        this.cSecondaryColorCode,
        this.cButtonColorCode1,
        this.cButtonColorCode2});

  PaymentDetailsData.fromJson(Map<String, dynamic> json) {
    cName = json['c_Name'];
    cEmail = json['c_Email'];
    nMobileNumber = json['n_MobileNumber'];
    nAmount = json['n_Amount'];
    nTransactionId = json['n_TransactionId'];
    cUserId = json['c_UserId'];
    cMerchantId = json['c_MerchantId'];
    cHash = json['c_Hash'];
    cPrimaryColorCode = json['c_PrimaryColorCode'];
    cSecondaryColorCode = json['c_SecondaryColorCode'];
    cButtonColorCode1 = json['c_ButtonColorCode1'];
    cButtonColorCode2 = json['c_ButtonColorCode2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['c_Name'] = this.cName;
    data['c_Email'] = this.cEmail;
    data['n_MobileNumber'] = this.nMobileNumber;
    data['n_Amount'] = this.nAmount;
    data['n_TransactionId'] = this.nTransactionId;
    data['c_UserId'] = this.cUserId;
    data['c_MerchantId'] = this.cMerchantId;
    data['c_Hash'] = this.cHash;
    data['c_PrimaryColorCode'] = this.cPrimaryColorCode;
    data['c_SecondaryColorCode'] = this.cSecondaryColorCode;
    data['c_ButtonColorCode1'] = this.cButtonColorCode1;
    data['c_ButtonColorCode2'] = this.cButtonColorCode2;
    return data;
  }
}