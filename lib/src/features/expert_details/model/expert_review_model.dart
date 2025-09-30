class ExpertReviewModel {
  final bool success;
  final String message;
  final ReviewData data;

  ExpertReviewModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ExpertReviewModel.fromJson(Map<String, dynamic> json) {
    return ExpertReviewModel(
      success: json['success'],
      message: json['message'],
      data: ReviewData.fromJson(json['data']),
    );
  }
}

class ReviewData {
  final int page;
  final int limit;
  final int total;
  final List<ReviewItem> items;

  ReviewData({
    required this.page,
    required this.limit,
    required this.total,
    required this.items,
  });

  factory ReviewData.fromJson(Map<String, dynamic> json) {
    return ReviewData(
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
      items: (json['items'] as List)
          .map((item) => ReviewItem.fromJson(item))
          .toList(),
    );
  }
}

class ReviewItem {
  final String id;
  final int rating;
  final String description;
  final String createdAt;
  final Student student;
  final String sessionDate;

  ReviewItem({
    required this.id,
    required this.rating,
    required this.description,
    required this.createdAt,
    required this.student,
    required this.sessionDate,
  });

  factory ReviewItem.fromJson(Map<String, dynamic> json) {
    return ReviewItem(
      id: json['id'],
      rating: json['rating'],
      description: json['description'],
      createdAt: json['createdAt'],
      student: Student.fromJson(json['student']),
      sessionDate: json['sessionDate'],
    );
  }
}

class Student {
  final String name;
  final String email;
  final String? image;

  Student({
    required this.name,
    required this.email,
    this.image,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'],
      email: json['email'],
      image: json['image'],
    );
  }
}
