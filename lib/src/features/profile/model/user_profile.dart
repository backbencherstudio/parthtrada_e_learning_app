import 'package:e_learning_app/src/features/profile/model/expert_profile_model.dart';
import 'package:e_learning_app/src/features/profile/model/meta_model.dart';
import 'package:e_learning_app/src/features/profile/model/student_profile_model.dart';

class UserProfile {
  final String? id;
  final String? linkedInId;
  final String? name;
  final String? email;
  final String? lastLogin;
  final String? image;
  final String? activeProfile;
  final String? timezone;
  final String? createdAt;
  final String? updatedAt;
  final ProfileMeta? meta;

  UserProfile({
    this.id,
    this.linkedInId,
    this.name,
    this.email,
    this.lastLogin,
    this.image,
    this.activeProfile,
    this.timezone,
    this.createdAt,
    this.updatedAt,
    this.meta,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    ProfileMeta? meta;

    if (json['meta'] != null) {
      if (json['activeProfile'] == 'EXPERT') {
        meta = ExpertMeta.fromJson(json['meta']);
      } else if (json['activeProfile'] == 'STUDENT') {
        meta = StudentMeta.fromJson(json['meta']);
      }
    }

    return UserProfile(
      id: json['id'],
      linkedInId: json['linkedInId'],
      name: json['name'],
      email: json['email'],
      lastLogin: json['lastLogin'],
      image: json['image'],
      activeProfile: json['activeProfile'],
      timezone: json['timezone'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      meta: meta,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'linkedInId': linkedInId,
      'name': name,
      'email': email,
      'lastLogin': lastLogin,
      'image': image,
      'activeProfile': activeProfile,
      'timezone': timezone,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'meta': meta?.toJson(),
    };
  }
}
