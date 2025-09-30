class SkillModel {
  final bool success;
  final String message;
  final List<String> data;

  SkillModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SkillModel.fromJson(Map<String, dynamic> json) {
    return SkillModel(
      success: json['success'],
      message: json['message'],
      data: List<String>.from(json['data'] ?? []),
    );
  }
}
