import 'package:e_learning_app/core/constant/images.dart';
import 'package:e_learning_app/src/features/notification/widgets/model/notification_model.dart';
import 'package:riverpod/riverpod.dart';

final notificationProvider = StateNotifierProvider<NotificationNotifier, List<NotificationItem>>((ref) {
  return NotificationNotifier();
});

class NotificationNotifier extends StateNotifier<List<NotificationItem>> {
  NotificationNotifier() : super(_initialNotifications);

  static final List<NotificationItem> _initialNotifications = [
    NotificationItem(
      title: 'Sarah Chen',
      description: 'Accepted your consultation request for June 13th at 3 PM.',
      img: AppImages.women, // replace with actual asset path
    ),
    NotificationItem(
      title: 'Dr. Mark',
      description: 'Sent you a message regarding your last session.',
      img: AppImages.men,
    ),
    NotificationItem(
      title: 'App Reminder',
      description: 'Your free trial ends in 2 days. Don’t forget to upgrade.',
      img: AppImages.women,
    ),
     NotificationItem(
      title: 'Sarah Chen',
      description: 'Accepted your consultation request for June 13th at 3 PM.',
      img: AppImages.women, // replace with actual asset path
    ),
    NotificationItem(
      title: 'Dr. Mark',
      description: 'Sent you a message regarding your last session.',
      img: AppImages.men,
    ),
    NotificationItem(
      title: 'App Reminder',
      description: 'Your free trial ends in 2 days. Don’t forget to upgrade.',
      img: AppImages.women,
    ),
     NotificationItem(
      title: 'Sarah Chen',
      description: 'Accepted your consultation request for June 13th at 3 PM.',
      img: AppImages.women, // replace with actual asset path
    ),
    NotificationItem(
      title: 'Dr. Mark',
      description: 'Sent you a message regarding your last session.',
      img: AppImages.men,
    ),
    NotificationItem(
      title: 'App Reminder',
      description: 'Your free trial ends in 2 days. Don’t forget to upgrade.',
      img: AppImages.women,
    ),
  ];

  void addNotification(NotificationItem item) {
    state = [...state, item];
  }

  void removeNotification(int index) {
    state = List.from(state)..removeAt(index);
  }

  void clearAll() {
    state = [];
  }
}
