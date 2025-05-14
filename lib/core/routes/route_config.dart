
import 'package:e_learning_app/core/routes/route_name.dart';
import 'package:e_learning_app/src/features/message/presentation/inbox_screen/inbox_screen.dart';

import 'package:e_learning_app/src/features/onboarding/presentation/onboarding_screen.dart';
import 'package:e_learning_app/src/features/parents/presentation/parents_screen.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import '../../src/features/splash/presentation/splash_screen.dart';
import 'build_page_with_transition.dart';


import '../../src/features/message/presentation/message_screen/message_screen.dart';

class RouteConfig {
  GoRouter goRouter = GoRouter(
    initialLocation: RouteName.messageScreen,
    routes: [
      GoRoute(
        path: RouteName.messageScreen,
        builder: (context, state) => const MessageScreen(),
      ),
      GoRoute(
        path: RouteName.inboxScreen,
        builder: (context, state) {
          final args = state.extra as Map<String, String>;
          return InboxScreen(
            image: args['image'] ?? '',
            name: args['name'] ?? '',
            userId: args['userId'] ?? '',
          );
        },
      ),

      GoRoute(
        name: RouteName.splash,
        path: RouteName.splash,
        pageBuilder: (context, state) {
          return const MaterialPage(child: SplashScreen());
        },
      ),
 GoRoute(
        name: RouteName.parents_screen,
        path: RouteName.parents_screen,
        pageBuilder: (context, state) {
          return const MaterialPage(child: ParentScreen());
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
