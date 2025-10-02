class ConversationModel {
  bool? success;
  String? message;
  List<Data>? data;

  ConversationModel({this.success, this.message, this.data});

  ConversationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? senderId;
  String? recipientId;
  String? senderRole;
  String? recipientRole;
  String? createdAt;
  String? updatedAt;
  Sender? sender;
  Sender? recipient;
  List<Messages>? messages;

  Data(
      {this.id,
        this.senderId,
        this.recipientId,
        this.senderRole,
        this.recipientRole,
        this.createdAt,
        this.updatedAt,
        this.sender,
        this.recipient,
        this.messages});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['senderId'];
    recipientId = json['recipientId'];
    senderRole = json['senderRole'];
    recipientRole = json['recipientRole'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    sender =
    json['sender'] != null ? new Sender.fromJson(json['sender']) : null;
    recipient = json['recipient'] != null
        ? new Sender.fromJson(json['recipient'])
        : null;
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['senderId'] = this.senderId;
    data['recipientId'] = this.recipientId;
    data['senderRole'] = this.senderRole;
    data['recipientRole'] = this.recipientRole;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.sender != null) {
      data['sender'] = this.sender!.toJson();
    }
    if (this.recipient != null) {
      data['recipient'] = this.recipient!.toJson();
    }
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
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

class Messages {
  String? id;
  String? conversationId;
  String? senderId;
  String? recipientId;
  String? senderRole;
  String? recipientRole;
  String? content;
  bool? readMessage;
  String? createdAt;

  Messages(
      {this.id,
        this.conversationId,
        this.senderId,
        this.recipientId,
        this.senderRole,
        this.recipientRole,
        this.content,
        this.readMessage,
        this.createdAt});

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    conversationId = json['conversationId'];
    senderId = json['senderId'];
    recipientId = json['recipientId'];
    senderRole = json['senderRole'];
    recipientRole = json['recipientRole'];
    content = json['content'];
    readMessage = json['read_message'];
    createdAt = json['createdAt'];
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
    return data;
  }
}
