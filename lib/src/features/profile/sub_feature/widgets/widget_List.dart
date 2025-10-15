// ignore_for_file: file_names

import 'dart:core';

import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/core/routes/route_name.dart';
import 'package:e_learning_app/core/services/local_storage_services/user_id_storage.dart';
import 'package:e_learning_app/core/services/local_storage_services/user_type_storage.dart';
import 'package:e_learning_app/src/features/profile/presentation/be%20a%20expert/main%20bottomsheets/be_a_expert_sheet.dart';
import 'package:e_learning_app/src/features/profile/sub_feature/widgets/profile_container.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../repository/login_preferences.dart';

Future <List<Widget>> callContainerGeneral(BuildContext context) async {
  final userType = await UserTypeStorage().getUserType();

  List<Widget> profileContainerList = [
    ProfileContainer(
      title: "Profile",
      icon: AppIcons.userAcc,
      onTap: () {
        debugPrint("tap hoitase");
        context.push(RouteName.userProfile);
      },
    ),

    if( userType == "STUDENT")
    ProfileContainer(
      title: "Be A Expert",
      icon: AppIcons.userAdd,
      onTap: () {
        showBeExpertBottomSheet(context);
      },
    ),

    if(userType == "STUDENT")
    ProfileContainer(
      title: "Payment Method",
      icon: AppIcons.creditCard,
      onTap: () {
        context.push(RouteName.paymentMethodScreen);
      },
    ),

    if(userType == "EXPERT")
    ProfileContainer(
      title: "Payout Method",
      icon: AppIcons.creditCard,
      onTap: () {
        context.push(RouteName.payoutMethodScreen);
      },
    ),



    // ProfileContainer(
    //   title: "Notifications",
    //   icon: AppIcons.notification,
    //   onTap: () {
    //     context.push(RouteName.notification);
    //   },
    // ),
    // ProfileContainer(
    //   title: "Language",
    //   icon: AppIcons.globalIcon,
    //   onTap: () {
    //     context.push(RouteName.languageScreen);
    //   },
    // ),
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
        context.push(RouteName.helpAndSupportScreen);
      },
    ),
    ProfileContainer(title: "Logout", icon: AppIcons.logout, onTap: () async {
      await LoginPreferences().clearAuthToken();
      await UserTypeStorage().clearUserType();
      await UserIdStorage().clearUserId();
      context.pushReplacement(RouteName.authenticationScreen);
    }),
  ];
  return profilePreferenceList;
}
