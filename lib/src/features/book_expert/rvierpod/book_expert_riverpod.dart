import 'package:e_learning_app/src/features/book_expert/rvierpod/book_expert_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookExpertRiverpod =
    StateNotifierProvider<BookExpertRiverpod, BookExpertState>(
      (ref) => BookExpertRiverpod(),
    );

class BookExpertRiverpod extends StateNotifier<BookExpertState> {
  BookExpertRiverpod() : super(BookExpertState());

  final List<String> sessionDurationList = [
    "15 min",
    "30 min",
    "45 min",
    "1 Hour",
  ];

  void onSelectDurationTile({required int index}) {
    state = state.copyWith(selectedDuration: index);
  }

  final List<String> morningSessionTimeList = [
    "08:00 AM",
    "08:30 AM",
    "09:00 AM",
    "09:30 AM",
    "10:00 AM",
    "10:30 AM",
    "11:00 AM",
    "11:30 AM",
  ];

  final List<String> afternoonSessionTimeList = [
    "03:00 AM",
    "03:30 AM",
    "04:00 AM",
    "04:30 AM",
    "05:00 AM",
    "05:30 AM",
    "06:00 AM",
    "06:30 AM",
  ];

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
