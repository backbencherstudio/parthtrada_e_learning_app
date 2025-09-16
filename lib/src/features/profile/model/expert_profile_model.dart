// import 'package:e_learning_app/src/features/profile/model/meta_model.dart';

// class ExpertMeta extends ProfileMeta {
//   final String? experience;
//   final String? hourlyRate;
//   final List<String>? skills;
//   final List<String>? availableDays;
//   final List<String>? availableTime;
//   final String? stripeAccountId;
//   final bool? isOnboardCompleted;

//   ExpertMeta({
//     String? id,
//     String? profession,
//     String? organization,
//     String? location,
//     String? description,
//     String? userId,
//     this.experience,
//     this.hourlyRate,
//     this.skills,
//     this.availableDays,
//     this.availableTime,
//     this.stripeAccountId,
//     this.isOnboardCompleted,
//   }) : super(
//          id: id,
//          profession: profession,
//          organization: organization,
//          location: location,
//          description: description,
//          userId: userId,
//        );

//   factory ExpertMeta.fromJson(Map<String, dynamic> json) {
//     return ExpertMeta(
//       id: json['id'],
//       profession: json['profession'],
//       organization: json['organization'],
//       location: json['location'],
//       description: json['description'],
//       userId: json['userId'],
//       experience: json['experience'],
//       hourlyRate: json['hourlyRate'],
//       skills: List<String>.from(json['skills'] ?? []),
//       availableDays: List<String>.from(json['availableDays'] ?? []),
//       availableTime: List<String>.from(json['availableTime'] ?? []),
//       stripeAccountId: json['stripeAccountId'],
//       isOnboardCompleted: json['isOnboardCompleted'],
//     );
//   }

//   @override
//   Map<String, dynamic> toJson() {
//     return {
//       ...super.toJson(),
//       'experience': experience,
//       'hourlyRate': hourlyRate,
//       'skills': skills,
//       'availableDays': availableDays,
//       'availableTime': availableTime,
//       'stripeAccountId': stripeAccountId,
//       'isOnboardCompleted': isOnboardCompleted,
//     };
//   }
// }

import 'package:e_learning_app/src/features/profile/model/meta_model.dart';

class ExpertMeta extends ProfileMeta {
  final String? experience;
  final String? hourlyRate;
  final List<String>? skills;
  final List<String>? availableDays;
  final List<String>? availableTime;
  final String? stripeAccountId;
  final bool? isOnboardCompleted;

  ExpertMeta({
    String? id,
    String? profession,
    String? organization,
    String? location,
    String? description,
    String? userId,
    this.experience,
    this.hourlyRate,
    this.skills,
    this.availableDays,
    this.availableTime,
    this.stripeAccountId,
    this.isOnboardCompleted,
  }) : super(
         id: id,
         profession: profession,
         organization: organization,
         location: location,
         description: description,
         userId: userId,
       );

  factory ExpertMeta.fromJson(Map<String, dynamic> json) {
    return ExpertMeta(
      id: json['id'],
      profession: json['profession'],
      organization: json['organization'],
      location: json['location'],
      description: json['description'],
      userId: json['userId'],
      experience: json['experience'],
      hourlyRate: json['hourlyRate'],
      skills: List<String>.from(json['skills'] ?? []),
      availableDays: List<String>.from(json['availableDays'] ?? []),
      availableTime: List<String>.from(json['availableTime'] ?? []),
      stripeAccountId: json['stripeAccountId'],
      isOnboardCompleted: json['isOnboardCompleted'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'experience': experience,
      'hourlyRate': hourlyRate,
      'skills': skills,
      'availableDays': availableDays,
      'availableTime': availableTime,
      'stripeAccountId': stripeAccountId,
      'isOnboardCompleted': isOnboardCompleted,
    };
  }
}
