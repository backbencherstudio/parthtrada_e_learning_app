import 'dart:convert';
import 'package:e_learning_app/core/services/api_services/api_end_points.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../../repository/login_preferences.dart';
import '../model/student/student_model.dart';

class StudentRepository {

  Future<StudentModel?> fetchStudent(String studentId) async {
    final url = Uri.parse(ApiEndPoints.getStudentById(studentId));
    final token = await LoginPreferences().loadAuthToken();

    if (token == null || token == '') {
      debugPrint('======= token is null =======');
      return null;
    }

    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      debugPrint('=======${StudentModel.fromJson(jsonData).message}');
      return StudentModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch student details: ${response.statusCode}');
    }
  }
}
