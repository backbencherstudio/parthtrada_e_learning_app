import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/core/constant/images.dart';
import 'package:e_learning_app/core/constant/padding.dart';
import 'package:e_learning_app/core/routes/route_name.dart';
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:e_learning_app/src/features/parents/riverpod/parentsScreen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
                child: Consumer(
                  builder: (_, ref, _) {
                    return CommonWidget.primaryButton(
                      context: context,
                      onPressed: () {
                        ref
                            .read(parentsScreenProvider.notifier)
                            .onSelectedIndex(0);
                        context.go(RouteName.parentScreen);
                      },
                      text: "Log In With Linkedin",
                      textStyle: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
