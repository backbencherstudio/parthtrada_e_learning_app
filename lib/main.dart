import 'package:e_learning_app/core/constant/default_screen_size.dart';
import 'package:e_learning_app/core/routes/route_config.dart';
import 'package:e_learning_app/core/theme/theme.dart';
import 'package:e_learning_app/core/utils/utils.dart';
import 'package:e_learning_app/repository/login_preferences.dart';
import 'package:e_learning_app/src/features/message/riverpod/conversation_viewmodel.dart';
import 'package:e_learning_app/src/features/onboarding/riverpod/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/services/message_services/message_service.dart';
import 'core/services/notification_services/notification_services.dart';
import 'src/features/message/model/message_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final notificationService = NotificationService();
  await notificationService.init();

  //Test token for dev------------------->>>
 //  await LoginPreferences().setAuthToken("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImNtZ2c0eGJxNjAwMDN2YzRvNW15bzd5NHEiLCJlbWFpbCI6ImFsaWNlMUB0ZXN0LmNvbSIsIm5hbWUiOiJBbGljZSBTbWl0aCIsImFjdGl2ZVByb2ZpbGUiOiJTVFVERU5UIiwiaWF0IjoxNzYwMzI3MTU3LCJleHAiOjE3NjA5MzE5NTd9.L6psONVtjcLVeV0fB7xC2vspFmaGhS635XR-wZRWbH8"); // asifrezan.office@gmail.com
   //await LoginPreferences().setAuthToken("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImNtZ2c0djY2ZzAwMDF2YzRvNGZ5dGFsaGkiLCJlbWFpbCI6ImFzaWZyZXphbi5vZmZpY2VAZ21haWwuY29tIiwibmFtZSI6IkFzaWYuIiwiYWN0aXZlUHJvZmlsZSI6IlNUVURFTlQiLCJpYXQiOjE3NjAzMjk5NDIsImV4cCI6MTc2MDkzNDc0Mn0.oDs3tufichNf5bC3ReO-yb030vBaK06CfHvjknt94ao");
   //await LoginPreferences().setAuthToken("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImNtZ2hmMTJkczAwMDB2Y25za3I5ZTU5c24iLCJlbWFpbCI6ImpvaG5AdGVzdC5jb20iLCJuYW1lIjoiSm9obiBEb2UiLCJhY3RpdmVQcm9maWxlIjoiRVhQRVJUIiwiaWF0IjoxNzYwNTE5NDkyLCJleHAiOjE3NjExMjQyOTJ9.nQj2bOwAG1B3WmrqZ6FRTsisqhmuPkpmH3zr3p8Tz-Y");

  final savedToken = await LoginPreferences().loadAuthToken();
  bool isLoggedIn = false;
  if (savedToken != null) {
    isLoggedIn = await Utils.isTokenValid(savedToken);
  }

  final container = ProviderContainer(
    overrides: [authTokenProvider.overrideWith((ref) => savedToken)],
  );

  // Initialize global socket connection
  final globalMessageService = MessageService(
    onMessageReceived: (Data message) {
      container.read(conversationViewModelProvider.notifier).fetchConversation();
      notificationService.showNotification(message);
      debugPrint("Global message received: ${message.content}");
    },
    onTyping: (String userId) {
      debugPrint("User typing globally: $userId");
    },
    onStopTyping: (String userId) {
      debugPrint("User stopped typing globally: $userId");
    },
    onNotificationReceived: (Data message) {
      notificationService.showNotification(message);
    },
  );
  await globalMessageService.connect();


  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await ScreenUtil.ensureScreenSize();

  runApp(
      ProviderScope(
        overrides: [
          authTokenProvider.overrideWith((ref) => savedToken),
        ],
        observers: [],
        child: MyApp(isLoggedIn: isLoggedIn),
      )

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
