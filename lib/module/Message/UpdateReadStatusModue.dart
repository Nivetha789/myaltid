class UpdateReadStatusModel {
  int? status;
  String? message;
  String? error;

  UpdateReadStatusModel({this.status, this.message,this.error});

  UpdateReadStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['error'] = this.error;
    return data;
  }
}