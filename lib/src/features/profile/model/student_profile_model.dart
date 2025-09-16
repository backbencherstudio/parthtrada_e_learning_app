import 'package:e_learning_app/src/features/profile/model/meta_model.dart';

class StudentMeta extends ProfileMeta {
  StudentMeta({
    String? id,
    String? profession,
    String? organization,
    String? location,
    String? description,
    String? userId,
  }) : super(
         id: id,
         profession: profession,
         organization: organization,
         location: location,
         description: description,
         userId: userId,
       );

  factory StudentMeta.fromJson(Map<String, dynamic> json) {
    return StudentMeta(
      id: json['id'],
      profession: json['profession'],
      organization: json['organization'],
      location: json['location'],
      description: json['description'],
      userId: json['userId'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profession': profession,
      'organization': organization,
      'location': location,
      'description': description,
      'userId': userId,
    };
  }
}
