// ignore_for_file: file_names

import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/core/routes/route_name.dart';
import 'package:e_learning_app/repository/api/profile_api/fetch_me.dart';
import 'package:e_learning_app/src/features/profile/presentation/be%20a%20expert/main%20bottomsheets/be_a_expert_sheet.dart';
import 'package:e_learning_app/src/features/profile/sub_feature/widgets/profile_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

List<Widget> callContainerGeneral(BuildContext context, [WidgetRef? ref]) {
  final userInformation = ref!.watch(aboutMeNotifierProvider);

  List<Widget> profileContainerList = [
    ProfileContainer(
      title: "Profile",
      icon: AppIcons.userAcc,
      onTap: () {
        context.push(RouteName.userProfile);
      },
    ),
    ProfileContainer(
      title:
          userInformation?.activeProfile == 'STUDENT'
              ? 'Be A Expert'
              : 'Be A Student',
      icon: AppIcons.userAdd,
      onTap: () {
        showBeExpertBottomSheet(context, userInformation, ref);
      },
    ),
    ProfileContainer(
      title: "Payment Method",
      icon: AppIcons.creditCard,
      onTap: () {
        context.push(RouteName.paymentMethodScreen);
      },
    ),
    ProfileContainer(
      title: "Notifications",
      icon: AppIcons.notification,
      onTap: () {
        context.push(RouteName.notification);
      },
    ),
    ProfileContainer(
      title: "Language",
      icon: AppIcons.globalIcon,
      onTap: () {
        context.push(RouteName.languageScreen);
      },
    ),
    ProfileContainer(
      title: "Past Calls",
      icon: AppIcons.icbaseline,
      onTap: () {
        context.push(RouteName.pastCall);
      },
    ),
    ProfileContainer(
      title: "Transaction History",
      icon: AppIcons.icbaseline,
      onTap: () {
        context.push(RouteName.transactionHistory);
      },
    ),
    ProfileContainer(
      title: "Sent Requests",
      icon: AppIcons.icbaseline,
      onTap: () {
        context.push(RouteName.sentRequest);
      },
    ),
  ];
  return profileContainerList;
}

List<Widget> callContainerPreferencess(BuildContext context) {
  List<Widget> profilePreferenceList = [
    ProfileContainer(
      title: "Privacy Policy",
      icon: AppIcons.security,
      onTap: () {
        context.push(RouteName.privacyPolicy);
      },
    ),
    ProfileContainer(
      title: "Help & Support",
      icon: AppIcons.frameIcon,
      onTap: () {
        context.push(RouteName.messageScreen);
      },
    ),
    ProfileContainer(title: "Logout", icon: AppIcons.logout, onTap: () {}),
  ];
  return profilePreferenceList;
}
