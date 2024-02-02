class PhoneDialerModel {
  int? status;
  String? message;
  PhoneDialerData? data;
  List<String>? error;

  PhoneDialerModel({this.status, this.message, this.data, this.error});

  PhoneDialerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new PhoneDialerData.fromJson(json['data']) : null;
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

class PhoneDialerData {
  int? nStatus;
  int? cActionId;
  int? nCallerPhysicalSMno;
  String? cCallerId;
  int? cCallerDnd;
  int? nCallerVirtualVMno;
  int? nCallerSubscription;
  int? cCallerDuration;
  int? nUseCase;
  int? nIsExired;
  int? nCalleePhysical;
  String? cCalleeId;
  int? nCalleeVirtual;
  int? nCalleeSubscription;
  int? cCalleeDuration;

  PhoneDialerData(
      {this.nStatus,
        this.cActionId,
        this.nCallerPhysicalSMno,
        this.cCallerId,
        this.cCallerDnd,
        this.nCallerVirtualVMno,
        this.nCallerSubscription,
        this.cCallerDuration,
        this.nUseCase,
        this.nIsExired,
        this.nCalleePhysical,
        this.cCalleeId,
        this.nCalleeVirtual,
        this.nCalleeSubscription,
        this.cCalleeDuration});

  PhoneDialerData.fromJson(Map<String, dynamic> json) {
    nStatus = json['n_Status'];
    cActionId = json['c_ActionId'];
    nCallerPhysicalSMno = json['n_CallerPhysical_s_mno'];
    cCallerId = json['c_CallerId'];
    cCallerDnd = json['c_CallerDnd'];
    nCallerVirtualVMno = json['n_CallerVirtual_v_mno'];
    nCallerSubscription = json['n_CallerSubscription'];
    cCallerDuration = json['c_CallerDuration'];
    nUseCase = json['n_UseCase'];
    nIsExired = json['n_IsExired'];
    nCalleePhysical = json['n_CalleePhysical'];
    cCalleeId = json['c_CalleeId'];
    nCalleeVirtual = json['n_CalleeVirtual'];
    nCalleeSubscription = json['n_CalleeSubscription'];
    cCalleeDuration = json['c_CalleeDuration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['n_Status'] = this.nStatus;
    data['c_ActionId'] = this.cActionId;
    data['n_CallerPhysical_s_mno'] = this.nCallerPhysicalSMno;
    data['c_CallerId'] = this.cCallerId;
    data['c_CallerDnd'] = this.cCallerDnd;
    data['n_CallerVirtual_v_mno'] = this.nCallerVirtualVMno;
    data['n_CallerSubscription'] = this.nCallerSubscription;
    data['c_CallerDuration'] = this.cCallerDuration;
    data['n_UseCase'] = this.nUseCase;
    data['n_IsExired'] = this.nIsExired;
    data['n_CalleePhysical'] = this.nCalleePhysical;
    data['c_CalleeId'] = this.cCalleeId;
    data['n_CalleeVirtual'] = this.nCalleeVirtual;
    data['n_CalleeSubscription'] = this.nCalleeSubscription;
    data['c_CalleeDuration'] = this.cCalleeDuration;
    return data;
  }
}