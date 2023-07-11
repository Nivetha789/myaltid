class TransactionVerifyModel {
  int? status;
  List<String>? message;
  List<String>? data;
  List<String>? error;

  TransactionVerifyModel({this.status, this.message, this.data, this.error});

  TransactionVerifyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'].cast<String>();
    if (json['data'] != null) {
      data = <String>[];
      json['data'].forEach((v) {});
    }
    if (json['error'] != null) {
      error = <String>[];
      json['error'].forEach((v) {});
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {}
    if (this.error != null) {}
    return data;
  }
}
