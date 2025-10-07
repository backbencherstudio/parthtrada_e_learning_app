import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/model/student/student_model.dart';
import '../data/repository/get_student_by_id_repository.dart';

final studentRepositoryProvider = Provider<StudentRepository>((ref) {
  return StudentRepository();
});

final studentProvider = FutureProvider.family<StudentModel?, String>((ref, studentId) async {
  final repository = ref.read(studentRepositoryProvider);
  return await repository.fetchStudent(studentId);
});
