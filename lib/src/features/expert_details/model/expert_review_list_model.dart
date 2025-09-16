class ExpertReviewListModel {
  final bool? success;
  final String? message;
  final Data? data;

  ExpertReviewListModel({this.success, this.message, this.data});

  factory ExpertReviewListModel.fromJson(Map<String, dynamic> json) {
    return ExpertReviewListModel(
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
  final int? page;
  final int? limit;
  final int? total;
  final List<Items>? items;

  Data({this.page, this.limit, this.total, this.items});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
      items:
          json['items'] != null
              ? (json['items'] as List)
                  .map((item) => Items.fromJson(item))
                  .toList()
              : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'limit': limit,
      'total': total,
      'items': items?.map((item) => item.toJson()).toList(),
    };
  }
}

class Items {
  final String? id;
  final int? rating;
  final String? description;
  final String? createdAt;
  final Student? student;
  final String? sessionDate;

  Items({
    this.id,
    this.rating,
    this.description,
    this.createdAt,
    this.student,
    this.sessionDate,
  });

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      id: json['id'],
      rating: json['rating'],
      description: json['description'],
      createdAt: json['createdAt'],
      student:
          json['student'] != null ? Student.fromJson(json['student']) : null,
      sessionDate: json['sessionDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rating': rating,
      'description': description,
      'createdAt': createdAt,
      'student': student?.toJson(),
      'sessionDate': sessionDate,
    };
  }
}

class Student {
  final String? name;
  final String? email;
  final String? image;

  Student({this.name, this.email, this.image});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'],
      email: json['email'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'image': image};
  }
}
