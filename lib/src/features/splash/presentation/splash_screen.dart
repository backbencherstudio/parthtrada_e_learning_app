import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/core/routes/route_name.dart';
import 'package:e_learning_app/core/theme/theme_part/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        context.go(RouteName.onboarding);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10.h,
          children: [
            Image.asset(AppIcons.pngLogo,width: 100.w,height: 100.h,),
            Text("TrueNote",style: Theme.of(context).textTheme.headlineSmall,),
            SizedBox(height: 170.h,),


            /// Progressing Indicator
            NutsActivityIndicator(
              activeColor: AppColors.primary,
              inactiveColor: Colors.white ,
              tickCount: 12,
              relativeWidth: 0.7,
              radius: 18 ,
              startRatio: 0.6,
              animationDuration: Duration(milliseconds: 1000),
            ),
          ],
        ),
      ),
    );
  }
}