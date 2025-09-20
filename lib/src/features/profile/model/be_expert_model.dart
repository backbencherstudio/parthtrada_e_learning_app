class BeExpertModel {
  bool? success;
  String? message;
  String? token;
  User? user;

  BeExpertModel({this.success, this.message, this.token, this.user});

  factory BeExpertModel.fromJson(Map<String, dynamic> json) {
    return BeExpertModel(
      success: json['success'],
      message: json['message'],
      token: json['token'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'token': token,
      if (user != null) 'user': user!.toJson(),
    };
  }
}

class User {
  String? id;
  String? name;
  String? email;
  String? image;
  String? activeProfile;
  Profile? profile;

  User({
    this.id,
    this.name,
    this.email,
    this.image,
    this.activeProfile,
    this.profile,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      image: json['image'],
      activeProfile: json['activeProfile'],
      profile:
          json['profile'] != null ? Profile.fromJson(json['profile']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'image': image,
      'activeProfile': activeProfile,
      if (profile != null) 'profile': profile!.toJson(),
    };
  }
}

class Profile {
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
  String? stripeAccountId;
  bool? isOnboardCompleted;
  String? userId;

  Profile({
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
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      profession: json['profession'],
      organization: json['organization'],
      location: json['location'],
      description: json['description'],
      experience: json['experience'],
      hourlyRate: json['hourlyRate'],
      skills: List<String>.from(json['skills'] ?? []),
      availableDays: List<String>.from(json['availableDays'] ?? []),
      availableTime: List<String>.from(json['availableTime'] ?? []),
      stripeAccountId: json['stripeAccountId'],
      isOnboardCompleted: json['isOnboardCompleted'],
      userId: json['userId'],
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
    };
  }
}
