// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final skillSelectionProvider =
//     StateNotifierProvider<SkillSelectionNotifier, Set<String>>(
//       (ref) => SkillSelectionNotifier(),
//     );

// class SkillSelectionNotifier extends StateNotifier<Set<String>> {
//   SkillSelectionNotifier() : super({});

//   // Toggle the skill selection
//   void toggle(String skill) {
//     if (state.contains(skill)) {
//       state = Set.from(state)..remove(skill);
//     } else {
//       state = Set.from(state)..add(skill);
//     }
//   }

//   void remove(String skill) {
//     state = Set.from(state)..remove(skill);
//   }

//   void clear() => state = {};
// }
