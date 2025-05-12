import 'package:e_learning_app/core/routes/route_name.dart';
import 'package:e_learning_app/src/features/parents_Screen/presentation/dummy_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteConfig{
  GoRouter goRouter = GoRouter(
   initialLocation:RouteName.homeScreen ,
    routes: [

      GoRoute(
        name: RouteName.homeScreen,
        path: RouteName.homeScreen,
        pageBuilder: (context, state) {
          return MaterialPage(child: MyHomePage());}
         
      )
    ]
  );
}