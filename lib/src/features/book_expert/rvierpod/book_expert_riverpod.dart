import 'package:e_learning_app/src/features/book_expert/rvierpod/book_expert_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookExpertRiverpod = StateNotifierProvider.family<BookExpertRiverpod, BookExpertState, List<String>>(
      (ref, availableTime) => BookExpertRiverpod(availableTime: availableTime),
);

class BookExpertRiverpod extends StateNotifier<BookExpertState> {
  BookExpertRiverpod({required List<String> availableTime}) : super(BookExpertState()) {
    morningSessionTimeList = availableTime
        .where((time) => time.toUpperCase().contains('AM'))
        .toList();

    afternoonSessionTimeList = availableTime
        .where((time) => time.toUpperCase().contains('PM'))
        .toList();
  }

  final List<String> sessionDurationList = [
    "15 min",
    "30 min",
    "45 min",
    "1 Hour",
    "1.5 Hour",
    "2 Hour",
    "3 Hour",
  ];

  late final List<String> morningSessionTimeList;
  late final List<String> afternoonSessionTimeList;

  void onSelectDurationTile({required int index}) {
    state = state.copyWith(selectedDuration: index);
  }

  void onSelectSessionTime({required int index, required bool isMorningShift}) {
    state = state.copyWith(
      selectedSessionTime: index,
      isMorningShift: isMorningShift,
    );
  }

  Future<void> onConfirmBooking() async {
    state = state.copyWith(isConfirmLoading: true);
    await Future.delayed(Duration(milliseconds: 200));

    await Future.delayed(const Duration(seconds: 2));
    state = state.copyWith(isSuccessfullyBooked: true);

    state = state.copyWith(isConfirmLoading: false);
  }

  Future<void> onCancelBooking() async {
    state = state.copyWith(isSuccessfullyBooked: false);
  }
}
