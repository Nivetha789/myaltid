class UpdateDndPreferenceModel {
  int? status;
  String? message;
  List<UpdateDndPreferenceData>? data;
  List<String>? error;

  UpdateDndPreferenceModel({this.status, this.message, this.data, this.error});

  UpdateDndPreferenceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UpdateDndPreferenceData>[];
      json['data'].forEach((v) {
        data!.add(new UpdateDndPreferenceData.fromJson(v));
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

class UpdateDndPreferenceData {
  int? nKyc;
  int? nStatus;
  int? nMobile;
  String? cName;
  String? cVirtualEmail;
  int? nSubscriptionStatus;
  int? nVirtualNumber;
  int? nBiometric;
  int? nCallActiveMode;
  int? nCallAddressBook;
  int? nDnd;
  int? nSmsAddressBook;
  int? nSmsPeople;

  UpdateDndPreferenceData(
      {this.nKyc,
        this.nStatus,
        this.nMobile,
        this.cName,
        this.cVirtualEmail,
        this.nSubscriptionStatus,
        this.nVirtualNumber,
        this.nBiometric,
        this.nCallActiveMode,
        this.nCallAddressBook,
        this.nDnd,
        this.nSmsAddressBook,
        this.nSmsPeople});

  UpdateDndPreferenceData.fromJson(Map<String, dynamic> json) {
    nKyc = json['n_Kyc'];
    nStatus = json['n_Status'];
    nMobile = json['n_Mobile'];
    cName = json['c_Name'];
    cVirtualEmail = json['c_VirtualEmail'];
    nSubscriptionStatus = json['n_SubscriptionStatus'];
    nVirtualNumber = json['n_VirtualNumber'];
    nBiometric = json['n_Biometric'];
    nCallActiveMode = json['n_CallActiveMode'];
    nCallAddressBook = json['n_CallAddressBook'];
    nDnd = json['n_Dnd'];
    nSmsAddressBook = json['n_SmsAddressBook'];
    nSmsPeople = json['n_SmsPeople'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['n_Kyc'] = this.nKyc;
    data['n_Status'] = this.nStatus;
    data['n_Mobile'] = this.nMobile;
    data['c_Name'] = this.cName;
    data['c_VirtualEmail'] = this.cVirtualEmail;
    data['n_SubscriptionStatus'] = this.nSubscriptionStatus;
    data['n_VirtualNumber'] = this.nVirtualNumber;
    data['n_Biometric'] = this.nBiometric;
    data['n_CallActiveMode'] = this.nCallActiveMode;
    data['n_CallAddressBook'] = this.nCallAddressBook;
    data['n_Dnd'] = this.nDnd;
    data['n_SmsAddressBook'] = this.nSmsAddressBook;
    data['n_SmsPeople'] = this.nSmsPeople;
    return data;
  }
}