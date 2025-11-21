import 'package:e_learning_app/core/constant/icons.dart';
import 'package:e_learning_app/core/constant/images.dart';
import 'package:e_learning_app/core/utils/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;

class Headers extends StatelessWidget {
  final String? imageUrl;

  const Headers({
    super.key,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 22,
          ),
        ),
        SizedBox(width: 70.w),

        // Circular Profile Image (Network or Asset)
        _buildCircularImage(),

        const Spacer(),
        CommonWidget.notificationWidget(context),
      ],
    );
  }

  Widget _buildCircularImage() {
    final bool hasValidUrl = imageUrl != null && imageUrl!.trim().isNotEmpty;

    return Container(
      height: 140.h,
      width: 140.w,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: hasValidUrl
            ? Image.network(
          imageUrl!,
          height: 140.h,
          width: 140.w,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _fallbackImage();
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
              ),
            );
          },
        )
            : _fallbackImage(),
      ),
    );
  }

  Widget _fallbackImage() {
    return Image.asset(
      AppImages.maiya,
      height: 140.h,
      width: 140.w,
      fit: BoxFit.cover,
    );
  }
}