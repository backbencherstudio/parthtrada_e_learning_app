// notification_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationToggleNotifier extends StateNotifier<List<bool>> {
  NotificationToggleNotifier() : super(List.generate(5, (_) => false));

  void toggle(int index) {
    final updated = [...state];
    updated[index] = !updated[index];
    state = updated;
  }
}

final notificationToggleProvider =
    StateNotifierProvider<NotificationToggleNotifier, List<bool>>(
  (ref) => NotificationToggleNotifier(),
);
