import 'package:e_learning_app/core/constant/default_screen_size.dart';
import 'package:e_learning_app/core/routes/route_config.dart';
import 'package:e_learning_app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///set device orientation to portraitUp during app running for better user experience of the UI
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  ///ensuring screen size for screen util package to implement pixel perfect UI
  await ScreenUtil.ensureScreenSize();

  runApp(ProviderScope(child: MyApp()));

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparent status bar add
      systemNavigationBarColor: Colors.transparent, // Transparent nav bar
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          routerConfig: RouteConfig().goRouter,
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
