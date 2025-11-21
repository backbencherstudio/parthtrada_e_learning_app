class ExpertScheduleMeetingModel {
  final bool success;
  final String message;
  final ScheduleData? data; // nested data object

  ExpertScheduleMeetingModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory ExpertScheduleMeetingModel.fromJson(Map<String, dynamic> json) {
    return ExpertScheduleMeetingModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? ScheduleData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

class ScheduleData {
  final List<Booking>? bookings;
  final Pagination? pagination;

  ScheduleData({
    this.bookings,
    this.pagination,
  });

  factory ScheduleData.fromJson(Map<String, dynamic> json) {
    return ScheduleData(
      bookings: json['bookings'] != null
          ? List<Booking>.from(
        (json['bookings'] as List).map(
              (x) => Booking.fromJson(x as Map<String, dynamic>),
        ),
      )
          : [],
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'] as Map<String, dynamic>)
          : null,
    );
  }
}

class Booking {
  final String id;
  final String studentId;
  final String expertId;
  final DateTime date;
  final DateTime expertDateTime;
  final DateTime studentDateTime;
  final String meetingLink;
  final String sessionDetails;
  final int sessionDuration;
  final String status;
  final String? refundReason;
  final String? answer1;
  final String? answer2;
  final String? answer3;
  final DateTime createdAt;
  final DateTime updatedAt;

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
    this.refundReason,
    this.answer1,
    this.answer2,
    this.answer3,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] ?? '',
      studentId: json['studentId'] ?? '',
      expertId: json['expertId'] ?? '',
      date: json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
      expertDateTime: json['expertDateTime'] != null
          ? DateTime.parse(json['expertDateTime'])
          : DateTime.now(),
      studentDateTime: json['studentDateTime'] != null
          ? DateTime.parse(json['studentDateTime'])
          : DateTime.now(),
      meetingLink: json['meetingLink'] ?? '',
      sessionDetails: json['sessionDetails'] ?? '',
      sessionDuration: json['sessionDuration'] ?? 0,
      status: json['status'] ?? '',
      refundReason: json['refund_reason'],
      answer1: json['answer1'],
      answer2: json['answer2'],
      answer3: json['answer3'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
    );
  }
}

class Pagination {
  final int? total;
  final int? page;
  final int? perPage;
  final int? totalPages;
  final bool? hasNextPage;
  final bool? hasPrevPage;

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
      total: json['total'] ?? 0,
      page: json['page'] ?? 1,
      perPage: json['perPage'] ?? 10,
      totalPages: json['totalPages'] ?? 1,
      hasNextPage: json['hasNextPage'] ?? false,
      hasPrevPage: json['hasPrevPage'] ?? false,
    );
  }
}
