class ExpartDetailModel {
  bool? success;
  String? message;
  Data? data;

  ExpartDetailModel({this.success, this.message, this.data});

  ExpartDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};
    result['success'] = success;
    result['message'] = message;
    if (data != null) result['data'] = data!.toJson();
    return result;
  }
}

class Data {
  Expert? expert;
  Stats? stats;

  Data({this.expert, this.stats});

  Data.fromJson(Map<String, dynamic> json) {
    expert = json['expert'] != null ? Expert.fromJson(json['expert']) : null;
    stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};
    if (expert != null) result['expert'] = expert!.toJson();
    if (stats != null) result['stats'] = stats!.toJson();
    return result;
  }
}

class Expert {
  String? id;
  String? profession;
  String? organization;
  String? location;
  String? description;
  String? experience;
  double? hourlyRate;
  List<String>? skills;
  List<String>? availableDays;
  List<String>? availableTime;
  Availability? availability;
  User? user;

  Expert({
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
    this.availability,
    this.user,
  });

  Expert.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profession = json['profession'];
    organization = json['organization'];
    location = json['location'];
    description = json['description'];
    experience = json['experience'];

    final val = json['hourlyRate'];
    hourlyRate = val is String
        ? double.tryParse(val)
        : (val is num ? val.toDouble() : null);

    skills = (json['skills'] as List?)?.map((e) => e.toString()).toList();
    availableDays =
        (json['availableDays'] as List?)?.map((e) => e.toString()).toList();
    availableTime =
        (json['availableTime'] as List?)?.map((e) => e.toString()).toList();

    availability = json['availability'] != null
        ? Availability.fromJson(json['availability'])
        : null;

    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};
    result['id'] = id;
    result['profession'] = profession;
    result['organization'] = organization;
    result['location'] = location;
    result['description'] = description;
    result['experience'] = experience;
    result['hourlyRate'] = hourlyRate;
    result['skills'] = skills;
    result['availableDays'] = availableDays;
    result['availableTime'] = availableTime;
    if (availability != null) result['availability'] = availability!.toJson();
    if (user != null) result['user'] = user!.toJson();
    return result;
  }
}

class Availability {
  List<String>? days;
  List<String>? time;

  Availability({this.days, this.time});

  Availability.fromJson(Map<String, dynamic> json) {
    days = (json['days'] as List?)?.map((e) => e.toString()).toList();
    time = (json['time'] as List?)?.map((e) => e.toString()).toList();
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};
    result['days'] = days;
    result['time'] = time;
    return result;
  }
}

class User {
  String? id;
  String? name;
  String? email;
  String? image;
  dynamic studentProfile;

  User({this.id, this.name, this.email, this.image, this.studentProfile});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    studentProfile = json['studentProfile'];
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};
    result['id'] = id;
    result['name'] = name;
    result['email'] = email;
    result['image'] = image;
    result['studentProfile'] = studentProfile;
    return result;
  }
}

class Stats {
  int? totalReviews;
  double? averageRating;
  List<RatingDistribution>? ratingDistribution;
  int? totalStudents;

  Stats({
    this.totalReviews,
    this.averageRating,
    this.ratingDistribution,
    this.totalStudents,
  });

  Stats.fromJson(Map<String, dynamic> json) {
    totalReviews = json['totalReviews'] is String
        ? int.tryParse(json['totalReviews'])
        : json['totalReviews'];

    averageRating = json['averageRating'] is String
        ? double.tryParse(json['averageRating'])
        : (json['averageRating'] is num
        ? (json['averageRating'] as num).toDouble()
        : null);

    if (json['ratingDistribution'] != null) {
      ratingDistribution = <RatingDistribution>[];
      json['ratingDistribution'].forEach((v) {
        ratingDistribution!.add(RatingDistribution.fromJson(v));
      });
    }

    totalStudents = json['totalStudents'] is String
        ? int.tryParse(json['totalStudents'])
        : json['totalStudents'];
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};
    result['totalReviews'] = totalReviews;
    result['averageRating'] = averageRating;
    if (ratingDistribution != null) {
      result['ratingDistribution'] =
          ratingDistribution!.map((v) => v.toJson()).toList();
    }
    result['totalStudents'] = totalStudents;
    return result;
  }
}

class RatingDistribution {
  int? rating;
  int? count;
  String? percentage;

  RatingDistribution({this.rating, this.count, this.percentage});

  RatingDistribution.fromJson(Map<String, dynamic> json) {
    rating = json['rating'] is String
        ? int.tryParse(json['rating'])
        : json['rating'];

    count =
    json['count'] is String ? int.tryParse(json['count']) : json['count'];

    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};
    result['rating'] = rating;
    result['count'] = count;
    result['percentage'] = percentage;
    return result;
  }
}
