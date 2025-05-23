// ignore_for_file: file_names

import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/core/routes/route_name.dart';
import 'package:e_learning_app/src/features/profile/presentation/be%20a%20expert/main%20bottomsheets/be_a_expert_sheet.dart';
import 'package:e_learning_app/src/features/profile/sub_feature/widgets/profile_container.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'logout_dialog.dart';

List<Widget> callContainerGeneral(BuildContext context) {
  List<Widget> profileContainerList = [
    ProfileContainer(
      title: "Profile",
      icon: AppIcons.userAcc,
      onTap: () {
        debugPrint("tap hoitase");
        context.push(RouteName.userProfile);
      },
    ),
    ProfileContainer(
      title: "Be A Expert",
      icon: AppIcons.userAdd,
      onTap: () {
        showBeExpertBottomSheet(context);
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

List<Widget> callContainerPreferences(BuildContext context) {
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
        context.push(RouteName.helpAndSupport);
      },
    ),
    ProfileContainer(title: "Logout", icon: AppIcons.logout, onTap: () {
      showLogoutDialog(context);
    }),
  ];
  return profilePreferenceList;
}
