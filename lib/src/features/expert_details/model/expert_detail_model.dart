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
    final Map<String, dynamic> result = {};
    result['success'] = success;
    result['message'] = message;
    if (data != null) {
      result['data'] = data!.toJson();
    }
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
    final Map<String, dynamic> result = {};
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
  int? hourlyRate;
  List<String>? skills;
  List<String>? availableDays;
  List<String>? availableTime;
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
    this.user,
  });

  Expert.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profession = json['profession'];
    organization = json['organization'];
    location = json['location'];
    description = json['description'];
    experience = json['experience'];
    hourlyRate = json['hourlyRate'];

    /// Safe cast: যদি null হয় তাহলে খালি লিস্ট দিব
    skills = (json['skills'] as List?)?.map((e) => e.toString()).toList() ?? [];
    availableDays =
        (json['availableDays'] as List?)?.map((e) => e.toString()).toList() ??
            [];
    availableTime =
        (json['availableTime'] as List?)?.map((e) => e.toString()).toList() ??
            [];

    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
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
    if (user != null) result['user'] = user!.toJson();
    return result;
  }
}

class User {
  String? id;
  String? name;
  String? email;
  String? image;
  dynamic studentProfile; // যেকোনো টাইপ ডেটা হলে crash করবে না

  User({this.id, this.name, this.email, this.image, this.studentProfile});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image']; // Safe as String or null
    studentProfile = json['studentProfile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
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

  Stats({this.totalReviews, this.averageRating, this.ratingDistribution, this.totalStudents});

  Stats.fromJson(Map<String, dynamic> json) {
    totalReviews = json['totalReviews'];

    /// Convert int or string to double safely
    if (json['averageRating'] != null) {
      averageRating = (json['averageRating'] as num).toDouble();
    }

    if (json['ratingDistribution'] != null) {
      ratingDistribution = <RatingDistribution>[];
      json['ratingDistribution'].forEach((v) {
        ratingDistribution!.add(RatingDistribution.fromJson(v));
      });
    }
    totalStudents = json['totalStudents'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
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
    rating = json['rating'];
    count = json['count'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['rating'] = rating;
    result['count'] = count;
    result['percentage'] = percentage;
    return result;
  }
}
