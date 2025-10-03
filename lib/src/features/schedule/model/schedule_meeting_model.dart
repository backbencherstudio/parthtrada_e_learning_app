class ScheduleMeetingModel {
  bool success;
  String message;
  List<Booking> data;
  Pagination pagination;

  ScheduleMeetingModel({
    required this.success,
    required this.message,
    required this.data,
    required this.pagination,
  });

  factory ScheduleMeetingModel.fromJson(Map<String, dynamic> json) {
    return ScheduleMeetingModel(
      success: json['success'],
      message: json['message'],
      data: List<Booking>.from(json['data'].map((x) => Booking.fromJson(x))),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': List<dynamic>.from(data.map((x) => x.toJson())),
    'pagination': pagination.toJson(),
  };
}

class Booking {
  String id;
  String studentId;
  String expertId;
  DateTime date;
  DateTime expertDateTime;
  DateTime studentDateTime;
  String meetingLink;
  String sessionDetails;
  int sessionDuration;
  String status;
  String? answer1;
  String? answer2;
  String? answer3;
  DateTime createdAt;
  DateTime updatedAt;
  String? review;
  bool shouldReview;

  Booking({
    required this.id,
    required this.studentId,
    required this.expertId,
    required this.date,
    required this.expertDateTime,
    required this.studentDateTime,
    required this.meetingLink,
    required this.sessionDetails,
    required this.sessionDuration,
    required this.status,
    this.answer1,
    this.answer2,
    this.answer3,
    required this.createdAt,
    required this.updatedAt,
    this.review,
    required this.shouldReview,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      studentId: json['studentId'],
      expertId: json['expertId'],
      date: DateTime.parse(json['date']),
      expertDateTime: DateTime.parse(json['expertDateTime']),
      studentDateTime: DateTime.parse(json['studentDateTime']),
      meetingLink: json['meetingLink'],
      sessionDetails: json['sessionDetails'],
      sessionDuration: json['sessionDuration'],
      status: json['status'],
      answer1: json['answer1'],
      answer2: json['answer2'],
      answer3: json['answer3'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      review: json['review'],
      shouldReview: json['should_review'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'studentId': studentId,
    'expertId': expertId,
    'date': date.toIso8601String(),
    'expertDateTime': expertDateTime.toIso8601String(),
    'studentDateTime': studentDateTime.toIso8601String(),
    'meetingLink': meetingLink,
    'sessionDetails': sessionDetails,
    'sessionDuration': sessionDuration,
    'status': status,
    'answer1': answer1,
    'answer2': answer2,
    'answer3': answer3,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'review': review,
    'should_review': shouldReview,
  };
}

class Pagination {
  int total;
  int page;
  int perPage;
  int totalPages;
  bool hasNextPage;
  bool hasPrevPage;

  Pagination({
    required this.total,
    required this.page,
    required this.perPage,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPrevPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      total: json['total'],
      page: json['page'],
      perPage: json['perPage'],
      totalPages: json['totalPages'],
      hasNextPage: json['hasNextPage'],
      hasPrevPage: json['hasPrevPage'],
    );
  }

  Map<String, dynamic> toJson() => {
    'total': total,
    'page': page,
    'perPage': perPage,
    'totalPages': totalPages,
    'hasNextPage': hasNextPage,
    'hasPrevPage': hasPrevPage,
  };
}
