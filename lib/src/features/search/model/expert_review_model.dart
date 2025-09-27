class UserReviewModel {
  bool? success;
  String? message;
  List<Data>? data;

  UserReviewModel({this.success, this.message, this.data});

  factory UserReviewModel.fromJson(Map<String, dynamic> json) {
    return UserReviewModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? List<Data>.from(json['data'].map((x) => Data.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.map((x) => x.toJson()).toList(),
  };
}

class Data {
  String? id;
  double? rating;
  String? description;
  Student? student;

  Data({this.id, this.rating, this.description, this.student});

  factory Data.fromJson(Map<String, dynamic> json) {
    double parsedRating = 0.0;
    try {
      if (json['rating'] != null) {
        final val = json['rating'];
        parsedRating = val is String
            ? double.tryParse(val) ?? 0.0
            : (val is num ? val.toDouble() : 0.0);
      }
    } catch (_) {
      parsedRating = 0.0;
    }

    return Data(
      id: json['id'],
      rating: parsedRating,
      description: json['description'],
      student:
      json['student'] != null ? Student.fromJson(json['student']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "rating": rating,
    "description": description,
    "student": student?.toJson(),
  };
}

class Student {
  String? id;
  String? name;
  String? image;
  StudentProfile? studentProfile;

  Student({this.id, this.name, this.image, this.studentProfile});

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    id: json['id'],
    name: json['name'],
    image: json['image'],
    studentProfile: json['studentProfile'] != null
        ? StudentProfile.fromJson(json['studentProfile'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "studentProfile": studentProfile?.toJson(),
  };
}

class StudentProfile {
  String? profession;
  String? organization;

  StudentProfile({this.profession, this.organization});

  factory StudentProfile.fromJson(Map<String, dynamic> json) => StudentProfile(
    profession: json['profession'],
    organization: json['organization'],
  );

  Map<String, dynamic> toJson() => {
    "profession": profession,
    "organization": organization,
  };
}
