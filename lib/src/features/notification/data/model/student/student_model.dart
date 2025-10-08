class StudentModel {
  final bool success;
  final String message;
  final StudentData? data;

  StudentModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? StudentData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data?.toJson(),
  };
}

class StudentData {
  final String id;
  final String? profession;
  final String? organization;
  final String? location;
  final String? description;
  final String userId;
  final User? user;

  StudentData({
    required this.id,
    this.profession,
    this.organization,
    this.location,
    this.description,
    required this.userId,
    this.user,
  });

  factory StudentData.fromJson(Map<String, dynamic> json) {
    return StudentData(
      id: json['id'] ?? '',
      profession: json['profession'],
      organization: json['organization'],
      location: json['location'],
      description: json['description'],
      userId: json['userId'] ?? '',
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'profession': profession,
    'organization': organization,
    'location': location,
    'description': description,
    'userId': userId,
    'user': user?.toJson(),
  };
}

class User {
  final String id;
  final String name;
  final String email;
  final String? image;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'image': image,
  };
}
