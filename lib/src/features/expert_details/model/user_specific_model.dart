// class SpecificUserDetails {
//   bool? success;
//   String? message;
//   Data? data;

//   SpecificUserDetails({this.success, this.message, this.data});

//   SpecificUserDetails.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     message = json['message'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

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
  int totalStudents;
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




// class Expert {
//   String? id;
//   String? profession;
//   String? organization;
//   String? location;
//   String? description;
//   String? experience;
//   String? hourlyRate;
//   List<String>? skills;
//   List<String>? availableDays;
//   List<String>? availableTime;
//   User? user;

//   Expert({
//     this.id,
//     this.profession,
//     this.organization,
//     this.location,
//     this.description,
//     this.experience,
//     this.hourlyRate,
//     this.skills,
//     this.availableDays,
//     this.availableTime,
//     this.user,
//   });

//   // factory Expert.fromJson(Map<String, dynamic> json) {
//   //   return Expert(
//   //     id: 
//   //   );
//   // }

//   Expert.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     profession = json['profession'];
//     organization = json['organization'];
//     location = json['location'];
//     description = json['description'];
//     experience = json['experience'];
//     hourlyRate = json['hourlyRate'];
//     skills = json['skills'].cast<String>();
//     availableDays = json['availableDays'].cast<String>();
//     availableTime = json['availableTime'].cast<String>();
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['profession'] = this.profession;
//     data['organization'] = this.organization;
//     data['location'] = this.location;
//     data['description'] = this.description;
//     data['experience'] = this.experience;
//     data['hourlyRate'] = this.hourlyRate;
//     data['skills'] = this.skills;
//     data['availableDays'] = this.availableDays;
//     data['availableTime'] = this.availableTime;
//     if (this.user != null) {
//       data['user'] = this.user!.toJson();
//     }
//     return data;
//   }
// }


// class User {
//   String? name;
//   String? email;
//   String? image;

//   User({this.name, this.email, this.image});

//   User.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     email = json['email'];
//     image = json['image'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['image'] = this.image;
//     return data;
//   }
// }

// class Stats {
//   int? totalReviews;
//   String? averageRating;
//   List<RatingDistribution>? ratingDistribution;

//   Stats({this.totalReviews, this.averageRating, this.ratingDistribution});

//   Stats.fromJson(Map<String, dynamic> json) {
//     totalReviews = json['totalReviews'];
//     averageRating = json['averageRating'];
//     if (json['ratingDistribution'] != null) {
//       ratingDistribution = <RatingDistribution>[];
//       json['ratingDistribution'].forEach((v) {
//         ratingDistribution!.add(new RatingDistribution.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['totalReviews'] = this.totalReviews;
//     data['averageRating'] = this.averageRating;
//     if (this.ratingDistribution != null) {
//       data['ratingDistribution'] =
//           this.ratingDistribution!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class RatingDistribution {
//   int? rating;
//   int? count;
//   String? percentage;

//   RatingDistribution({this.rating, this.count, this.percentage});

//   RatingDistribution.fromJson(Map<String, dynamic> json) {
//     rating = json['rating'];
//     count = json['count'];
//     percentage = json['percentage'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['rating'] = this.rating;
//     data['count'] = this.count;
//     data['percentage'] = this.percentage;
//     return data;
//   }
// }
