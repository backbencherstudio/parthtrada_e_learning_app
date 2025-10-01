class MessageModel {
  bool? success;
  String? message;
  List<Data>? data;
  Pagination? pagination;

  MessageModel({this.success, this.message, this.data, this.pagination});

  MessageModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? conversationId;
  String? senderId;
  String? recipientId;
  String? senderRole;
  String? recipientRole;
  String? content;
  bool? readMessage;
  String? createdAt;
  Sender? sender;
  Sender? recipient;
  bool? me;

  Data(
      {this.id,
        this.conversationId,
        this.senderId,
        this.recipientId,
        this.senderRole,
        this.recipientRole,
        this.content,
        this.readMessage,
        this.createdAt,
        this.sender,
        this.recipient,
        this.me});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    conversationId = json['conversationId'];
    senderId = json['senderId'];
    recipientId = json['recipientId'];
    senderRole = json['senderRole'];
    recipientRole = json['recipientRole'];
    content = json['content'];
    readMessage = json['read_message'];
    createdAt = json['createdAt'];
    sender =
    json['sender'] != null ? new Sender.fromJson(json['sender']) : null;
    recipient = json['recipient'] != null
        ? new Sender.fromJson(json['recipient'])
        : null;
    me = json['me'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['conversationId'] = this.conversationId;
    data['senderId'] = this.senderId;
    data['recipientId'] = this.recipientId;
    data['senderRole'] = this.senderRole;
    data['recipientRole'] = this.recipientRole;
    data['content'] = this.content;
    data['read_message'] = this.readMessage;
    data['createdAt'] = this.createdAt;
    if (this.sender != null) {
      data['sender'] = this.sender!.toJson();
    }
    if (this.recipient != null) {
      data['recipient'] = this.recipient!.toJson();
    }
    data['me'] = this.me;
    return data;
  }
}

class Sender {
  String? id;
  String? name;
  Null? image;

  Sender({this.id, this.name, this.image});

  Sender.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class Pagination {
  int? page;
  int? perPage;
  int? totalPages;
  bool? hasNextPage;
  bool? hasPrevPage;

  Pagination(
      {this.page,
        this.perPage,
        this.totalPages,
        this.hasNextPage,
        this.hasPrevPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['perPage'];
    totalPages = json['totalPages'];
    hasNextPage = json['hasNextPage'];
    hasPrevPage = json['hasPrevPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['perPage'] = this.perPage;
    data['totalPages'] = this.totalPages;
    data['hasNextPage'] = this.hasNextPage;
    data['hasPrevPage'] = this.hasPrevPage;
    return data;
  }
}
