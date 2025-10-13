import 'dart:convert';

import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../services/api_services/api_end_points.dart';
import '../services/local_storage_services/user_id_storage.dart';
import '../services/local_storage_services/user_type_storage.dart';


class Utils {
  static BoxDecoration commonBoxDecoration() {
    return BoxDecoration(
      color: AppColors.secondary,
      borderRadius: BorderRadius.circular(12.r),
    );
  }

  static String formatDate({required DateTime date}) {
    final String formattedDate = DateFormat('MMMM yyyy').format(date);
    return formattedDate;
  }

  /// Formats ISO datetime string like "2025-10-01T03:31:54.974Z"
  /// into "yyyy-MM-dd HH:mm:ss"
  static String formatDateTimeFromIso(String isoString) {
    try {
      final date = DateTime.parse(isoString);
      return DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
    } catch (e) {
      return "Invalid Date";
    }
  }



  static Future<bool> isTokenValid(String token) async {
    final url = 'profile/me';
    try {
      final response = await http.get(
        Uri.parse("${ApiEndPoints.baseUrl}/profile/me"),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final String id = data['data']['id'];
        final String role = data['data']['activeProfile'];
        debugPrint("get profile info: $id");
        debugPrint("get profile role: $role");

        UserIdStorage().saveUserId(id.toString());
        UserTypeStorage().saveUserType(role);

        return true;
      }
    } catch (_) {
      return false;
    }
    return false;
  }








}
