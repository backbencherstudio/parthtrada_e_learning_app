class MessageModel {
  final String userId;
  final String name;
  final String message;
  final String time;
  final bool isRead;
  final bool isMe;

  MessageModel({
    required this.userId,
    required this.name,
    required this.message,
    required this.time,
    required this.isRead,
    required this.isMe,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      userId: json['userId'],
      name: json['name'],
      message: json['message'],
      time: json['time'],
      isRead: json['isRead'],
      isMe: json['isMe'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'message': message,
      'time': time,
      'isRead': isRead,
      'isMe': isMe,
    };
  }
}
