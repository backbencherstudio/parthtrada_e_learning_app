import 'package:flutter_riverpod/flutter_riverpod.dart' show StateNotifier, StateNotifierProvider;

class CheckboxListNotifier extends StateNotifier<List<bool>> {
  CheckboxListNotifier() : super(List.generate(8, (_) => false));

  void selectOnly(int index) {
    state = List.generate(state.length, (i) => i == index);
  }

  void reset() => state = List.generate(state.length, (_) => false);
}

final checkboxListProvider =
    StateNotifierProvider<CheckboxListNotifier, List<bool>>(
  (ref) => CheckboxListNotifier(),
);
