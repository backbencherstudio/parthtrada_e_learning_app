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
  //await LoginPreferences().setAuthToken("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImNtZ2c0djY2ZzAwMDF2YzRvNGZ5dGFsaGkiLCJlbWFpbCI6ImFzaWZyZXphbi5vZmZpY2VAZ21haWwuY29tIiwibmFtZSI6IkFzaWYuIiwiYWN0aXZlUHJvZmlsZSI6IlNUVURFTlQiLCJpYXQiOjE3NTk4MTU3NTksImV4cCI6MTc2MDQyMDU1OX0.RXaAb-hKmoZlW0ThqFsihOIEsBBWiCUWVtpaDrtKwcU"); // asifrezan.office@gmail.com
  await LoginPreferences().setAuthToken("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImNtZ2hmMTJkczAwMDB2Y25za3I5ZTU5c24iLCJlbWFpbCI6ImpvaG5AdGVzdC5jb20iLCJuYW1lIjoiSm9obiBEb2UiLCJhY3RpdmVQcm9maWxlIjoiRVhQRVJUIiwiaWF0IjoxNzYwMDkzOTk4LCJleHAiOjE3NjA2OTg3OTh9.qMJY5L9-GhFgfHrxqe3TBnNDoBHB6mnGHA90MB6DMzs");
  //await LoginPreferences().setAuthToken("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImNtZ2c0eGJxNjAwMDN2YzRvNW15bzd5NHEiLCJlbWFpbCI6ImFsaWNlMUB0ZXN0LmNvbSIsIm5hbWUiOiJBbGljZSBTbWl0aCIsImFjdGl2ZVByb2ZpbGUiOiJTVFVERU5UIiwiaWF0IjoxNzYwMTUwNjc1LCJleHAiOjE3NjA3NTU0NzV9.Ata--AJWJkuXKhl5O49_F_bOtD8wnSTfVW75rIUn-Gk");


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
