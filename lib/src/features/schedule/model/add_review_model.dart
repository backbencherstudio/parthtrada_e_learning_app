class AddReviewModel {
  final String description;
  final int rating;
  final String bookingId;

  AddReviewModel({
    required this.description,
    required this.rating,
    required this.bookingId,
  });

  AddReviewModel copyWith({
    String? description,
    int? rating,
    String? bookingId,
  }) {
    return AddReviewModel(
      description: description ?? this.description,
      rating: rating ?? this.rating,
      bookingId: bookingId ?? this.bookingId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'rating': rating,
      'bookingId': bookingId,
    };
  }
}