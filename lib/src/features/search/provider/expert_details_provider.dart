import 'dart:convert';

import 'package:e_learning_app/repository/linkedin_login_webview.dart';
import 'package:e_learning_app/src/features/search/model/data_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final mExpertProvider =
    StateNotifierProvider<ExpertNotifier, AsyncValue<List<DataModel>>>(
      (ref) => ExpertNotifier(),
    );

class ExpertNotifier extends StateNotifier<AsyncValue<List<DataModel>>> {
  ExpertNotifier() : super(const AsyncValue.loading());

  Future<void> fetchExperts({
    String name = '',
    List<String> skills = const [],
    String? authToken,
  }) async {
    state = const AsyncValue.loading();

    try {
      final skillsParam = skills.join(',');
      final url = Uri.parse('$baseUrl/experts?name=$name&skills=$skillsParam');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body) as Map<String, dynamic>;
        final dataList =
            (jsonBody['data'] as List)
                .map((e) => DataModel.fromJson(e))
                .toList();
        state = AsyncValue.data(dataList);
      } else {
        state = AsyncValue.error('Failed to fetch experts', StackTrace.current);
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
