import 'package:e_learning_app/core/constant/images.dart';
import 'package:e_learning_app/src/features/schedule/riverpod/schedule_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/meeting_model.dart';

final scheduleProvider = StateNotifierProvider<ScheduleRiverpod, ScheduleState>(
  (ref) => ScheduleRiverpod(),
);

class ScheduleRiverpod extends StateNotifier<ScheduleState> {
  ScheduleRiverpod() : super(ScheduleState()) {
    fetchMeetingList();
  }

  final List<Map<String, dynamic>> dummyMeetingSchedule = [
    {
      "profilePicture": AppImages.women,
      "userName": "Sarah Chen",
      "designation": "Senior Data Scientist at Google",
      "scheduleDate": "June 1 Monday 02:00 PM",
      "status": "pending",
    },
    {
      "profilePicture": AppImages.men,
      "userName": "Nahidul Islam Shakin",
      "designation": "Senior Software Engineer at Apple",
      "scheduleDate": "June 1 Monday 02:00 PM",
      "status": "accepted",
    },
    {
      "profilePicture": AppImages.men,
      "userName": "Nahidul Islam",
      "designation": "Senior Software Engineer at Google",
      "scheduleDate": "June 1 Monday 02:00 PM",
      "status": "canceled",
    },
    {
      "profilePicture": AppImages.men,
      "userName": "Md. Shakin",
      "designation": "Senior Software Engineer at Meta",
      "scheduleDate": "June 1 Monday 02:00 PM",
      "status": "completed",
    },
    {
      "profilePicture": AppImages.men,
      "userName": "Md. Shakin",
      "designation": "Senior Software Engineer at Meta",
      "scheduleDate": "June 1 Monday 02:00 PM",
      "status": "no response",
    },
    {
      "profilePicture": AppImages.men,
      "userName": "Md. Shakin",
      "designation": "Senior Software Engineer at Meta",
      "scheduleDate": "June 1 Monday 02:00 PM",
      "status": "completed",
    },
  ];

  Future<void> fetchMeetingList() async {
    final meetingList =
        dummyMeetingSchedule
            .map((meeting) => MeetingScheduleModel.fromJson(meeting))
            .toList();
    state = state.copyWith(meetingList: meetingList);
  }
}
