import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../repository/api/schedule/cancel_schedule.dart';

/// --- Repository provider ---
final cancelScheduleRepositoryProvider = Provider<CancelSchedule>((ref) {
  return CancelSchedule();
});

/// --- State model ---
class CancelScheduleState {
  final bool isLoading;
  final bool? isSuccess;
  final String? errorMessage;

  const CancelScheduleState({
    this.isLoading = false,
    this.isSuccess,
    this.errorMessage,
  });

  CancelScheduleState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return CancelScheduleState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }
}

/// --- Notifier ---
class CancelScheduleNotifier extends StateNotifier<CancelScheduleState> {
  final CancelSchedule _repository;

  CancelScheduleNotifier(this._repository)
      : super(const CancelScheduleState());

  Future<void> cancelMeeting(String id) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final result = await _repository.cancelScheduleMeetings(id: id);
      state = state.copyWith(isLoading: false, isSuccess: result);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  void reset() {
    state = const CancelScheduleState();
  }
}

/// --- Provider ---
final cancelScheduleNotifierProvider = StateNotifierProvider.family<
    CancelScheduleNotifier, CancelScheduleState, String>((ref, id) {
  final repo = ref.read(cancelScheduleRepositoryProvider);
  return CancelScheduleNotifier(repo);
});
