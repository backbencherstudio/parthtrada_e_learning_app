class BookingResponse {
  final bool success;
  final String message;
  final BookingData data;

  BookingResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory BookingResponse.fromJson(Map<String, dynamic> json) {
    return BookingResponse(
      success: json['success'],
      message: json['message'],
      data: BookingData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class BookingData {
  final String bookingId;
  final int amount;
  final String paymentIntentId;

  BookingData({
    required this.bookingId,
    required this.amount,
    required this.paymentIntentId,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) {
    return BookingData(
      bookingId: json['bookingId'],
      amount: json['amount'],
      paymentIntentId: json['paymentIntentId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookingId': bookingId,
      'amount': amount,
      'paymentIntentId': paymentIntentId,
    };
  }
}
