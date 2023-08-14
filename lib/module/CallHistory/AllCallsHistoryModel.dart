class AllCallHistoryModel {
  int? status;
  String? message;
  AllCallHistoryData? data;
  List<String>? error;

  AllCallHistoryModel({this.status, this.message, this.data, this.error});

  AllCallHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new AllCallHistoryData.fromJson(json['data']) : null;
    if (json['error'] != null) {
      error = <String>[];
      json['error'].forEach((v) {
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.error != null) {
    }
    return data;
  }
}

class AllCallHistoryData {
  int? total;
  int? limit;
  int? offset;
  List<AllCallHistoryDocs>? docs;

  AllCallHistoryData({this.total, this.limit, this.offset, this.docs});

  AllCallHistoryData.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['docs'] != null) {
      docs = <AllCallHistoryDocs>[];
      json['docs'].forEach((v) {
        docs!.add(new AllCallHistoryDocs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    if (this.docs != null) {
      data['docs'] = this.docs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllCallHistoryDocs {
  String? cStatus;
  String? regNumber;
  String? callStatus;
  String? totalDuration;
  String? receivedAt;

  AllCallHistoryDocs(
      {this.cStatus,
        this.regNumber,
        this.callStatus,
        this.totalDuration,
        this.receivedAt});

  AllCallHistoryDocs.fromJson(Map<String, dynamic> json) {
    cStatus = json['c_status'];
    regNumber = json['reg_number'];
    callStatus = json['call_status'];
    totalDuration = json['total_duration'];
    receivedAt = json['received_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['c_status'] = this.cStatus;
    data['reg_number'] = this.regNumber;
    data['call_status'] = this.callStatus;
    data['total_duration'] = this.totalDuration;
    data['received_at'] = this.receivedAt;
    return data;
  }
}