class AcceptRejectResponseModel {
  final bool success;
  final String message;

  AcceptRejectResponseModel({
    required this.success,
    required this.message,
  });

  factory AcceptRejectResponseModel.fromJson(Map<String, dynamic> json) {
    return AcceptRejectResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
