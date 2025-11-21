class SessionModel {
  final String expertId;
  final String expertName;
  final String date;
  final String time;
  final int sessionDuration;
  final String sessionDetails;
  final String? currency;
  final String? hourlyRate;

  SessionModel({
    required this.expertId,
    required this.expertName,
    required this.date,
    required this.time,
    required this.sessionDuration,
    required this.sessionDetails,
    this.currency = 'usd',
    this.hourlyRate,
  });

  SessionModel copyWith({
    String? expertId,
    String? expertName,
    String? date,
    String? time,
    int? sessionDuration,
    String? sessionDetails,
    String? currency,
    String? hourlyRate
  }) {
    return SessionModel(
      expertId: expertId ?? this.expertId,
      expertName: expertName ?? this.expertName,
      date: date ?? this.date,
      time: time ?? this.time,
      sessionDuration: sessionDuration ?? this.sessionDuration,
      sessionDetails: sessionDetails ?? this.sessionDetails,
      currency: currency ?? this.currency,
      hourlyRate: hourlyRate ?? this.hourlyRate,
    );
  }
}
