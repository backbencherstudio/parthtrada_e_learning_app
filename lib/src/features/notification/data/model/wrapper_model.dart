
import 'package:e_learning_app/src/features/notification/data/model/notification_model.dart';
import 'package:e_learning_app/src/features/notification/data/model/student/student_model.dart';

class StudentNotificationArgs {
  final StudentData studentData;
  final NotificationItem notificationItem;

  StudentNotificationArgs({
    required this.studentData,
    required this.notificationItem,
  });
}
