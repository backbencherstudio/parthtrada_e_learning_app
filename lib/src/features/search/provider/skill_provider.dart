import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../repository/api/home/fetch_skills.dart';
import '../../onboarding/riverpod/login_state.dart';
import '../model/skill_model.dart';

final skillProvider = FutureProvider<SkillModel>((ref) async {
  final token = ref.watch(authTokenProvider);

  if (token == null) {
    throw Exception('Unauthorized/No auth token found');
  }

  final repository = FetchSkills();

  try {
    final skills = await repository.getSkills(token);
    debugPrint('Success in skillProvider');
    debugPrint('${skills.data.length}');
    return skills;
  } catch (e) {
    debugPrint('Error in skillProvider: $e');
    throw Exception('Failed to fetch skills: $e');
  }
});
