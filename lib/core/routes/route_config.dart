import 'package:e_learning_app/core/routes/route_name.dart';
import 'package:e_learning_app/src/features/message/presentation/inbox_screen/inbox_screen.dart';

import 'package:e_learning_app/src/features/onboarding/presentation/onboarding_screen.dart';
import 'package:e_learning_app/src/features/parents/presentation/parents_screen.dart';
import 'package:e_learning_app/src/features/profile/presentation/payment%20method/payment_method.dart';
import 'package:e_learning_app/src/features/profile/presentation/user%20profile/user_profile.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import '../../src/features/past_call/presentation/past_call.dart';
import '../../src/features/privacy_policy/presentation/privacy_policy.dart';
import '../../src/features/sent_request/presentation/sent_request_page.dart';
import '../../src/features/splash/presentation/splash_screen.dart';
import '../../src/features/transection_history/presentation/transaction_history.dart';
import 'build_page_with_transition.dart';

import '../../src/features/message/presentation/message_screen/message_screen.dart';

class RouteConfig {
  GoRouter goRouter = GoRouter(
     initialLocation: RouteName.parentScreen,


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
        name: RouteName.parentScreen,
        path: RouteName.parentScreen,
        pageBuilder: (context, state) {
          return buildPageWithTransition(
            transitionType: PageTransitionType.fade,
            context: context,
            state: state,
            child: ParentScreen(),
          );
        },
      ),
     
      GoRoute(
        name: RouteName.userProfile,
        path: RouteName.userProfile,
        pageBuilder: (context, state) {
          return const MaterialPage(child: UserProfile());
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
        },
      ),
  GoRoute(
        name: RouteName.paymentMethodScreen,
        path: RouteName.paymentMethodScreen,
        pageBuilder: (context, state) {
          return buildPageWithTransition(
            transitionType: PageTransitionType.fade,
            context: context,
            state: state,
            child: PaymentMethodScreen());}
          ),

      GoRoute(
        name: RouteName.sentRequest,
        path: RouteName.sentRequest,
        pageBuilder: (context, state) {
          return const MaterialPage(child: SentRequestPage());
        },
      ),
      GoRoute(
        name: RouteName.pastCall,
        path: RouteName.pastCall,
        pageBuilder: (context, state) {
          return const MaterialPage(child: PastCall());
        },
      ),
      GoRoute(
        name: RouteName.transactionHistory,
        path: RouteName.transactionHistory,
        pageBuilder: (context, state) {
          return const MaterialPage(child: TransactionHistory());
        },
      ),
      GoRoute(
        name: RouteName.privacyPolicy,
        path: RouteName.privacyPolicy,
        pageBuilder: (context, state) {
          return const MaterialPage(child: PrivacyPolicy());
        },
      ),
    ],
  );
}
