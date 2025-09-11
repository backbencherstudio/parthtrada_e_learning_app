import 'package:e_learning_app/src/features/search/model/rating_model.dart';
import 'package:e_learning_app/src/features/search/model/user_model.dart';

class DataModel {
  final String? id;
  final String? profession;
  final String? organization;
  final String? location;
  final String? description;
  final String? experience;
  final String? hourlyRate;
  final List<String>? skills;
  final List<String>? availableDays;
  final List<String>? availableTime;
  final String? stripeAccountId;
  final bool? isOnboardCompleted;
  final String? userId;
  final UserModel? user;
  final RatingModel? rating;

  DataModel({
    this.id,
    this.profession,
    this.organization,
    this.location,
    this.description,
    this.experience,
    this.hourlyRate,
    this.skills,
    this.availableDays,
    this.availableTime,
    this.stripeAccountId,
    this.isOnboardCompleted,
    this.userId,
    this.user,
    this.rating,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'],
      profession: json['profession'],
      organization: json['organization'],
      location: json['location'],
      description: json['description'],
      experience: json['experience'],
      hourlyRate: json['hourlyRate'],
      skills:
          (json['skills'] as List<dynamic>?)?.map((e) => e as String).toList(),
      availableDays:
          (json['availableDays'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      availableTime:
          (json['availableTime'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      stripeAccountId: json['stripeAccountId'],
      isOnboardCompleted: json['isOnboardCompleted'],
      userId: json['userId'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      rating:
          json['rating'] != null ? RatingModel.fromJson(json['rating']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profession': profession,
      'organization': organization,
      'location': location,
      'description': description,
      'experience': experience,
      'hourlyRate': hourlyRate,
      'skills': skills,
      'availableDays': availableDays,
      'availableTime': availableTime,
      'stripeAccountId': stripeAccountId,
      'isOnboardCompleted': isOnboardCompleted,
      'userId': userId,
      'user': user?.toJson(),
      'rating': rating?.toJson(),
    };
  }
}
