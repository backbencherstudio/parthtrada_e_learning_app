import 'package:e_learning_app/core/constant/default_screen_size.dart';
import 'package:e_learning_app/core/routes/route_config.dart';
import 'package:e_learning_app/core/theme/theme.dart';
import 'package:e_learning_app/core/utils/utils.dart';
import 'package:e_learning_app/repository/login_preferences.dart';
import 'package:e_learning_app/src/features/onboarding/riverpod/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Test token for dev------------------->>>
  // await LoginPreferences().setAuthToken("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImNtZzdmeHIxdjAwMDB2YzF3MDN1N3Qyc2siLCJlbWFpbCI6ImV4cGVydC5idXR0ZXJmbHkxQGdtYWlsLmNvbSIsIm5hbWUiOiJBa2FzaCBILiIsImFjdGl2ZVByb2ZpbGUiOiJFWFBFUlQiLCJpYXQiOjE3NTk0ODI5NTEsImV4cCI6MTc2MDA4Nzc1MX0.Pp-pyIJpgH6dxjo9s5wwA3L5Nfw4Rqrfu8F205w9D8o"); // expert.butterfly1@gmail.com
  await LoginPreferences().setAuthToken(
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImNtZ2V4ZW95MDAwMDB2Y25vZDNxdmVlbHMiLCJlbWFpbCI6ImFzaWZyZXphbi5vZmZpY2UxNEBnbWFpbC5jb20iLCJuYW1lIjoiQXNpZi0xNC4iLCJhY3RpdmVQcm9maWxlIjoiU1RVREVOVCIsImlhdCI6MTc1OTc0Mjc2OCwiZXhwIjoxNzYwMzQ3NTY4fQ.HV-obvJBMlWjKkaG3v_Mbb3PbulMzNjIrb314qiQz0E",
  ); // asifrezan.office@gmail.com
  // await LoginPreferences().setAuthToken("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImNtZzFuaWx5bjAwMDF2Yzk0bHRwMHl4ZnQiLCJlbWFpbCI6ImV4cGVydDEyM0BvYm90b3JvbmlrYS5jb20iLCJuYW1lIjoiQW5payBIb3NzYWluIiwiYWN0aXZlUHJvZmlsZSI6IkVYUEVSVCIsImlhdCI6MTc1OTU1NzQ4NCwiZXhwIjoxNzYwMTYyMjg0fQ.kdafemLgHmCMTtqM6NoPwwJ2OdYUvAJNI0ai5YB1SlM"); // Anik hossain
  // await LoginPreferences().setAuthToken("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImNtZ2MwaGdwZDAwMGN2Y3Y4dnowaGFtMDAiLCJlbWFpbCI6ImFzaWZyZXphbi5vZmZpY2UyQGdtYWlsLmNvbSIsIm5hbWUiOiJBc2lmIiwiYWN0aXZlUHJvZmlsZSI6IlNUVURFTlQiLCJpYXQiOjE3NTk1NjY1MzcsImV4cCI6MTc2MDE3MTMzN30.xOg1SUdoL0InSvXhy19kfsXOzLHWLtbxwYQ-zN5hAXw");

  final savedToken = await LoginPreferences().loadAuthToken();
  bool isLoggedIn = false;
  if (savedToken != null) {
    isLoggedIn = await Utils.isTokenValid(savedToken);
  }

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
