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
  //  await LoginPreferences().setAuthToken("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImNtaGxnZ2lhaDAwMHl2OGhrbHltbWF3ZTAiLCJlbWFpbCI6ImFzaWZyZXphbi5vZmZpY2UzQGdtYWlsLmNvbSIsIm5hbWUiOiJBc2lmIDMiLCJhY3RpdmVQcm9maWxlIjoiU1RVREVOVCIsImlhdCI6MTc2MjMxNDM0NCwiZXhwIjoxNzYyOTE5MTQ0fQ.gnZUpIa_P8UoZOWbUuPnpVyqe3tpzLlEHh7kQCWP3wg");
  //await LoginPreferences().setAuthToken("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImNtaGJqMHhuNzAwMDB2OHNveXk4ZzFucXIiLCJlbWFpbCI6ImJvYkB0ZXN0LmNvbSIsIm5hbWUiOiJCb2IgU21pdGgiLCJhY3RpdmVQcm9maWxlIjoiRVhQRVJUIiwiaWF0IjoxNzYyODQ1MDg5LCJleHAiOjE3NjM0NDk4ODl9.13x7ROa5_unZQwbIXgSSD0azhynk1sBiguelqrUBMEU");
 /// await LoginPreferences().setAuthToken("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImNtaHVjMzJ1ODAwMHZ2OGJnZG0ybmx5ejYiLCJlbWFpbCI6InJhd25ha0BnbWFpbC5jb20iLCJuYW1lIjoiUmF3bmFrIiwiYWN0aXZlUHJvZmlsZSI6IkVYUEVSVCIsImlhdCI6MTc2Mjg1MjkyNSwiZXhwIjoxNzYzNDU3NzI1fQ.PyuFm3kx4TzTFsvuvw9fGovGsEhYoNK0heOyOrYCsps"); // rawnak
  //await LoginPreferences().setAuthToken("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImNtaHVjMnUwejAwMHV2OGJnbmFxN2F1bTEiLCJlbWFpbCI6Im51cmphQGdtYWlsLmNvbSIsIm5hbWUiOiJOdXJqYWhhbiIsImFjdGl2ZVByb2ZpbGUiOiJFWFBFUlQiLCJpYXQiOjE3NjI4NTM2OTUsImV4cCI6MTc2MzQ1ODQ5NX0.0ZeR1Br7qazMCLTgiIiB1L63dy7Va1i9dN78gIfPnTI"); // nurja
  //await LoginPreferences().setAuthToken("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImNtaHVmZndpdzAwMGV2OHU4dnYyMXptOTkiLCJlbWFpbCI6ImpvaG5AdGVzdC5jb20iLCJuYW1lIjoiSm9obiBEb2UiLCJhY3RpdmVQcm9maWxlIjoiRVhQRVJUIiwiaWF0IjoxNzYyODU4MjY1LCJleHAiOjE3NjM0NjMwNjV9.SA6tv2jIaQv6VxQWEwkiP8lQC37JztqY7ETHlNABthk"); // jon

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
