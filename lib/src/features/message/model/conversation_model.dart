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
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
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

  Data({
    this.id,
    this.senderId,
    this.recipientId,
    this.senderRole,
    this.recipientRole,
    this.createdAt,
    this.updatedAt,
    this.sender,
    this.recipient,
    this.messages,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['senderId'];
    recipientId = json['recipientId'];
    senderRole = json['senderRole'];
    recipientRole = json['recipientRole'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    sender = json['sender'] != null ? Sender.fromJson(json['sender']) : null;
    recipient = json['recipient'] != null ? Sender.fromJson(json['recipient']) : null;
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['senderId'] = senderId;
    data['recipientId'] = recipientId;
    data['senderRole'] = senderRole;
    data['recipientRole'] = recipientRole;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (sender != null) {
      data['sender'] = sender!.toJson();
    }
    if (recipient != null) {
      data['recipient'] = recipient!.toJson();
    }
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
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

  Messages({
    this.id,
    this.conversationId,
    this.senderId,
    this.recipientId,
    this.senderRole,
    this.recipientRole,
    this.content,
    this.readMessage,
    this.createdAt,
  });

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
    return data;
  }
}