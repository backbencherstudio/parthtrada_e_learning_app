import '../model/meeting_model.dart';

class ScheduleState {
  List<MeetingScheduleModel>? meetingList;
  ScheduleState({this.meetingList});
  ScheduleState copyWith({List<MeetingScheduleModel>? meetingList}) {
    return ScheduleState(meetingList: meetingList ?? this.meetingList);
  }
}
