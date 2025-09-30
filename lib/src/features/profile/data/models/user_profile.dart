class UserProfile {
  final String? name;
  final String? university;
  final String? profession;
  final String? organization;
  final String? location;
  final String? description;
  final String? experience;
  final int? hourlyRate;
  final List<String>? skills;
  final List<String>? availableDays;
  final List<String>? availableTime;

  UserProfile({
    this.name,
    this.university,
    this.profession,
    this.organization,
    this.location,
    this.description,
    this.experience,
    this.hourlyRate,
    this.skills,
    this.availableDays,
    this.availableTime,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'] as String?,
      university: json['university'] as String?,
      profession: json['profession'] as String?,
      organization: json['organization'] as String?,
      location: json['location'] as String?,
      description: json['description'] as String?,
      experience: json['experience'] as String?,
      hourlyRate: json['hourlyRate'] as int?,
      skills: (json['skills'] as List<dynamic>?)?.map((e) => e as String).toList(),
      availableDays: (json['availableDays'] as List<dynamic>?)?.map((e) => e as String).toList(),
      availableTime: (json['availableTime'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (university != null) 'university': university,
      if (profession != null) 'profession': profession,
      if (organization != null) 'organization': organization,
      if (location != null) 'location': location,
      if (description != null) 'description': description,
      if (experience != null) 'experience': experience,
      if (hourlyRate != null) 'hourlyRate': hourlyRate,
      if (skills != null) 'skills': skills,
      if (availableDays != null) 'availableDays': availableDays,
      if (availableTime != null) 'availableTime': availableTime,
    };
  }
}