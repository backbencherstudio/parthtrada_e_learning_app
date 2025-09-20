// profile_meta.dart
abstract class ProfileMeta {
  final String? id;
  final String? profession;
  final String? organization;
  final String? location;
  final String? description;
  final String? userId;

  ProfileMeta({
    this.id,
    this.profession,
    this.organization,
    this.location,
    this.description,
    this.userId,
  });

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
