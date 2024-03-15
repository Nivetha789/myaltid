class CreateEmailModel {
  String? id;
  String? userId;
  String? created;
  String? createdAt;
  String? name;
  String? domainId;
  String? description;
  String? emailAddress;
  String? expiresAt;
  bool? favourite;
  String? tags;
  bool? teamAccess;
  String? inboxType;
  bool? readOnly;
  bool? virtualInbox;
  String? functionsAs;

  CreateEmailModel(
      {this.id,
        this.userId,
        this.created,
        this.createdAt,
        this.name,
        this.domainId,
        this.description,
        this.emailAddress,
        this.expiresAt,
        this.favourite,
        this.tags,
        this.teamAccess,
        this.inboxType,
        this.readOnly,
        this.virtualInbox,
        this.functionsAs});

  CreateEmailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    created = json['created'];
    createdAt = json['createdAt'];
    name = json['name'];
    domainId = json['domainId'];
    description = json['description'];
    emailAddress = json['emailAddress'];
    expiresAt = json['expiresAt'];
    favourite = json['favourite'];
    tags = json['tags'];
    teamAccess = json['teamAccess'];
    inboxType = json['inboxType'];
    readOnly = json['readOnly'];
    virtualInbox = json['virtualInbox'];
    functionsAs = json['functionsAs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['created'] = this.created;
    data['createdAt'] = this.createdAt;
    data['name'] = this.name;
    data['domainId'] = this.domainId;
    data['description'] = this.description;
    data['emailAddress'] = this.emailAddress;
    data['expiresAt'] = this.expiresAt;
    data['favourite'] = this.favourite;
    data['tags'] = this.tags;
    data['teamAccess'] = this.teamAccess;
    data['inboxType'] = this.inboxType;
    data['readOnly'] = this.readOnly;
    data['virtualInbox'] = this.virtualInbox;
    data['functionsAs'] = this.functionsAs;
    return data;
  }
}