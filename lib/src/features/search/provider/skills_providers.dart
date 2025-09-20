import 'package:e_learning_app/repository/expert_skills.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final expertSkillsProvider = FutureProvider.family<List<String>, String>((
  ref,
  token,
) async {
  final service = ExpertService();
  return service.fetchSkills(token);
});
