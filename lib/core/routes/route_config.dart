import 'package:e_learning_app/core/routes/route_name.dart';
import 'package:e_learning_app/src/features/parents/presentation/dummy_screen.dart';
import 'package:e_learning_app/src/features/parents/presentation/parents_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteConfig{
  GoRouter goRouter = GoRouter(
   initialLocation:RouteName.parentScreen ,
    routes: [

      GoRoute(
        name: RouteName.parentScreen,
        path: RouteName.parentScreen,
        pageBuilder: (context, state) {
          return MaterialPage(child: ParentScreen());}
         
      )
    ]
  );
}