import 'package:flutter/material.dart';
import 'package:e_learning_app/core/routes/route_name.dart';
import 'package:go_router/go_router.dart';
import '../../src/features/splash/presentation/splash_screen.dart';

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
    ],
  );
}
