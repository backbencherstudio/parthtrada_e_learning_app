class CardsResponse {
  final bool success;
  final String message;
  final List<CardModel> data;

  CardsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CardsResponse.fromJson(Map<String, dynamic> json) {
    return CardsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>? ?? [])
          .map((item) => CardModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class CardModel {
  final String id;
  final String provider;
  final String methodId;
  final String brand;
  final String last4;
  final int expMonth;
  final int expYear;
  final String userId;

  CardModel({
    required this.id,
    required this.provider,
    required this.methodId,
    required this.brand,
    required this.last4,
    required this.expMonth,
    required this.expYear,
    required this.userId,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'] ?? '',
      provider: json['provider'] ?? '',
      methodId: json['method_id'] ?? '',
      brand: json['brand'] ?? '',
      last4: json['last4'] ?? '',
      expMonth: json['expMonth'] ?? 0,
      expYear: json['expYear'] ?? 0,
      userId: json['userId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'provider': provider,
      'method_id': methodId,
      'brand': brand,
      'last4': last4,
      'expMonth': expMonth,
      'expYear': expYear,
      'userId': userId,
    };
  }
}
