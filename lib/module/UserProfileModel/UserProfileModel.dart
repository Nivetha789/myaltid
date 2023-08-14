class UserProfileModel {
  int? status;
  List<String>? message;
  UserProfileData? data;
  List<String>? error;

  UserProfileModel({this.status, this.message, this.data, this.error});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'].cast<String>();
    data = json['data'] != null ? new UserProfileData.fromJson(json['data']) : null;
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

class UserProfileData {
  String? cUserName;
  int? nStatus;
  int? nMobile;
  int? nBiometric;
  int? cVirtualMobile;
  String? cVirtualEmail;
  int? nSubscriptionDuration;
  int? nSubscriptionPrice;
  int? nCallActiveMode;
  int? nCallAddressBook;
  int? nDnd;
  int? nSmsAddressBook;
  int? nSmsPeople;

  UserProfileData(
      {this.cUserName,
        this.nStatus,
        this.nMobile,
        this.nBiometric,
        this.cVirtualMobile,
        this.cVirtualEmail,
        this.nSubscriptionDuration,
        this.nSubscriptionPrice,
        this.nCallActiveMode,
        this.nCallAddressBook,
        this.nDnd,
        this.nSmsAddressBook,
        this.nSmsPeople});

  UserProfileData.fromJson(Map<String, dynamic> json) {
    cUserName = json['c_UserName'];
    nStatus = json['n_Status'];
    nMobile = json['n_Mobile'];
    nBiometric = json['n_Biometric'];
    cVirtualMobile = json['c_VirtualMobile'];
    cVirtualEmail = json['c_virtualEmail'];
    nSubscriptionDuration = json['n_SubscriptionDuration'];
    nSubscriptionPrice = json['n_SubscriptionPrice'];
    nCallActiveMode = json['n_CallActiveMode'];
    nCallAddressBook = json['n_CallAddressBook'];
    nDnd = json['n_Dnd'];
    nSmsAddressBook = json['n_SmsAddressBook'];
    nSmsPeople = json['n_SmsPeople'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['c_UserName'] = this.cUserName;
    data['n_Status'] = this.nStatus;
    data['n_Mobile'] = this.nMobile;
    data['n_Biometric'] = this.nBiometric;
    data['c_VirtualMobile'] = this.cVirtualMobile;
    data['c_virtualEmail'] = this.cVirtualEmail;
    data['n_SubscriptionDuration'] = this.nSubscriptionDuration;
    data['n_SubscriptionPrice'] = this.nSubscriptionPrice;
    data['n_CallActiveMode'] = this.nCallActiveMode;
    data['n_CallAddressBook'] = this.nCallAddressBook;
    data['n_Dnd'] = this.nDnd;
    data['n_SmsAddressBook'] = this.nSmsAddressBook;
    data['n_SmsPeople'] = this.nSmsPeople;
    return data;
  }
}