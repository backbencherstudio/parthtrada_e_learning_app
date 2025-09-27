class ProfileResponseData {
  bool? success;
  String? message;
  Data? data;

  ProfileResponseData({this.success, this.message, this.data});

  ProfileResponseData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? linkedinId;
  String? name;
  String? email;
  String? lastLogin;
  Null? image;
  String? activeProfile;
  Null? timezone;
  String? createdAt;
  String? updatedAt;
  Null? meta;

  Data(
      {this.id,
        this.linkedinId,
        this.name,
        this.email,
        this.lastLogin,
        this.image,
        this.activeProfile,
        this.timezone,
        this.createdAt,
        this.updatedAt,
        this.meta});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    linkedinId = json['linkedin_id'];
    name = json['name'];
    email = json['email'];
    lastLogin = json['lastLogin'];
    image = json['image'];
    activeProfile = json['activeProfile'];
    timezone = json['timezone'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    meta = json['meta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['linkedin_id'] = this.linkedinId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['lastLogin'] = this.lastLogin;
    data['image'] = this.image;
    data['activeProfile'] = this.activeProfile;
    data['timezone'] = this.timezone;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['meta'] = this.meta;
    return data;
  }
}
