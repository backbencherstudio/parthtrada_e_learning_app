import 'package:e_learning_app/src/features/profile/data/models/profile_response_data.dart';
import 'package:e_learning_app/src/features/profile/data/repository/profile_repository.dart';
import 'package:e_learning_app/core/services/api_services/api_end_points.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/services/api_services/api_services.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ApiService _apiService;

  ProfileRepositoryImpl({ApiService? apiService})
    : _apiService = apiService ?? ApiService();

  @override
  Future<ProfileResponseData> getProfileInfo() async {
    try {
      final response = await _apiService.get(ApiEndPoints.profileInfo);
      debugPrint("Profile data response: ${response.data}");
      if (response.data != null && response.data is Map<String, dynamic>) {
        return ProfileResponseData.fromJson(
          response.data as Map<String, dynamic>,
        );
      } else {
        return ProfileResponseData(
          success: false,
          message: "Failed to fetch profile: Invalid or null response data",
        );
      }
    } catch (e) {
      debugPrint("Error fetching profile info: $e");
      return ProfileResponseData(
        success: false,
        message: "Error fetching profile: ${e.toString()}",
      );
    }
  }

  @override
  Future<bool> updateProfile(
    String profession,
    String organization,
    String location,
    String description,
  ) async {
    final data = {
      'profession': profession,
      'organization': organization,
      'location': location,
      'description': description,
    };

    try {
      final response = await _apiService.patch(
        ApiEndPoints.updateProfile,
        data: data,
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("Error fetching profile info: $e");
      return false;
    }
  }
}
