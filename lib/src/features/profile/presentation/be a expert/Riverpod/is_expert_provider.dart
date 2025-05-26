import 'package:flutter_riverpod/flutter_riverpod.dart';

final isExpertProvider = StateNotifierProvider<ExpertNotifier, bool>((ref) {
  return ExpertNotifier();
});

class ExpertNotifier extends StateNotifier<bool> {
  ExpertNotifier() : super(false);
  void setExpert(bool value) {
    state = value;
  }

  void toggle() {
    state = !state;
  }
}
