import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../src/features/message/model/conversation_model.dart';

class MessageService {
  late IO.Socket socket;
  final String serverUrl;
  final void Function(String userId) onTyping;
  final void Function(String userId) onStopTyping;
  final void Function(Data message) onNewMessage;

  MessageService({
    required this.serverUrl,
    required this.onTyping,
    required this.onStopTyping,
    required this.onNewMessage,
  }) {
    // Initialize Socket.IO connection
    socket = IO.io(serverUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    // Connect to server
    socket.connect();

    // Handle Socket.IO events
    socket.onConnect((_) {
      print('Connected to Socket.IO server');
    });

    socket.onDisconnect((_) {
      print('Disconnected from Socket.IO server');
    });

    // Listen for typing event
    socket.on('typing', (data) {
      if (data is Map<String, dynamic> && data['userId'] != null) {
        onTyping(data['userId']);
      }
    });

    // Listen for stop-typing event
    socket.on('stop-typing', (data) {
      if (data is Map<String, dynamic> && data['userId'] != null) {
        onStopTyping(data['userId']);
      }
    });

    // Listen for new-message event
    socket.on('new-message', (data) {
      if (data is Map<String, dynamic>) {
        final message = Data.fromJson(data);
        onNewMessage(message);
      }
    });
  }

  // Join a user session
  void join(String userId) {
    socket.emit('join', userId);
  }

  // Join a conversation
  void joinConversation(String conversationId) {
    socket.emit('join-conversation', conversationId);
  }

  // Send a message
  void sendMessage({
    required String conversationId,
    required String senderId,
    required String content,
    required String name,
  }) {
    socket.emit('new-message', {
      'conversationId': conversationId,
      'senderId': senderId,
      'content': content,
      'sender': {'name': name},
    });
  }

  // Emit typing event
  void emitTyping(String conversationId, String userId) {
    socket.emit('typing', {'conversationId': conversationId, 'userId': userId});
  }

  // Emit stop-typing event
  void emitStopTyping(String conversationId, String userId) {
    socket.emit('stop-typing', {'conversationId': conversationId, 'userId': userId});
  }

  // Dispose of socket connection
  void dispose() {
    socket.disconnect();
    socket.dispose();
  }
}