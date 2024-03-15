class GetInboxModel {
  List<GetInboxContent>? content;
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

  GetInboxModel(
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

  GetInboxModel.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <GetInboxContent>[];
      json['content'].forEach((v) {
        content!.add(new GetInboxContent.fromJson(v));
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

class GetInboxContent {
  String? id;
  String? from;
  String? subject;
  String? inboxId;
  List<String>? attachments;
  String? createdAt;
  List<String>? to;
  String? domainId;
  List<String>? bcc;
  List<String>? cc;
  bool? read;
  String? bodyExcerpt;
  bool? teamAccess;
  String? bodyMD5Hash;
  String? textExcerpt;

  GetInboxContent(
      {this.id,
        this.from,
        this.subject,
        this.inboxId,
        this.attachments,
        this.createdAt,
        this.to,
        this.domainId,
        this.bcc,
        this.cc,
        this.read,
        this.bodyExcerpt,
        this.teamAccess,
        this.bodyMD5Hash,
        this.textExcerpt});

  GetInboxContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    from = json['from'];
    subject = json['subject'];
    inboxId = json['inboxId'];
    if (json['attachments'] != null) {
      attachments = <String>[];
      json['attachments'].forEach((v) {
      });
    }
    createdAt = json['createdAt'];
    to = json['to'].cast<String>();
    domainId = json['domainId'];
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
    read = json['read'];
    bodyExcerpt = json['bodyExcerpt'];
    teamAccess = json['teamAccess'];
    bodyMD5Hash = json['bodyMD5Hash'];
    textExcerpt = json['textExcerpt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['from'] = this.from;
    data['subject'] = this.subject;
    data['inboxId'] = this.inboxId;
    if (this.attachments != null) {
    }
    data['createdAt'] = this.createdAt;
    data['to'] = this.to;
    data['domainId'] = this.domainId;
    if (this.bcc != null) {
    }
    if (this.cc != null) {
    }
    data['read'] = this.read;
    data['bodyExcerpt'] = this.bodyExcerpt;
    data['teamAccess'] = this.teamAccess;
    data['bodyMD5Hash'] = this.bodyMD5Hash;
    data['textExcerpt'] = this.textExcerpt;
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
  bool? unsorted;
  bool? sorted;

  Sort({this.empty, this.unsorted, this.sorted});

  Sort.fromJson(Map<String, dynamic> json) {
    empty = json['empty'];
    unsorted = json['unsorted'];
    sorted = json['sorted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['empty'] = this.empty;
    data['unsorted'] = this.unsorted;
    data['sorted'] = this.sorted;
    return data;
  }
}