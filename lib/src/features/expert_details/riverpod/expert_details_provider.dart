import 'package:e_learning_app/src/features/expert_details/model/expert_detail_model.dart';
import 'package:e_learning_app/src/features/onboarding/riverpod/login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../repository/api/expert/expart_detail.dart';

final expertDetailProvider = FutureProvider.family<ExpartDetailModel, String>((
  ref,
  expertId,

) async {
  final token = ref.watch(authTokenProvider);

  if (token == null) {
    throw Exception('Unauthorized: No auth token found');
  }

  final repository = FetchExpertDetail();
  return await repository.getExpertDetail(token, expertId);
});
