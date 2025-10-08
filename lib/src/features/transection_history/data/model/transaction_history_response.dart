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
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
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
  int? amount;
  String? createdAt;

  Data({
    this.name,
    this.status,
    this.refundReason,
    this.id,
    this.amount,
    this.createdAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    status = json['status'];
    refundReason = json['refund_reason'];
    id = json['id'];
    amount = json['amount'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['status'] = status;
    data['refund_reason'] = refundReason;
    data['id'] = id;
    data['amount'] = amount;
    data['createdAt'] = createdAt;
    return data;
  }

  Data copyWith({
    String? name,
    String? status,
    String? refundReason,
    String? id,
    int? amount,
    String? createdAt,
  }) {
    return Data(
      name: name ?? this.name,
      status: status ?? this.status,
      refundReason: refundReason ?? this.refundReason,
      id: id ?? this.id,
      amount: amount ?? this.amount,
      createdAt: createdAt ?? this.createdAt,
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
    total = json['total'];
    page = json['page'];
    perPage = json['perPage'];
    totalPages = json['totalPages'];
    hasNextPage = json['hasNextPage'];
    hasPrevPage = json['hasPrevPage'];
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