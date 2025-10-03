import 'package:e_learning_app/src/features/schedule/model/schedule_meeting_model.dart';

class ScheduleState {
  ScheduleMeetingModel? meetingList;

  ScheduleState({this.meetingList});

  ScheduleState copyWith({ScheduleMeetingModel? meetingList}) {
    return ScheduleState(meetingList: meetingList ?? this.meetingList);
  }
}
