import 'package:e_learning_app/core/constant/default_screen_size.dart';
import 'package:e_learning_app/core/routes/route_config.dart';
import 'package:e_learning_app/core/services/api_services/api_end_points.dart';
import 'package:e_learning_app/core/theme/theme.dart';
import 'package:e_learning_app/repository/linkedin_login_webview.dart';
import 'package:e_learning_app/repository/login_preferences.dart';
import 'package:e_learning_app/src/features/onboarding/riverpod/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Test token for dev------------------->>>
  await LoginPreferences().setAuthToken("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImNtZzkxZm96NTAwMDd2Y3Q4OXJicm9jN3kiLCJlbWFpbCI6InNtcmF3bmFrMDAzQGdtYWlsLmNvbSIsIm5hbWUiOiJSYXduYWsiLCJhY3RpdmVQcm9maWxlIjoiU1RVREVOVCIsImlhdCI6MTc1OTQ2ODA5MiwiZXhwIjoxNzYwMDcyODkyfQ.nXCqX-XhalM9LuXl0t3qUERxGfl6fQPcpbkK2vSKo44");

  final savedToken = await LoginPreferences().loadAuthToken();
  bool isLoggedIn = false;
  if (savedToken != null) {
    isLoggedIn = await _isTokenValid(savedToken);
  }

  Stripe.publishableKey =
  "pk_test_51S8u6SIwqhaYg1GGcOCIlR7izXj81DtVFXHLHDq1JO1lPi5YGqQaLYXNCE90w3my8cGka3sS9TINU56cuXCml30600FtdXhYAf";

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
