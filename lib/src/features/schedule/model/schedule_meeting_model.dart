class ScheduleMeetingModel {
  bool success;
  String message;
  List<Booking> data;
  Pagination? pagination;

  ScheduleMeetingModel({
    required this.success,
    required this.message,
    required this.data,
    this.pagination,
  });

  factory ScheduleMeetingModel.fromJson(Map<String, dynamic> json) {
    return ScheduleMeetingModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data:
          json['data'] == null
              ? []
              : (json['data'] is List
                  ? List<Booking>.from(
                    json['data'].map(
                      (x) => Booking.fromJson(x as Map<String, dynamic>),
                    ),
                  )
                  : [Booking.fromJson(json['data'] as Map<String, dynamic>)]),
      pagination:
          json['pagination'] != null
              ? Pagination.fromJson(json['pagination'] as Map<String, dynamic>)
              : null,
    );
  }
}

class Booking {
  String id;
  String studentId;
  String expertId;
  DateTime date;
  DateTime expertDateTime;
  DateTime studentDateTime;
  String? meetingLink;
  String sessionDetails;
  int sessionDuration;
  String status;
  String? refundReason;
  String? answer1;
  String? answer2;
  String? answer3;
  String? notificationId;
  DateTime createdAt;
  DateTime updatedAt;
  Review? review;
  bool? shouldReview;
  bool? shouldRefund;

  Booking({
    required this.id,
    required this.studentId,
    required this.expertId,
    required this.date,
    required this.expertDateTime,
    required this.studentDateTime,
    this.meetingLink,
    required this.sessionDetails,
    required this.sessionDuration,
    required this.status,
    this.refundReason,
    this.answer1,
    this.answer2,
    this.answer3,
    this.notificationId,
    required this.createdAt,
    required this.updatedAt,
    this.review,
    this.shouldReview,
    this.shouldRefund,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] ?? '',
      studentId: json['studentId'] ?? '',
      expertId: json['expertId'] ?? '',
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      expertDateTime: DateTime.parse(
        json['expertDateTime'] ?? DateTime.now().toIso8601String(),
      ),
      studentDateTime: DateTime.parse(
        json['studentDateTime'] ?? DateTime.now().toIso8601String(),
      ),
      meetingLink: json['meetingLink'] ?? '',
      sessionDetails: json['sessionDetails'] ?? '',
      sessionDuration: json['sessionDuration'] ?? 0,
      status: json['status'] ?? '',
      refundReason: json['refund_reason'],
      answer1: json['answer1'],
      answer2: json['answer2'],
      answer3: json['answer3'],
      notificationId: json['notification_id'],
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        json['updatedAt'] ?? DateTime.now().toIso8601String(),
      ),
      review: json['review'] != null ? Review.fromJson(json['review']) : null,
      shouldReview: json['should_review'] ?? null,
      shouldRefund: json['should_refund'] ?? null,
    );
  }
}

class Review {
  final String? id;

  Review({this.id});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(id: json['id']);
  }
}

class Pagination {
  int? total;
  int? page;
  int? perPage;
  int? totalPages;
  bool? hasNextPage;
  bool? hasPrevPage;

  Pagination({
    this.total,
    this.page,
    this.perPage,
    this.totalPages,
    this.hasNextPage,
    this.hasPrevPage,
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
