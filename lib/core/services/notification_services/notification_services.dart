import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:e_learning_app/src/features/message/model/message_model.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:e_learning_app/src/features/message/model/message_model.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  /// Initialize notifications for Android and iOS
  Future<void> init() async {
    // Android settings
    final androidSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS / macOS settings
    final iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // Combined initialization
    final initializationSettings =
    InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );

    // Request iOS permissions
    await _requestIOSPermissions();
  }

  /// iOS explicit permission request
  Future<void> _requestIOSPermissions() async {
    final iosPlugin = _notificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();

    if (iosPlugin != null) {
      await iosPlugin.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      debugPrint("iOS notification permission requested");
    }
  }


  /// Android: check if notifications are enabled
  Future<bool> _checkAndroidPermission() async {
    final androidPlugin = _notificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    if (androidPlugin != null) {
      final isEnabled = await androidPlugin.areNotificationsEnabled();
      return isEnabled ?? true;
    }
    return true;
  }

  /// Show notification
  Future<void> showNotification(Data message) async {
    final hasAndroidPermission = await _checkAndroidPermission();
    if (!hasAndroidPermission) return;

    final androidDetails = AndroidNotificationDetails(
      'message_channel',
      'Messages',
      channelDescription: 'Notifications for new messages',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );

    final iosDetails = DarwinNotificationDetails();

    final notificationDetails =
    NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _notificationsPlugin.show(
      message.id.hashCode,
      'New Message from ${message.sender}',
      message.content,
      notificationDetails,
      payload: message.id,
    );
  }

  /// Handle notification tap
  void _onDidReceiveNotificationResponse(NotificationResponse response) {
    debugPrint('Notification tapped with payload: ${response.payload}');
    // Handle navigation if needed
  }
}