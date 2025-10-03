import 'dart:convert';
import 'package:e_learning_app/src/features/book_expert/model/booking_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../core/services/api_services/api_end_points.dart';
import '../../../src/features/book_expert/model/session_model.dart';
import '../../login_preferences.dart';

class ExpertBooking {
  Future<BookingResponse> bookExpert(SessionModel sessionData) async {
    final url = Uri.parse(ApiEndPoints.bookExpert);
    final token = await LoginPreferences().loadAuthToken();

    debugPrint('======= $url =======');
    debugPrint('======= $token =======');

    final Map<String, dynamic> body = {
      "expertId": sessionData.expertId,
      "date": sessionData.date,
      "time": sessionData.time,
      "sessionDuration": sessionData.sessionDuration,
      "sessionDetails": sessionData.sessionDetails,
      "currency": "usd",
    };

    debugPrint('======= book expert body $body =======');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      debugPrint('======= book expert ${jsonData['success']} =======');
      return BookingResponse.fromJson(jsonData);
    } else {
      final errorData = jsonDecode(response.body);
      debugPrint('Booking error: $errorData');
      throw Exception('Failed to book expert: ${response.statusCode} ${errorData}');
    }
  }
}
