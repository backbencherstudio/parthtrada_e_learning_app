class SkillsModel {
  bool? success;
  String? message;
  List<String>? data;

  SkillsModel({this.success, this.message, this.data});

  factory SkillsModel.fromJson(Map<String, dynamic> json) {
    return SkillsModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? List<String>.from(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data,
    };
  }
}
