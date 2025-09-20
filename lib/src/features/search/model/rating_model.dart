class RatingModel {
  final double avg;
  final int total;

  RatingModel({this.avg = 0.0, this.total = 0});

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      avg: (json['avg'] as num).toDouble(),
      total: json['total'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {'avg': avg, 'total': total};
  }
}
