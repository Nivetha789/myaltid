class SendEmailListModel {
  List<SendEmailListContent>? content;
  Pageable? pageable;
  int? totalPages;
  int? totalElements;
  bool? last;
  int? size;
  int? number;
  Sort? sort;
  bool? first;
  int? numberOfElements;
  bool? empty;

  SendEmailListModel(
      {this.content,
        this.pageable,
        this.totalPages,
        this.totalElements,
        this.last,
        this.size,
        this.number,
        this.sort,
        this.first,
        this.numberOfElements,
        this.empty});

  SendEmailListModel.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <SendEmailListContent>[];
      json['content'].forEach((v) {
        content!.add(new SendEmailListContent.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    last = json['last'];
    size = json['size'];
    number = json['number'];
    sort = json['sort'] != null ? new Sort.fromJson(json['sort']) : null;
    first = json['first'];
    numberOfElements = json['numberOfElements'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    data['totalPages'] = this.totalPages;
    data['totalElements'] = this.totalElements;
    data['last'] = this.last;
    data['size'] = this.size;
    data['number'] = this.number;
    if (this.sort != null) {
      data['sort'] = this.sort!.toJson();
    }
    data['first'] = this.first;
    data['numberOfElements'] = this.numberOfElements;
    data['empty'] = this.empty;
    return data;
  }
}

class SendEmailListContent {
  String? id;
  String? from;
  String? subject;
  String? userId;
  String? inboxId;
  List<String>? attachments;
  String? createdAt;
  List<String>? to;
  List<String>? bcc;
  List<String>? cc;
  String? bodyMD5Hash;
  bool? virtualSend;

  SendEmailListContent(
      {this.id,
        this.from,
        this.subject,
        this.userId,
        this.inboxId,
        this.attachments,
        this.createdAt,
        this.to,
        this.bcc,
        this.cc,
        this.bodyMD5Hash,
        this.virtualSend});

  SendEmailListContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    from = json['from'];
    subject = json['subject'];
    userId = json['userId'];
    inboxId = json['inboxId'];
    if (json['attachments'] != null) {
      attachments = <String>[];
      json['attachments'].forEach((v) {
      });
    }
    createdAt = json['createdAt'];
    to = json['to'].cast<String>();
    if (json['bcc'] != null) {
      bcc = <String>[];
      json['bcc'].forEach((v) {
      });
    }
    if (json['cc'] != null) {
      cc = <String>[];
      json['cc'].forEach((v) {
      });
    }
    bodyMD5Hash = json['bodyMD5Hash'];
    virtualSend = json['virtualSend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['from'] = this.from;
    data['subject'] = this.subject;
    data['userId'] = this.userId;
    data['inboxId'] = this.inboxId;
    if (this.attachments != null) {
    }
    data['createdAt'] = this.createdAt;
    data['to'] = this.to;
    if (this.bcc != null) {
    }
    if (this.cc != null) {
    }
    data['bodyMD5Hash'] = this.bodyMD5Hash;
    data['virtualSend'] = this.virtualSend;
    return data;
  }
}

class Pageable {
  int? pageNumber;
  int? pageSize;
  Sort? sort;
  int? offset;
  bool? paged;
  bool? unpaged;

  Pageable(
      {this.pageNumber,
        this.pageSize,
        this.sort,
        this.offset,
        this.paged,
        this.unpaged});

  Pageable.fromJson(Map<String, dynamic> json) {
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    sort = json['sort'] != null ? new Sort.fromJson(json['sort']) : null;
    offset = json['offset'];
    paged = json['paged'];
    unpaged = json['unpaged'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    if (this.sort != null) {
      data['sort'] = this.sort!.toJson();
    }
    data['offset'] = this.offset;
    data['paged'] = this.paged;
    data['unpaged'] = this.unpaged;
    return data;
  }
}

class Sort {
  bool? empty;
  bool? sorted;
  bool? unsorted;

  Sort({this.empty, this.sorted, this.unsorted});

  Sort.fromJson(Map<String, dynamic> json) {
    empty = json['empty'];
    sorted = json['sorted'];
    unsorted = json['unsorted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['empty'] = this.empty;
    data['sorted'] = this.sorted;
    data['unsorted'] = this.unsorted;
    return data;
  }
}