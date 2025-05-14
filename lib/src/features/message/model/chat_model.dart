class ChatItem {
  final String userId;
  final String imageUrl;
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;

  ChatItem({
    required this.userId,
    required this.imageUrl,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
  });

  factory ChatItem.fromJson(Map<String, dynamic> json) {
    return ChatItem(
      imageUrl: json['imageUrl'] as String,
      name: json['name'] as String,
      lastMessage: json['lastMessage'] as String,
      time: json['time'] as String,
      unreadCount: json['unreadCount'] as int,
      userId: json['userId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'imageUrl': imageUrl,
      'name': name,
      'lastMessage': lastMessage,
      'time': time,
      'unreadCount': unreadCount,
    };
  }
}
