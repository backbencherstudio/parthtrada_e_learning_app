import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:e_learning_app/repository/api/profile_api/fetch_me.dart';
import 'package:e_learning_app/repository/linkedin_login_webview.dart';
import 'package:e_learning_app/src/features/onboarding/riverpod/login_state.dart';
import 'package:e_learning_app/src/features/profile/sub_feature/widgets/widget_List.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Future.delayed(Duration(milliseconds: 100), () {
      final token = ref.watch(authTokenProvider);
      if (token != null) {
        ref.read(aboutMeNotifierProvider.notifier).fetchUserProfile(token);
      }
    });
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if (!_dataFetched) {
  //     final token = ref.watch(authTokenProvider);
  //     if (token != null) {
  //       ref.read(aboutMeNotifierProvider.notifier).fetchUserProfile(token);
  //       _dataFetched = true;
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final userInformation = ref.watch(aboutMeNotifierProvider);

    if (userInformation == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 67.h),

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: SizedBox()),
                        Expanded(child: SizedBox()),
                        CircleAvatar(
                          radius: 80,
                          backgroundImage:
                              userInformation.image != null &&
                                      userInformation.image!.isNotEmpty
                                  ? NetworkImage(
                                    '$baseUrl/uploads/${userInformation.image}',
                                  )
                                  : null,
                          child:
                              userInformation.image == null ||
                                      userInformation.image!.isEmpty
                                  ? Icon(Icons.person, size: 50)
                                  : null,
                        ),

                        Expanded(child: SizedBox()),

                        Flexible(
                          child: CommonWidget.notificationWidget(context),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    // userInformation.name!,
                    userInformation.name ?? "No Name Available",
                    style: textStyle.titleSmall!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Color(0xffffffff),
                    ),
                  ),
                  Text(
                    // userInformation.meta!.profession!,
                    userInformation.meta?.profession ??
                        "No Profession Available",
                    style: textStyle.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Color(0xffA5A5AB),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "General",
                  style: textStyle.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              SizedBox(height: 18.h),
              ...callContainerGeneral(context, ref),
              SizedBox(height: 28.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Preferencess",
                  style: textStyle.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              SizedBox(height: 18.h),
              ...callContainerPreferencess(context),
              SizedBox(height: 18.h),
            ],
          ),
        ),
      ),
    );
  }
}
