import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theme/theme_part/app_colors.dart';

class InboxScreenHeaderWidget extends StatelessWidget {
  final String image;
  final String name;

  const InboxScreenHeaderWidget({
    super.key,
    required this.image,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_outlined,
            size: 24,
            color: AppColors.onSecondary,
          ),
        ),
        const SizedBox(width: 12),
        ClipOval(
          child: SizedBox(
            height: 40.h,
            width: 40.w,
            child: Image.network(
              image,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                          (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                }
              },
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                spacing: 4.w,
                children: [
                  Icon(Icons.circle,color: AppColors.primary,size: 10.r,),
                  Text('Online',style: textTheme.labelSmall!.copyWith(color: AppColors.primary,),)
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
