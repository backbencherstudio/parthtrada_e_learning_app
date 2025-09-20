import 'dart:convert';
import 'package:e_learning_app/repository/linkedin_login_webview.dart';
import 'package:e_learning_app/src/features/profile/model/skills_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final skillsProvider = StateNotifierProvider<SkillsNotifier, SkillsModel?>(
  (ref) => SkillsNotifier(),
);

class SkillsNotifier extends StateNotifier<SkillsModel?> {
  SkillsNotifier()
    : super(SkillsModel(success: false, data: [], selectedSkills: {}));

  Set<String> selectedSkills = {};

  Future<void> fetchSkills(String token) async {
    final uri = '$baseUrl/experts/skills';
    final url = Uri.parse(uri);

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', //
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final skills = SkillsModel.fromJson(jsonData);
        state = skills;
      } else {
        throw Exception('Failed to fetch skills');
      }
    } catch (e) {
      state = SkillsModel(
        success: false,
        message: 'Error: $e',
        data: [],
        selectedSkills: {},
      );
    }
  }

  void toggleSkill(String skill) {
    if (selectedSkills.contains(skill)) {
      selectedSkills.remove(skill);
    } else {
      selectedSkills.add(skill);
    }
    state = SkillsModel(
      success: true,
      message: 'Skills updated',
      data: List<String>.from(state?.data ?? []),
      selectedSkills: selectedSkills,
    );
  }

  Set<String> getSelectedSkills() {
    return selectedSkills;
  }

  void clearSelectedSkills() {
    selectedSkills.clear();
    state = SkillsModel(
      success: true,
      message: 'Skills cleared',
      data: List<String>.from(state?.data ?? []),
      selectedSkills: selectedSkills,
    );
  }
}
