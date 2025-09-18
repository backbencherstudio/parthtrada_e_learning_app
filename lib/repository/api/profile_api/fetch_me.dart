import 'dart:convert';

import 'package:e_learning_app/repository/linkedin_login_webview.dart';
import 'package:e_learning_app/src/features/profile/model/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final aboutMeNotifierProvider =
    StateNotifierProvider<AboutMeNotifier, UserProfile?>(
      (ref) => AboutMeNotifier(),
    );

class AboutMeNotifier extends StateNotifier<UserProfile?> {
  AboutMeNotifier() : super(null);
  // AboutMeNotifier() : super(AsyncLoading());

  Future<void> fetchUserProfile(String token) async {
    final uri = '$baseUrl/profile/me';
    final url = Uri.parse(uri);

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final userProfile = UserProfile.fromJson(jsonData['data']);
        state = userProfile;
        // state = AsyncData(userProfile);
      } else {
        debugPrint('Failed to load profile');
        // state = AsyncError('Failed to load profile');
      }
    } catch (e) {
      debugPrint('Error fetching user profile: $e');
      // state = AsyncError('Error fetching user profile: $e');
    }
  }

  Future<void> updateUserProfile(
    Map<String, String> updatedProfileData,
    String token,
  ) async {
    final uri = '$baseUrl/profile/me/update';
    final url = Uri.parse(uri);

    try {
      final response = await http.patch(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'profession': updatedProfileData['profession'],
          'organization': updatedProfileData['organization'],
          'location': updatedProfileData['location'],
          'description': updatedProfileData['description'],
        }),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final updatedUserProfile = UserProfile.fromJson(jsonData['data']);
        state = updatedUserProfile;
      } else {
        debugPrint('Failed to update profile: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error updating user profile: $e');
    }
  }
}
