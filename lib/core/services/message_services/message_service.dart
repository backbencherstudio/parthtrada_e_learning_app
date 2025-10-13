import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../repository/login_preferences.dart';
import '../../../src/features/message/model/message_model.dart';
import '../local_storage_services/user_id_storage.dart';

class MessageService {
  IO.Socket? _socket;
  final String socketUrl = 'https://parthtrada.obotoronika.com';
  final void Function(Data message) onMessageReceived;
  final void Function(Data message) onNotificationReceived;
  final void Function(String userId) onTyping;
  final void Function(String userId) onStopTyping;

  MessageService({
    required this.onMessageReceived,
    required this.onTyping,
    required this.onStopTyping,
    required this.onNotificationReceived
  });

  Future<void> connect() async {

    final userId = await UserIdStorage().getUserId();

    debugPrint("userid for socket connection: $userId");

    try {
      _socket = IO.io(socketUrl, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
        'query': {'userId': userId},
        'auth': {
          'token': await LoginPreferences().loadAuthToken()
        },
      });

      _socket!.connect();

      _socket!.onConnect((_) {
        print('Socket.IO connected');
        _socket!.emit('join', userId);
      });

      // Listen for raw messages (no specific event)
      _socket!.on('new-message', (data) {
        debugPrint("new message received: $data");
        final messageData = Data.fromJson(data);
        onMessageReceived(messageData);
      });

      // Listen for raw messages (no specific event)
      _socket!.on('received-notification', (data) {
        debugPrint("new notification received: $data");
        final messageData = Data.fromJson(data);
        onNotificationReceived(messageData);
      });


      _socket!.on('typing', (data) {
        onTyping(data['userId']);
      });


      _socket!.on('stop-typing', (data) {
        onStopTyping(data['userId']);
      });

      _socket!.onError((error) {
        print('Socket.IO error: $error');
      });

      _socket!.onDisconnect((_) {
        print('Socket.IO connection closed');
      });
    } catch (e) {
      print('Failed to connect to Socket.IO: $e');
    }
  }

  Future<void> sendMessage({
    required String recipientId,
    // required String recipientRole,
    required String content,
  }) async {
    if (_socket != null && _socket!.connected) {

      final userId = await UserIdStorage().getUserId();

      final message = {
        'recipientId': recipientId,
       // 'recipientRole': recipientRole,
        'content': content,
        'user_id': userId,
      };
      debugPrint("messages: $message");

      _socket!.emit('send-message', message);
      // Create a Data object for the sent message to add to the MessageModel
      final sentMessage = Data(
        recipientId: recipientId,
        //recipientRole: recipientRole,
        content: content,
        me: true, // Mark as sent by the user
        createdAt: DateTime.now().toIso8601String(),
      );
      onMessageReceived(sentMessage);
    }
  }

  void emitTyping(String userId) {
    if (_socket != null && _socket!.connected) {
      _socket!.emit('typing', {
        'userId': userId,
      });
    }
  }

  void emitStopTyping(String userId) {
    if (_socket != null && _socket!.connected) {
      _socket!.emit('stop-typing', {
        'userId': userId,
      });
    }
  }

  void disconnect() {
    _socket?.disconnect();
    _socket?.dispose();
  }
}