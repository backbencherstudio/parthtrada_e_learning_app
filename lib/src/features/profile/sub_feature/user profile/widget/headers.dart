import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:e_learning_app/repository/linkedin_login_webview.dart';
import 'package:e_learning_app/src/features/profile/model/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;

class Headers extends StatelessWidget {
  final UserProfile? userInformation;
  const Headers({super.key, required this.userInformation});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: SvgPicture.asset(AppIcons.backlongArrow),
        ),
        SizedBox(width: 70.w),
        CircleAvatar(
          radius: 140.w / 2,
          backgroundImage:
              userInformation?.image != null &&
                      userInformation?.image!.isNotEmpty == true
                  ? NetworkImage('$baseUrl/uploads/${userInformation?.image}')
                  : null,
          child:
              userInformation?.image == null || userInformation!.image!.isEmpty
                  ? Icon(Icons.person, size: 50)
                  : null,
        ),
        Spacer(),
        CommonWidget.notificationWidget(context),
      ],
    );
  }
}
