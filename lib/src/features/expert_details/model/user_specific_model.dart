class SpecificUserDetails {
  bool? success;
  String? message;
  Data? data;

  SpecificUserDetails({this.success, this.message, this.data});

  factory SpecificUserDetails.fromJson(Map<String, dynamic> json) {
    return SpecificUserDetails(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data?.toJson()};
  }
}

class Data {
  Expert? expert;
  Stats? stats;

  Data({this.expert, this.stats});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      expert: json['expert'] != null ? Expert.fromJson(json['expert']) : null,
      stats: json['stats'] != null ? Stats.fromJson(json['stats']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'expert': expert?.toJson(), 'stats': stats?.toJson()};
  }
}

class Expert {
  String? id;
  String? profession;
  String? organization;
  String? location;
  String? description;
  String? experience;
  String? hourlyRate;
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

  factory Expert.fromJson(Map<String, dynamic> json) {
    return Expert(
      id: json['id'],
      profession: json['profession'],
      organization: json['organization'],
      location: json['location'],
      description: json['description'],
      experience: json['experience'],
      hourlyRate: json['hourlyRate'],
      skills: (json['skills'] as List?)?.map((e) => e.toString()).toList(),
      availableDays:
          (json['availableDays'] as List?)?.map((e) => e.toString()).toList(),
      availableTime:
          (json['availableTime'] as List?)?.map((e) => e.toString()).toList(),
      user: json['user'] != null ? User.fromJson(json['user']) : null,
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
      'user': user?.toJson(),
    };
  }
}

class User {
  String? name;
  String? email;
  String? image;

  User({this.name, this.email, this.image});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(name: json['name'], email: json['email'], image: json['image']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'image': image};
  }
}

class Stats {
  int? totalReviews;
  double? averageRating;
  final int totalStudents;
  List<RatingDistribution>? ratingDistribution;

  Stats({
    this.totalReviews,
    this.averageRating,
    this.ratingDistribution,
    required this.totalStudents,
  });

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      totalReviews: json['totalReviews'],
      averageRating:
          json['averageRating'] != null
              ? double.tryParse(json['averageRating'].toString())
              : null,
      totalStudents: json['totalStudents'],
      ratingDistribution:
          (json['ratingDistribution'] as List?)
              ?.map((e) => RatingDistribution.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalReviews': totalReviews,
      'averageRating': averageRating,
      'totalStudents': totalStudents,
      'ratingDistribution': ratingDistribution?.map((v) => v.toJson()).toList(),
    };
  }
}

class RatingDistribution {
  int? rating;
  int? count;
  double? percentage;

  RatingDistribution({this.rating, this.count, this.percentage});

  factory RatingDistribution.fromJson(Map<String, dynamic> json) {
    return RatingDistribution(
      rating: json['rating'],
      count: json['count'],
      percentage:
          json['percentage'] != null
              ? double.tryParse(json['percentage'].toString())
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'rating': rating, 'count': count, 'percentage': percentage};
  }
}
