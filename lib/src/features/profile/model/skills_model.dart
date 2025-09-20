class SkillsModel {
  bool? success;
  String? message;
  List<String>? data;
  Set<String> selectedSkills;
  SkillsModel({
    this.success,
    this.message,
    this.data,
    required this.selectedSkills,
  });

  factory SkillsModel.fromJson(Map<String, dynamic> json) {
    return SkillsModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? List<String>.from(json['data']) : [],
      selectedSkills:
          json['selectedSkills'] != null
              ? Set<String>.from(json['selectedSkills'])
              : {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data,
      'selectedSkills': selectedSkills.toList(),
    };
  }
}
