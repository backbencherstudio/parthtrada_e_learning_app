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
        data!.add(new Data.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Data {
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
  User? user;
  Rating? rating;

  Data(
      {this.id,
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
        this.rating});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profession = json['profession'];
    organization = json['organization'];
    location = json['location'];
    description = json['description'];
    experience = json['experience'];
    hourlyRate = json['hourlyRate'];
    skills = json['skills'].cast<String>();
    availableDays = json['availableDays'].cast<String>();
    availableTime = json['availableTime'].cast<String>();
    stripeAccountId = json['stripeAccountId'];
    isOnboardCompleted = json['isOnboardCompleted'];
    userId = json['userId'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    rating =
    json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['profession'] = this.profession;
    data['organization'] = this.organization;
    data['location'] = this.location;
    data['description'] = this.description;
    data['experience'] = this.experience;
    data['hourlyRate'] = this.hourlyRate;
    data['skills'] = this.skills;
    data['availableDays'] = this.availableDays;
    data['availableTime'] = this.availableTime;
    data['stripeAccountId'] = this.stripeAccountId;
    data['isOnboardCompleted'] = this.isOnboardCompleted;
    data['userId'] = this.userId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.rating != null) {
      data['rating'] = this.rating!.toJson();
    }
    return data;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['image'] = this.image;
    return data;
  }
}

class Rating {
  int? avg;
  int? total;

  Rating({this.avg, this.total});

  Rating.fromJson(Map<String, dynamic> json) {
    avg = json['avg'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avg'] = this.avg;
    data['total'] = this.total;
    return data;
  }
}

class Pagination {
  int? total;
  int? page;
  int? perPage;
  int? totalPages;
  bool? hasNextPage;
  bool? hasPrevPage;

  Pagination(
      {this.total,
        this.page,
        this.perPage,
        this.totalPages,
        this.hasNextPage,
        this.hasPrevPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    page = json['page'];
    perPage = json['perPage'];
    totalPages = json['totalPages'];
    hasNextPage = json['hasNextPage'];
    hasPrevPage = json['hasPrevPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['page'] = this.page;
    data['perPage'] = this.perPage;
    data['totalPages'] = this.totalPages;
    data['hasNextPage'] = this.hasNextPage;
    data['hasPrevPage'] = this.hasPrevPage;
    return data;
  }
}
