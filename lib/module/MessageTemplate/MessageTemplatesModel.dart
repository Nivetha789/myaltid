class MessageTemplatesModel {
  int? status;
  List<String>? message;
  List<MessageTemplatesData>? data;

  MessageTemplatesModel({this.status, this.message, this.data});

  MessageTemplatesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'].cast<String>();
    if (json['data'] != null) {
      data = <MessageTemplatesData>[];
      json['data'].forEach((v) {
        data!.add(new MessageTemplatesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MessageTemplatesData {
  String? sId;
  String? cMessage;

  MessageTemplatesData({this.sId, this.cMessage});

  MessageTemplatesData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    cMessage = json['c_Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['c_Message'] = this.cMessage;
    return data;
  }
}