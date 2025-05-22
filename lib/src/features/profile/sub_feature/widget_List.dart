import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/core/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../presentation/be a expert/main bottomsheets/be_a_expert_sheet.dart';
import 'widgets/profile_container.dart';

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
      onTap: () {},
    ),
    ProfileContainer(
      title: "Language",
      icon: AppIcons.globalIcon,
      onTap: () {},
    ),
    ProfileContainer(
      title: "Past Calls",
      icon: AppIcons.icbaseline,
      onTap: () {},
    ),
    ProfileContainer(
      title: "Transaction History",
      icon: AppIcons.icbaseline,
      onTap: () {},
    ),
    ProfileContainer(
      title: "Sent Requests",
      icon: AppIcons.icbaseline,
      onTap: () {},
    ),
  ];
  return profileContainerList;
}

List<Widget> callContainerPreferences(BuildContext context) {
  List<Widget> profilePreferenceList = [
    ProfileContainer(
      title: "Privacy Policy",
      icon: AppIcons.security,
      onTap: () {},
    ),
    ProfileContainer(
      title: "Help & Support",
      icon: AppIcons.frameIcon,
      onTap: () {},
    ),
    ProfileContainer(title: "Logout", icon: AppIcons.logout, onTap: () {}),
  ];
  return profilePreferenceList;
}
