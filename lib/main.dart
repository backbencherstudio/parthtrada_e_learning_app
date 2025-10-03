import 'dart:convert';

import 'package:e_learning_app/core/constant/default_screen_size.dart';
import 'package:e_learning_app/core/routes/route_config.dart';
import 'package:e_learning_app/core/services/api_services/api_end_points.dart';
import 'package:e_learning_app/core/services/local_storage_services/user_id_storage.dart';
import 'package:e_learning_app/core/theme/theme.dart';
import 'package:e_learning_app/repository/login_preferences.dart';
import 'package:e_learning_app/src/features/onboarding/riverpod/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import 'core/services/message_services/message_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Test token for dev------------------->>>
  //await LoginPreferences().setAuthToken("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImNtZzdmeHIxdjAwMDB2YzF3MDN1N3Qyc2siLCJlbWFpbCI6ImV4cGVydC5idXR0ZXJmbHkxQGdtYWlsLmNvbSIsIm5hbWUiOiJBa2FzaCBILiIsImFjdGl2ZVByb2ZpbGUiOiJFWFBFUlQiLCJpYXQiOjE3NTk0ODI5NTEsImV4cCI6MTc2MDA4Nzc1MX0.Pp-pyIJpgH6dxjo9s5wwA3L5Nfw4Rqrfu8F205w9D8o"); // expert.butterfly1@gmail.com
  await LoginPreferences().setAuthToken("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImNtZzIxM2E5YzAwMDB2Y2lzb2dzN295NGEiLCJlbWFpbCI6ImFzaWZyZXphbi5vZmZpY2VAZ21haWwuY29tIiwibmFtZSI6IkFzaWYgUmV6YW4iLCJhY3RpdmVQcm9maWxlIjoiRVhQRVJUIiwiaWF0IjoxNzU5NDg0NTI4LCJleHAiOjE3NjAwODkzMjh9.ufqjUWbt6LwjuKwiG6OkxBkWfq95ufGULBElFQNoVbM"); // asifrezan.office@gmail.com

  final savedToken = await LoginPreferences().loadAuthToken();
  bool isLoggedIn = false;
  if (savedToken != null) {
    isLoggedIn = await _isTokenValid(savedToken);
  }


  // Stripe.publishableKey =
  // "pk_test_51S8u6SIwqhaYg1GGcOCIlR7izXj81DtVFXHLHDq1JO1lPi5YGqQaLYXNCE90w3my8cGka3sS9TINU56cuXCml30600FtdXhYAf";

  // Stripe.merchantIdentifier = "merchant.com.yourapp";
  //
  // await Stripe.instance.applySettings();



  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await ScreenUtil.ensureScreenSize();

  runApp(
    ProviderScope(
      overrides: [authTokenProvider.overrideWith((ref) => savedToken)],
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
  );
}

Future<bool> _isTokenValid(String token) async {
  final url = 'profile/me';
  try {
    final response = await http.get(
      Uri.parse("${ApiEndPoints.baseUrl}/profile/me"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final String id = data['data']['id'];
      debugPrint("get profile info: $id");
      UserIdStorage().saveUserId(id.toString());

      return true;
    }
  } catch (_) {
    return false;
  }
  return false;
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
        DefaultScreenSize.deviceWidth,
        DefaultScreenSize.deviceHeight,
      ),
      minTextAdapt: true,
      ensureScreenSize: true,
      builder: (context, child) {
        return MaterialApp.router(
          routerConfig: RouteConfig(isLoggedIn: isLoggedIn).goRouter,
          title: "E-Learning",
          debugShowCheckedModeBanner: false,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.dark,
          theme: AppTheme.darkTheme,
        );
      },
    );
  }
}
