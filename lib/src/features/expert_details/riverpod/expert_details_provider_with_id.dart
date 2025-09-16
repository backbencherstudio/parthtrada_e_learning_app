import 'dart:convert';

import 'package:e_learning_app/src/features/expert_details/model/user_specific_model.dart';
import 'package:e_learning_app/src/features/onboarding/riverpod/login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final expertDetailsProvider =
    StateNotifierProvider<ExpertDetailsNotifier, SpecificUserDetails>(
      (ref) => ExpertDetailsNotifier(ref),
    );

class ExpertDetailsNotifier extends StateNotifier<SpecificUserDetails> {
  final Ref ref;
  ExpertDetailsNotifier(this.ref) : super(SpecificUserDetails());

  Future<void> fetchExpertDetails(String url) async {
    final authToken = ref.watch(authTokenProvider);

    state = SpecificUserDetails(
      success: false,
      message: 'Loading...',
      data: null,
    );

    try {
      // print("Making request to: $url..........");

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      );

      // print('status code========${response.statusCode}');
      // print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        final expertDetails = SpecificUserDetails.fromJson(jsonData);

        // print('printing data of user $expertDetails');
        state = expertDetails;
      } else {
        // print('Failed to fetch data. Status code: ${response.statusCode}');
        state = SpecificUserDetails(
          success: false,
          message: 'Failed to fetch data. Please try again.',
          data: null,
        );
      }
    } catch (e) {
      // print('An error occurred: $e');
      state = SpecificUserDetails(
        success: false,
        message: 'An error occurred: $e',
        data: null,
      );
    }
  }
}
