enum MeetingStatus { completed, canceled, accepted, pending }

class MeetingScheduleModel {
  String profilePicture;
  String userName;
  String designation;
  String scheduleDate;
  String status;

  MeetingScheduleModel({
    required this.profilePicture,
    required this.userName,
    required this.designation,
    required this.scheduleDate,
    required this.status,
  });

  // Factory method to create an instance from JSON
  factory MeetingScheduleModel.fromJson(Map<String, dynamic> json) {
    return MeetingScheduleModel(
      profilePicture: json['profilePicture'] ?? '',
      userName: json['userName'] ?? '',
      designation: json['designation'] ?? '',
      scheduleDate: json['scheduleDate'] ?? '',
      status: json['status'] ?? '',
    );
  }

  // Method to convert the instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'profilePicture': profilePicture,
      'userName': userName,
      'designation': designation,
      'scheduleDate': scheduleDate,
      'status': status,
    };
  }
}
