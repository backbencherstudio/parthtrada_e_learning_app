class SendRequestResponse {
  final bool success;
  final String message;
  final List<SendRequest> data;
  final Pagination pagination;

  SendRequestResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.pagination,
  });

  factory SendRequestResponse.fromJson(Map<String, dynamic> json) {
    return SendRequestResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List)
          .map((e) => SendRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data.map((e) => e.toJson()).toList(),
    'pagination': pagination.toJson(),
  };
}

class SendRequest {
  final String id;
  final String name;
  final String? image;
  final String description;
  final int duration;
  final DateTime date;

  SendRequest({
    required this.id,
    required this.name,
    this.image,
    required this.description,
    required this.duration,
    required this.date,
  });

  factory SendRequest.fromJson(Map<String, dynamic> json) {
    return SendRequest(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String?,
      description: json['description'] as String,
      duration: json['duration'] as int,
      date: DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image': image,
    'description': description,
    'duration': duration,
    'date': date.toIso8601String(),
  };
}

class Pagination {
  final int total;
  final int page;
  final int perPage;
  final int totalPages;
  final bool hasNextPage;
  final bool hasPrevPage;

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
      total: json['total'] as int,
      page: json['page'] as int,
      perPage: json['perPage'] as int,
      totalPages: json['totalPages'] as int,
      hasNextPage: json['hasNextPage'] as bool,
      hasPrevPage: json['hasPrevPage'] as bool,
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
