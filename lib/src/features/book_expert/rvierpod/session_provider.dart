import 'package:e_learning_app/src/features/book_expert/model/session_model.dart';
import 'package:e_learning_app/src/features/book_expert/rvierpod/session_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sessionDataProvider =
StateNotifierProvider<SessionDataNotifier, SessionModel>((ref) {
  return SessionDataNotifier();
});
