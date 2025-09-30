import 'package:e_learning_app/core/services/api_services/api_end_points.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../../core/services/api_services/api_services.dart';
import '../../../../../../repository/login_preferences.dart';
import 'expert_profile_repository.dart';

class ExpertProfileRepositoryImpl implements ExpertProfileRepository {

  final ApiService _apiService = ApiService();

  @override
  Future<bool> saveExpertProfile({
    String? name,
    String? university,
    String? profession,
    String? organization,
    String? location,
    String? description,
    String? experience,
    int? hourlyRate,
    List<String>? skills,
    List<String>? availableDays,
    List<String>? availableTime,
  }) async {
    final Map<String, dynamic> data = {};

    if (name != null) data['name'] = name;
    if (university != null) data['university'] = university;
    if (profession != null) data['profession'] = profession;
    if (organization != null) data['organization'] = organization;
    if (location != null) data['location'] = location;
    if (description != null) data['description'] = description;
    if (experience != null) data['experience'] = experience;
    if (hourlyRate != null) data['hourlyRate'] = hourlyRate;
    if (skills != null && skills.isNotEmpty) data['skills'] = skills;
    if (availableDays != null && availableDays.isNotEmpty) {
      data['availableDays'] = availableDays;
    }
    if (availableTime != null && availableTime.isNotEmpty) {
      data['availableTime'] = availableTime;
    }

    try {
      final response = await _apiService.put(
         ApiEndPoints.beExpert,
        data: data,
      );

      debugPrint("updated token: ${response.data['token']}");

      await LoginPreferences().setAuthToken("${response.data['token']}");


      return response.statusCode == 200 || response.statusCode == 201;
    } catch (_) {
      rethrow;
    }
  }
}
