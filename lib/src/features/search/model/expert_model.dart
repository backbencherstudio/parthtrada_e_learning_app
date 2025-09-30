class ExpertModel {
  bool? success;
  String? message;
  List<Data>? data;
  Pagination? pagination;

  ExpertModel({this.success, this.message, this.data, this.pagination});

  ExpertModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];

    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }

    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      map['pagination'] = pagination!.toJson();
    }
    return map;
  }
}

class Data {
  String? id;
  String? profession;
  String? organization;
  String? location;
  String? description;
  String? experience;
  double? hourlyRate; // Changed to double to handle decimal values
  List<String>? skills;
  List<String>? availableDays;
  List<String>? availableTime;
  String? stripeAccountId;
  bool? isOnboardCompleted;
  String? userId;
  User? user;
  Rating? rating;

  Data({
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
    this.user,
    this.rating,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profession = json['profession'];
    organization = json['organization'];
    location = json['location'];
    description = json['description'];
    experience = json['experience'];

    // Safely parse numeric field
    hourlyRate = json['hourlyRate'] != null
        ? (json['hourlyRate'] as num).toDouble()
        : null;

    skills = json['skills'] != null ? List<String>.from(json['skills']) : null;
    availableDays =
    json['availableDays'] != null ? List<String>.from(json['availableDays']) : null;
    availableTime =
    json['availableTime'] != null ? List<String>.from(json['availableTime']) : null;

    stripeAccountId = json['stripeAccountId'];
    isOnboardCompleted = json['isOnboardCompleted'];
    userId = json['userId'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['profession'] = profession;
    map['organization'] = organization;
    map['location'] = location;
    map['description'] = description;
    map['experience'] = experience;
    map['hourlyRate'] = hourlyRate;
    map['skills'] = skills;
    map['availableDays'] = availableDays;
    map['availableTime'] = availableTime;
    map['stripeAccountId'] = stripeAccountId;
    map['isOnboardCompleted'] = isOnboardCompleted;
    map['userId'] = userId;
    if (user != null) map['user'] = user!.toJson();
    if (rating != null) map['rating'] = rating!.toJson();
    return map;
  }
}

class User {
  String? name;
  String? email;
  String? image;

  User({this.name, this.email, this.image});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['image'] = image;
    return map;
  }
}

class Rating {
  double? avg; // Changed to double
  int? total;

  Rating({this.avg, this.total});

  Rating.fromJson(Map<String, dynamic> json) {
    avg = json['avg'] != null ? (json['avg'] as num).toDouble() : null;
    total = json['total'] != null ? (json['total'] as num).toInt() : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['avg'] = avg;
    map['total'] = total;
    return map;
  }
}

class Pagination {
  int? total;
  int? page;
  int? perPage;
  int? totalPages;
  bool? hasNextPage;
  bool? hasPrevPage;

  Pagination({
    this.total,
    this.page,
    this.perPage,
    this.totalPages,
    this.hasNextPage,
    this.hasPrevPage,
  });

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    page = json['page'];
    perPage = json['perPage'];
    totalPages = json['totalPages'];
    hasNextPage = json['hasNextPage'];
    hasPrevPage = json['hasPrevPage'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    map['page'] = page;
    map['perPage'] = perPage;
    map['totalPages'] = totalPages;
    map['hasNextPage'] = hasNextPage;
    map['hasPrevPage'] = hasPrevPage;
    return map;
  }
}
