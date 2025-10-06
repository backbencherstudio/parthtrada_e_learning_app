import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/add_review_model.dart';

final addReviewProvider = StateProvider<AddReviewModel>((ref) {
  return AddReviewModel(
    description: '',
    rating: 0,
    bookingId: '',
  );
});

