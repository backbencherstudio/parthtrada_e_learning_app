class PastCallsResponse {
  final bool success;
  final String message;
  final List<PastCall> data;
  final Pagination pagination;

  PastCallsResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.pagination,
  });

  factory PastCallsResponse.fromJson(Map<String, dynamic> json) {
    return PastCallsResponse(
      success: json['success'],
      message: json['message'],
      data: (json['data'] as List)
          .map((item) => PastCall.fromJson(item))
          .toList(),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data.map((item) => item.toJson()).toList(),
    'pagination': pagination.toJson(),
  };
}

class PastCall {
  final String id;
  final String name;
  final int duration;
  final DateTime date;
  final int amount;

  PastCall({
    required this.id,
    required this.name,
    required this.duration,
    required this.date,
    required this.amount,
  });

  factory PastCall.fromJson(Map<String, dynamic> json) {
    return PastCall(
      id: json['id'],
      name: json['name'],
      duration: json['duration'],
      date: DateTime.parse(json['date']),
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'duration': duration,
    'date': date.toIso8601String(),
    'amount': amount,
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
