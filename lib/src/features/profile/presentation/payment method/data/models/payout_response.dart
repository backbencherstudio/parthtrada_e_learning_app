class PayoutResponse {
  final bool? success;
  final String? message;
  final PayoutData? data;

  PayoutResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory PayoutResponse.fromJson(Map<String, dynamic> json) {
    return PayoutResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? PayoutData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class PayoutData {
  final String? id;
  final String? object;
  final int? amount;
  final dynamic applicationFee;
  final dynamic applicationFeeAmount;
  final int? arrivalDate;
  final bool? automatic;
  final String? balanceTransaction;
  final int? created;
  final String? currency;
  final String? description;
  final String? destination;
  final dynamic failureBalanceTransaction;
  final dynamic failureCode;
  final dynamic failureMessage;
  final bool? livemode;
  final Map<String, dynamic>? metadata;
  final String? method;
  final dynamic originalPayout;
  final dynamic payoutMethod;
  final String? reconciliationStatus;
  final dynamic reversedBy;
  final String? sourceType;
  final String? statementDescriptor;
  final String? status;
  final TraceId? traceId;
  final String? type;

  PayoutData({
    this.id,
    this.object,
    this.amount,
    this.applicationFee,
    this.applicationFeeAmount,
    this.arrivalDate,
    this.automatic,
    this.balanceTransaction,
    this.created,
    this.currency,
    this.description,
    this.destination,
    this.failureBalanceTransaction,
    this.failureCode,
    this.failureMessage,
    this.livemode,
    this.metadata,
    this.method,
    this.originalPayout,
    this.payoutMethod,
    this.reconciliationStatus,
    this.reversedBy,
    this.sourceType,
    this.statementDescriptor,
    this.status,
    this.traceId,
    this.type,
  });

  factory PayoutData.fromJson(Map<String, dynamic> json) {
    return PayoutData(
      id: json['id'],
      object: json['object'],
      amount: json['amount'],
      applicationFee: json['application_fee'],
      applicationFeeAmount: json['application_fee_amount'],
      arrivalDate: json['arrival_date'],
      automatic: json['automatic'],
      balanceTransaction: json['balance_transaction'],
      created: json['created'],
      currency: json['currency'],
      description: json['description'],
      destination: json['destination'],
      failureBalanceTransaction: json['failure_balance_transaction'],
      failureCode: json['failure_code'],
      failureMessage: json['failure_message'],
      livemode: json['livemode'],
      metadata: (json['metadata'] ?? {}) as Map<String, dynamic>,
      method: json['method'],
      originalPayout: json['original_payout'],
      payoutMethod: json['payout_method'],
      reconciliationStatus: json['reconciliation_status'],
      reversedBy: json['reversed_by'],
      sourceType: json['source_type'],
      statementDescriptor: json['statement_descriptor'],
      status: json['status'],
      traceId: json['trace_id'] != null ? TraceId.fromJson(json['trace_id']) : null,
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'object': object,
      'amount': amount,
      'application_fee': applicationFee,
      'application_fee_amount': applicationFeeAmount,
      'arrival_date': arrivalDate,
      'automatic': automatic,
      'balance_transaction': balanceTransaction,
      'created': created,
      'currency': currency,
      'description': description,
      'destination': destination,
      'failure_balance_transaction': failureBalanceTransaction,
      'failure_code': failureCode,
      'failure_message': failureMessage,
      'livemode': livemode,
      'metadata': metadata,
      'method': method,
      'original_payout': originalPayout,
      'payout_method': payoutMethod,
      'reconciliation_status': reconciliationStatus,
      'reversed_by': reversedBy,
      'source_type': sourceType,
      'statement_descriptor': statementDescriptor,
      'status': status,
      'trace_id': traceId?.toJson(),
      'type': type,
    };
  }
}

class TraceId {
  final String? status;
  final dynamic value;

  TraceId({this.status, this.value});

  factory TraceId.fromJson(Map<String, dynamic> json) {
    return TraceId(
      status: json['status'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'value': value,
    };
  }
}
