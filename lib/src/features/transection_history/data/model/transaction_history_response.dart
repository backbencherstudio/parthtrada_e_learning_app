class TransactionHistoryResponse {
  bool? success;
  String? message;
  List<Data>? data;
  Pagination? pagination;

  TransactionHistoryResponse({
    this.success,
    this.message,
    this.data,
    this.pagination,
  });

  TransactionHistoryResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'] as bool?;
    message = json['message'] as String?;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v as Map<String, dynamic>));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }

  TransactionHistoryResponse copyWith({
    bool? success,
    String? message,
    List<Data>? data,
    Pagination? pagination,
  }) {
    return TransactionHistoryResponse(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
      pagination: pagination ?? this.pagination,
    );
  }
}

class Data {
  String? name;
  String? status;
  String? refundReason;
  String? id;
  double? amount;
  String? createdAt;
  String? updatedAt;
  bool? refunded;
  bool? withdraw;

  Data({
    this.name,
    this.status,
    this.refundReason,
    this.id,
    this.amount,
    this.createdAt,
    this.updatedAt,
    this.refunded,
    this.withdraw,
  });

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    status = json['status'] as String?;
    refundReason = json['refund_reason'] as String?;
    id = json['id'] as String?;
    amount = (json['amount'] is int)
        ? (json['amount'] as int).toDouble()
        : json['amount'] as double?;
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    refunded = json['refunded'] as bool?;
    withdraw = json['withdraw'] as bool?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['status'] = status;
    data['refund_reason'] = refundReason;
    data['id'] = id;
    data['amount'] = amount;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['refunded'] = refunded;
    data['withdraw'] = withdraw;
    return data;
  }

  Data copyWith({
    String? name,
    String? status,
    String? refundReason,
    String? id,
    double? amount,
    String? createdAt,
    String? updatedAt,
    bool? refunded,
    bool? withdraw,
  }) {
    return Data(
      name: name ?? this.name,
      status: status ?? this.status,
      refundReason: refundReason ?? this.refundReason,
      id: id ?? this.id,
      amount: amount ?? this.amount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      refunded: refunded ?? this.refunded,
      withdraw: withdraw ?? this.withdraw,
    );
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

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'] as int?;
    page = json['page'] as int?;
    perPage = json['perPage'] as int?;
    totalPages = json['totalPages'] as int?;
    hasNextPage = json['hasNextPage'] as bool?;
    hasPrevPage = json['hasPrevPage'] as bool?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['page'] = page;
    data['perPage'] = perPage;
    data['totalPages'] = totalPages;
    data['hasNextPage'] = hasNextPage;
    data['hasPrevPage'] = hasPrevPage;
    return data;
  }

  Pagination copyWith({
    int? total,
    int? page,
    int? perPage,
    int? totalPages,
    bool? hasNextPage,
    bool? hasPrevPage,
  }) {
    return Pagination(
      total: total ?? this.total,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      totalPages: totalPages ?? this.totalPages,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      hasPrevPage: hasPrevPage ?? this.hasPrevPage,
    );
  }
}