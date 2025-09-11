import 'package:e_learning_app/repository/api/expert/fetch_expert.dart';
import 'package:e_learning_app/src/features/onboarding/riverpod/login_state.dart';
import 'package:e_learning_app/src/features/search/model/expert_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final expertProvider = FutureProvider<ExpertModel>((ref) async {
  final token = ref.watch(authTokenProvider);

  if (token == null) {
    throw Exception('Un Authorized/No auth token found');
  }
  final repository = FetchExpert();
  return await repository.getExperts(token);
});
