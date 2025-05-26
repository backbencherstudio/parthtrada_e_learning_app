import 'package:e_learning_app/core/constant/images.dart';
import 'package:e_learning_app/src/features/notification/model/notification_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final expertNotiProvider =
    StateNotifierProvider<ExpertNotifier, List<NotificationModel>>((ref) {
      return ExpertNotifier();
    });

class ExpertNotifier extends StateNotifier<List<NotificationModel>> {
  ExpertNotifier()
    : super([
        NotificationModel(
          title: "Jenny Wilson",
          discription: "Wants to take your consultation on June 13th at 3 PM.",
          img: AppImages.bedi,
          isRefund: false,
        ),

        NotificationModel(
          title: "Jenny Wilson",
          discription: "Sent you refund request \$150.",
          img: AppImages.bedi,
          isRefund: true,
        ),
        NotificationModel(
          title: "Jenny Wilson",
          discription: "Sent you refund request \$150.",
          img: AppImages.bedi,
          isRefund: true,
        ),
        NotificationModel(
          title: "Jenny Wilson",
          discription: "Wants to take your consultation on June 13th at 3 PM.",
          img: AppImages.bedi,
          isRefund: false,
        ),
      ]);
}
