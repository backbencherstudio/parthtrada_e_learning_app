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
        data!.add(Data.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
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

  Data({
    this.id,
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
    this.me,
  });

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
    sender = json['sender'] != null ? Sender.fromJson(json['sender']) : null;
    recipient = json['recipient'] != null ? Sender.fromJson(json['recipient']) : null;
    me = json['me'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['conversationId'] = conversationId;
    data['senderId'] = senderId;
    data['recipientId'] = recipientId;
    data['senderRole'] = senderRole;
    data['recipientRole'] = recipientRole;
    data['content'] = content;
    data['read_message'] = readMessage;
    data['createdAt'] = createdAt;
    if (sender != null) {
      data['sender'] = sender!.toJson();
    }
    if (recipient != null) {
      data['recipient'] = recipient!.toJson();
    }
    data['me'] = me;
    return data;
  }
}

class Sender {
  String? id;
  String? name;
  String? image; // Changed from Null? to String? to handle image URL/path properly

  Sender({this.id, this.name, this.image});

  Sender.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}

class Pagination {
  int? page;
  int? perPage;
  int? totalPages;
  bool? hasNextPage;
  bool? hasPrevPage;

  Pagination({
    this.page,
    this.perPage,
    this.totalPages,
    this.hasNextPage,
    this.hasPrevPage,
  });

  Pagination.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['perPage'];
    totalPages = json['totalPages'];
    hasNextPage = json['hasNextPage'];
    hasPrevPage = json['hasPrevPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['perPage'] = perPage;
    data['totalPages'] = totalPages;
    data['hasNextPage'] = hasNextPage;
    data['hasPrevPage'] = hasPrevPage;
    return data;
  }
}