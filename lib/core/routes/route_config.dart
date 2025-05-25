import 'package:e_learning_app/core/routes/route_name.dart';
import 'package:e_learning_app/src/features/authentication/presentation/authentication_screen.dart';
import 'package:e_learning_app/src/features/expert_details/presentation/expert_details_screen.dart';
import 'package:e_learning_app/src/features/message/presentation/inbox_screen/inbox_screen.dart';
import 'package:e_learning_app/src/features/notification/global_notification_screen.dart';

import 'package:e_learning_app/src/features/onboarding/presentation/onboarding_screen.dart';
import 'package:e_learning_app/src/features/parents/presentation/parents_screen.dart';
import 'package:e_learning_app/src/features/profile/presentation/language/language.dart';
import 'package:e_learning_app/src/features/profile/presentation/notification/view/notification.dart';
import 'package:e_learning_app/src/features/profile/presentation/payment%20method/view/payment_method.dart';
import 'package:e_learning_app/src/features/profile/presentation/user%20profile/view/user_profile.dart';
import 'package:e_learning_app/src/features/student_details/presentation/student_details_screen.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import '../../src/features/profile/sub_feature/help_and_support/help_and_support.dart';
import '../../src/features/profile/sub_feature/past_call/presentation/past_call.dart';
import '../../src/features/profile/sub_feature/privacy_policy/presentation/privacy_policy.dart';
import '../../src/features/profile/sub_feature/sent_request/presentation/sent_request_page.dart';
import '../../src/features/splash/presentation/splash_screen.dart';
import '../../src/features/transection_history/presentation/transaction_history.dart';
import 'build_page_with_transition.dart';

import '../../src/features/message/presentation/message_screen/message_screen.dart';

class RouteConfig {
  GoRouter goRouter = GoRouter(
     initialLocation: RouteName.studentDetailsScreen,


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
            transitionType: PageTransitionType.slideRightToLeft,
            context: context,
            state: state,
            child: PaymentMethodScreen());}
          ),



      GoRoute(
          name: RouteName.expertDetailsScreen,
          path: RouteName.expertDetailsScreen,
          pageBuilder: (context, state) {
            return buildPageWithTransition(
                transitionType: PageTransitionType.slideRightToLeft,
                context: context,
                state: state,
                child: ExpertDetailsScreen(),);}
      ),



 GoRoute(
        name: RouteName.globalNotificationScreen,
        path: RouteName.globalNotificationScreen,
        pageBuilder: (context, state) {
          return buildPageWithTransition(
            transitionType: PageTransitionType.slideRightToLeft,
            context: context,
            state: state,
            child: GlobalNotificationScreen());}
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
        name: RouteName.notification,
        path: RouteName.notification,
        pageBuilder: (context, state) {
          return const MaterialPage(child: NotificationScreen());
        },
      ),
        GoRoute(
        name: RouteName.languageScreen,
        path: RouteName.languageScreen,
        pageBuilder: (context, state) {
          return const MaterialPage(child: LanguageScreen());
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


      GoRoute(
          name: RouteName.authenticationScreen,
          path: RouteName.authenticationScreen,
          pageBuilder: (context, state) {
            return buildPageWithTransition(
                transitionType: PageTransitionType.slideRightToLeft,
                context: context,
                state: state,
                child: AuthenticationScreen());}
      ),
      GoRoute(
          name: RouteName.helpAndSupport,
          path: RouteName.helpAndSupport,
          pageBuilder: (context, state) {
            return const MaterialPage(child: HelpAndSupport());
          }
      ),
      GoRoute(
          name: RouteName.studentDetailsScreen,
          path: RouteName.studentDetailsScreen,
          pageBuilder: (context, state) {
            return const MaterialPage(child: StudentDetailsScreen());
          }
      ),

    ],
  );
}
