import 'package:e_learning_app/src/features/onboarding/presentation/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_learning_app/core/routes/route_name.dart';
import 'package:go_router/go_router.dart';
import '../../src/features/splash/presentation/splash_screen.dart';
import 'build_page_with_transition.dart';

class RouteConfig {
  GoRouter goRouter = GoRouter(
     initialLocation: RouteName.splash,
    routes: [
      GoRoute(
        name: RouteName.splash,
        path: RouteName.splash,
        pageBuilder: (context, state) {
          return const MaterialPage(child: SplashScreen());
        },
      ),

      GoRoute(
        name: RouteName.onboarding,
        path: RouteName.onboarding,
        pageBuilder: (context, state) {
          return buildPageWithTransition(
            transitionType: PageTransitionType.fade,
            context: context,
            state: state,
            child: OnboardingScreen(),
          );

          //return const MaterialPage(child: TodayMoodMosaicScreen());
        },
      ),

    ],
  );
}
