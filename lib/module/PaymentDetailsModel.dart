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
  String? nMobileNumber;
  int? nAmount;
  String? nTransactionId;
  String? cUserId;
  String? cHash;

  PaymentDetailsData(
      {this.cName,
        this.nMobileNumber,
        this.nAmount,
        this.nTransactionId,
        this.cUserId,
        this.cHash,});

  PaymentDetailsData.fromJson(Map<String, dynamic> json) {
    cName = json['c_Name'];
    nMobileNumber = json['n_MobileNumber'];
    nAmount = json['n_Amount'];
    nTransactionId = json['n_TransactionId'];
    cUserId = json['c_UserId'];
    cHash = json['c_Hash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['c_Name'] = this.cName;
    data['n_MobileNumber'] = this.nMobileNumber;
    data['n_Amount'] = this.nAmount;
    data['n_TransactionId'] = this.nTransactionId;
    data['c_UserId'] = this.cUserId;
    data['c_Hash'] = this.cHash;
    return data;
  }
}