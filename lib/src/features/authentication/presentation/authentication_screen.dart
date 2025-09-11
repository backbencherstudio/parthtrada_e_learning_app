import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/core/constant/padding.dart';
import 'package:e_learning_app/core/routes/route_name.dart';
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:e_learning_app/repository/linkedin_login_webview.dart';
import 'package:e_learning_app/repository/login_preferences.dart';
import 'package:e_learning_app/src/features/onboarding/riverpod/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AuthenticationScreen extends ConsumerWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final authToken = ref.watch(authTokenProvider);
    final isLoggedIn = authToken != null;

    return Scaffold(
      body: Padding(
        padding: AppPadding.screenHorizontal,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppIcons.pngLogo, width: 100.w, height: 100.h),
              SizedBox(height: 10.h),
              Text("TrueNote", style: textTheme.headlineSmall),
              SizedBox(height: 135.h),
              Text("Log In with Linkedin", style: textTheme.headlineSmall),
              SizedBox(height: 16.h),
              Text(
                "Securely access your account with one tap using LinkedIn.",
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.secondaryTextColor,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 48.h),

              SizedBox(
                width: double.infinity,
                child: CommonWidget.primaryButton(
                  context: context,
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LinkedInLoginWebView(),
                      ),
                    );

                    if (result != null && result is Map<String, String>) {
                      final token = result['token'];
                      debugPrint('=================================');
                      debugPrint('token: $token');
                      debugPrint('=================================');
                      if (token != null) {
                        ref.read(authTokenProvider.notifier).state = token;
                        await LoginPreferences().setAuthToken(token);
                        context.go(RouteName.parentScreen);
                      }
                    } else {
                      // Login failed or cancelled
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Login failed")),
                      );
                    }
                  },
                  text: "Log In With Linkedin",
                  textStyle: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
