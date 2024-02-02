class GetSignzyUrlModel {
  int? status;
  String? message;
  List<GetSignzyUrlData>? data;
  String? error;

  GetSignzyUrlModel({this.status, this.message, this.data, this.error});

  GetSignzyUrlModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetSignzyUrlData>[];
      json['data'].forEach((v) {
        data!.add(new GetSignzyUrlData.fromJson(v));
      });
    }
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    return data;
  }
}

class GetSignzyUrlData {
  String? requestId;
  String? redirectUrl;

  GetSignzyUrlData({this.requestId, this.redirectUrl});

  GetSignzyUrlData.fromJson(Map<String, dynamic> json) {
    requestId = json['request_id'];
    redirectUrl = json['redirect_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['request_id'] = this.requestId;
    data['redirect_url'] = this.redirectUrl;
    return data;
  }
}