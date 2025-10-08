import '../data/model/student/student_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repository/get_student_by_id_repository.dart';

class StudentState {
  final bool isLoading;
  final StudentModel? student;
  final String? error;

  const StudentState({
    this.isLoading = false,
    this.student,
    this.error,
  });

  StudentState copyWith({
    bool? isLoading,
    StudentModel? student,
    String? error,
  }) {
    return StudentState(
      isLoading: isLoading ?? this.isLoading,
      student: student ?? this.student,
      error: error,
    );
  }
}

class StudentNotifier extends StateNotifier<StudentState> {
  final StudentRepository _repository;

  StudentNotifier(this._repository) : super(const StudentState());

  Future<void> fetchStudent(String studentId) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final response = await _repository.fetchStudent(studentId);

      if (response != null) {
        state = state.copyWith(isLoading: false, student: response);
      } else {
        state = state.copyWith(isLoading: false, error: 'No student data found');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void reset() {
    state = const StudentState();
  }
}

final studentRepositoryProvider = Provider<StudentRepository>((ref) {
  return StudentRepository();
});

final studentProvider =
StateNotifierProvider<StudentNotifier, StudentState>((ref) {
  final repository = ref.read(studentRepositoryProvider);
  return StudentNotifier(repository);
});
