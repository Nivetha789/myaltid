class IncomeSmsListModel {
  int? status;
  String? message;
  List<IncomeSmsListData>? data;
  String? error;

  IncomeSmsListModel({this.status, this.message, this.data, this.error});

  IncomeSmsListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <IncomeSmsListData>[];
      json['data'].forEach((v) {
        data!.add(new IncomeSmsListData.fromJson(v));
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

class IncomeSmsListData {
  String? cId;
  String? cReciverName;
  String? cSenderName;
  int? nFromNumber;
  int? nToNumber;
  int? nStatus;
  int? nType;
  String? cMessage;
  String? dtDateTime;
  String? dtSendTime;

  IncomeSmsListData(
      {this.cId,
        this.cReciverName,
        this.cSenderName,
        this.nFromNumber,
        this.nToNumber,
        this.nStatus,
        this.nType,
        this.cMessage,
        this.dtDateTime,
        this.dtSendTime});

  IncomeSmsListData.fromJson(Map<String, dynamic> json) {
    cId = json['c_id'];
    cReciverName = json['c_reciver_name'];
    cSenderName = json['c_sender_name'];
    nFromNumber = json['n_FromNumber'];
    nToNumber = json['n_ToNumber'];
    nStatus = json['n_Status'];
    nType = json['n_type'];
    cMessage = json['c_Message'];
    dtDateTime = json['dt_DateTime'];
    dtSendTime = json['dt_Send_Time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['c_id'] = this.cId;
    data['c_reciver_name'] = this.cReciverName;
    data['c_sender_name'] = this.cSenderName;
    data['n_FromNumber'] = this.nFromNumber;
    data['n_ToNumber'] = this.nToNumber;
    data['n_Status'] = this.nStatus;
    data['n_type'] = this.nType;
    data['c_Message'] = this.cMessage;
    data['dt_DateTime'] = this.dtDateTime;
    data['dt_Send_Time'] = this.dtSendTime;
    return data;
  }
}