class HomeStatModel {
  final bool success;
  final String message;
  final StatsData data;

  HomeStatModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory HomeStatModel.fromJson(Map<String, dynamic> json) {
    return HomeStatModel(
      success: json['success'],
      message: json['message'],
      data: StatsData.fromJson(json['data']),
    );
  }
}

class StatsData {
  final int mentors;
  final int sessions;
  final int users;
  final String rating;

  StatsData({
    required this.mentors,
    required this.sessions,
    required this.users,
    required this.rating,
  });

  factory StatsData.fromJson(Map<String, dynamic> json) {
    return StatsData(
      mentors: json['mentors'],
      sessions: json['sessions'],
      users: json['users'],
      rating: json['rating'],
    );
  }
}
