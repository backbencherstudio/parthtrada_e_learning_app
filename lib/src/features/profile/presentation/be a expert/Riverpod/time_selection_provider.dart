import 'package:flutter_riverpod/flutter_riverpod.dart';

class AvailabilityNotifier extends StateNotifier<({Set<String> days, Set<String> times})> {
  AvailabilityNotifier() : super((days: <String>{}, times: <String>{}));

  void toggleDay(String day) {
    final updated = {...state.days};
    updated.contains(day) ? updated.remove(day) : updated.add(day);
    state = (days: updated, times: state.times);
  }

  void toggleTime(String time) {
    final updated = {...state.times};
    updated.contains(time) ? updated.remove(time) : updated.add(time);
    state = (days: state.days, times: updated);
  }

  void clear() {
    state = (days: {}, times: {});
  }
}

final availabilityProvider = StateNotifierProvider<AvailabilityNotifier, ({Set<String> days, Set<String> times})>(
  (ref) => AvailabilityNotifier(),
);
