import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedSkillsNotifier extends StateNotifier<Set<String>> {
  SelectedSkillsNotifier() : super(<String>{});

  void toggleSkill(String skill) {
    final s = Set<String>.from(state);
    if (s.contains(skill)) {
      s.remove(skill);
    } else {
      s.add(skill);
    }
    state = s;
  }

  void clear() => state = <String>{};
}

final selectedSkillsProvider =
StateNotifierProvider<SelectedSkillsNotifier, Set<String>>(
      (ref) => SelectedSkillsNotifier(),
);
