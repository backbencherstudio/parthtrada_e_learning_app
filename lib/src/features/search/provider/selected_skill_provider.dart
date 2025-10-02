import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedSkillsProvider = StateNotifierProvider<SelectedSkillsNotifier, Set<String>>((ref) {
  return SelectedSkillsNotifier();
});

class SelectedSkillsNotifier extends StateNotifier<Set<String>> {
  SelectedSkillsNotifier() : super({});

  void toggleSkill(String skill) {
    if (state.contains(skill)) {
      state = {...state}..remove(skill);
    } else {
      state = {...state}..add(skill);
    }
    debugPrint("\nSelected indexes: $state\n");
  }

  void clear() {
    state = {};
  }
}
