import 'dart:convert';

import 'package:e_learning_app/repository/linkedin_login_webview.dart';
import 'package:e_learning_app/src/features/onboarding/riverpod/login_state.dart';
import 'package:e_learning_app/src/features/profile/model/be_expert_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final beExpertProvider = StateNotifierProvider<BeExpertNotifier, BeExpertModel>(
  (ref) {
    return BeExpertNotifier();
  },
);

class BeExpertNotifier extends StateNotifier<BeExpertModel> {

  BeExpertNotifier() : super(BeExpertModel(success: false));

  final String uri = '$baseUrl/auth/be-expert';

  Future<void> updateExpertData(
    WidgetRef ref,
    String token,
    Map<String, dynamic> json,
  ) async {
    try {
      final response = await http.put(
        Uri.parse(uri),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(json),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final beExpert = BeExpertModel.fromJson(jsonData);

        if (jsonData['token'] != null) {
          final newTokenAsExpert = jsonData['token'];
          ref.read(authTokenProvider.notifier).state = newTokenAsExpert;
        }
        state = beExpert;
      } else {
        throw Exception('Failed to update BeExpert data');
      }
    } catch (e) {
      state = BeExpertModel(success: false, message: 'Error: $e');
    }
  }
}
