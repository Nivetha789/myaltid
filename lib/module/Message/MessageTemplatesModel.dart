class MessageTemplatesModel {
  int? status;
  String? message;
  List<MessageTemplatesData>? data;
  String? error;

  MessageTemplatesModel({this.status, this.message, this.data, this.error});

  MessageTemplatesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MessageTemplatesData>[];
      json['data'].forEach((v) {
        data!.add(new MessageTemplatesData.fromJson(v));
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

class MessageTemplatesData {
  String? templateId;
  String? templateName;
  String? message;

  MessageTemplatesData({this.templateId, this.templateName, this.message});

  MessageTemplatesData.fromJson(Map<String, dynamic> json) {
    templateId = json['Template_id'];
    templateName = json['templateName'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Template_id'] = this.templateId;
    data['templateName'] = this.templateName;
    data['message'] = this.message;
    return data;
  }
}