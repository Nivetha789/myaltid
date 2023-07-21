class PhoneDialerModel {
  int? status;
  String? message;
  List<PhoneDialerData>? data;
  List<String>? error;

  PhoneDialerModel({this.status, this.message, this.data, this.error});

  PhoneDialerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PhoneDialerData>[];
      json['data'].forEach((v) {
        data!.add(new PhoneDialerData.fromJson(v));
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
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.error != null) {
    }
    return data;
  }
}

class PhoneDialerData {
  int? nCallerId;
  int? nStatus;
  int? nCallerPhysical;
  int? nCallerVirtual;
  String? cCallerId;
  int? nCallerSubscription;
  int? cCallerDuration;
  int? nCalleePhysical;
  int? nCalleeVirtual;
  String? cCalleeId;
  int? nCalleeSubscription;
  int? cCalleeDuration;
  String? dtCreatedOn;
  int? nCallee;

  PhoneDialerData(
      {this.nCallerId,
        this.nStatus,
        this.nCallerPhysical,
        this.nCallerVirtual,
        this.cCallerId,
        this.nCallerSubscription,
        this.cCallerDuration,
        this.nCalleePhysical,
        this.nCalleeVirtual,
        this.cCalleeId,
        this.nCalleeSubscription,
        this.cCalleeDuration,
        this.dtCreatedOn,
        this.nCallee});

  PhoneDialerData.fromJson(Map<String, dynamic> json) {
    nCallerId = json['n_CallerId'];
    nStatus = json['n_Status'];
    nCallerPhysical = json['n_CallerPhysical'];
    nCallerVirtual = json['n_CallerVirtual'];
    cCallerId = json['c_CallerId'];
    nCallerSubscription = json['n_CallerSubscription'];
    cCallerDuration = json['c_CallerDuration'];
    nCalleePhysical = json['n_CalleePhysical'];
    nCalleeVirtual = json['n_CalleeVirtual'];
    cCalleeId = json['c_CalleeId'];
    nCalleeSubscription = json['n_CalleeSubscription'];
    cCalleeDuration = json['c_CalleeDuration'];
    dtCreatedOn = json['dt_CreatedOn'];
    nCallee = json['n_Callee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['n_CallerId'] = this.nCallerId;
    data['n_Status'] = this.nStatus;
    data['n_CallerPhysical'] = this.nCallerPhysical;
    data['n_CallerVirtual'] = this.nCallerVirtual;
    data['c_CallerId'] = this.cCallerId;
    data['n_CallerSubscription'] = this.nCallerSubscription;
    data['c_CallerDuration'] = this.cCallerDuration;
    data['n_CalleePhysical'] = this.nCalleePhysical;
    data['n_CalleeVirtual'] = this.nCalleeVirtual;
    data['c_CalleeId'] = this.cCalleeId;
    data['n_CalleeSubscription'] = this.nCalleeSubscription;
    data['c_CalleeDuration'] = this.cCalleeDuration;
    data['dt_CreatedOn'] = this.dtCreatedOn;
    data['n_Callee'] = this.nCallee;
    return data;
  }
}