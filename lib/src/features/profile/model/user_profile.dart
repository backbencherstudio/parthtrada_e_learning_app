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
  final String? activeProfile; // Either "EXPERT" or "STUDENT"
  final String? timezone;
  final String? createdAt;
  final String? updatedAt;
  final ProfileMeta? meta; // Expert or Student specific fields

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

    // Determine if the profile is Expert or Student based on the `activeProfile` field
    if (json['meta'] != null) {
      if (json['activeProfile'] == 'EXPERT') {
        meta = ExpertMeta.fromJson(
          json['meta'],
        ); // Deserialize Expert-specific data
      } else if (json['activeProfile'] == 'STUDENT') {
        meta = StudentMeta.fromJson(
          json['meta'],
        ); // Deserialize Student-specific data
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
      meta: meta, // Assign either ExpertMeta or StudentMeta
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
      'meta':
          meta?.toJson(), // Serialize the meta (Expert or Student-specific fields)
    };
  }
}
