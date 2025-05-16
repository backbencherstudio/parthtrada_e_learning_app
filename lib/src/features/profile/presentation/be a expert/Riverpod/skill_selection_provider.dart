import 'package:flutter_riverpod/flutter_riverpod.dart';

final skillSelectionProvider =
    StateNotifierProvider<SkillSelectionNotifier, Set<String>>(
  (ref) => SkillSelectionNotifier(),
);

class SkillSelectionNotifier extends StateNotifier<Set<String>> {
  SkillSelectionNotifier() : super({});

  void toggle(String skill) {
    if (state.contains(skill)) {
      state = {...state}..remove(skill);
    } else {
      state = {...state, skill};
    }
  }
}
