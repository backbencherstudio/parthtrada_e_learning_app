class ProfileResponseData {
  bool? success;
  String? message;
  Data? data;

  ProfileResponseData({this.success, this.message, this.data});

  factory ProfileResponseData.fromJson(Map<String, dynamic> json) {
    return ProfileResponseData(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.toJson();
    }
    return map;
  }
}

class Data {
  String? id;
  String? linkedinId;
  String? name;
  String? email;
  String? lastLogin;
  String? image;
  String? activeProfile;
  String? timezone;
  String? createdAt;
  String? updatedAt;
  Meta? meta;

  Data({
    this.id,
    this.linkedinId,
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

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      linkedinId: json['linkedin_id'],
      name: json['name'],
      email: json['email'],
      lastLogin: json['lastLogin'],
      image: json['image'],
      activeProfile: json['activeProfile'],
      timezone: json['timezone'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'linkedin_id': linkedinId,
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

class Meta {
  String? id;
  String? profession;
  String? organization;
  String? location;
  String? description;
  String? experience;
  int? hourlyRate;
  List<String>? skills;
  List<String>? availableDays;
  List<String>? availableTime;
  String? status;
  String? stripeAccountId;
  bool? isOnboardCompleted;
  String? userId;
  String? university; // Added to align with UserProfile

  Meta({
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
    this.status,
    this.stripeAccountId,
    this.isOnboardCompleted,
    this.userId,
    this.university,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      id: json['id'],
      profession: json['profession'],
      organization: json['organization'],
      location: json['location'],
      description: json['description'],
      experience: json['experience'],
      hourlyRate: json['hourlyRate'],
      skills: json['skills'] != null ? List<String>.from(json['skills']) : null,
      availableDays: json['availableDays'] != null ? List<String>.from(json['availableDays']) : null,
      availableTime: json['availableTime'] != null ? List<String>.from(json['availableTime']) : null,
      status: json['status'],
      stripeAccountId: json['stripeAccountId'],
      isOnboardCompleted: json['isOnboardCompleted'],
      userId: json['userId'],
      university: json['university'],
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
      'status': status,
      'stripeAccountId': stripeAccountId,
      'isOnboardCompleted': isOnboardCompleted,
      'userId': userId,
      'university': university,
    };
  }
}