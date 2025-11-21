class TempExpertReviewModel {
  String? userName;
  String? profilePicture;
  int? ratings;
  String? eMail;
  String? reviews;

  TempExpertReviewModel(
      {this.userName,
        this.profilePicture,
        this.ratings,
        this.eMail,
        this.reviews});

  TempExpertReviewModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    profilePicture = json['profilePicture'];
    ratings = json['ratings'];
    eMail = json['e-mail'];
    reviews = json['reviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['profilePicture'] = this.profilePicture;
    data['ratings'] = this.ratings;
    data['e-mail'] = this.eMail;
    data['reviews'] = this.reviews;
    return data;
  }
}
