import 'package:e_learning_app/src/features/book_expert/model/session_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionDataNotifier extends StateNotifier<SessionModel> {
  SessionDataNotifier()
    : super(
        SessionModel(
          expertId: '',
          expertName: '',
          date: '',
          time: '',
          sessionDuration: 0,
          sessionDetails: '',
          currency: '',
          hourlyRate: ''
        ),
      );

  void setHourlyRate(String hourlyRate) {
    state = state.copyWith(hourlyRate: hourlyRate);
    debugPrint(state.hourlyRate);
  }

  void setExpertId(String expertId) {
    state = state.copyWith(expertId: expertId);
    debugPrint(state.expertId);
  }

  void setExpertName(String expertName) {
    state = state.copyWith(expertName: expertName);
    debugPrint(state.expertName);
  }

  void setDate(String date) {
    state = state.copyWith(date: date);
    debugPrint(state.date);
  }

  void setTime(String time) {
    state = state.copyWith(time: time);
    debugPrint(state.time);
  }

  void setSessionDuration(int duration) {
    state = state.copyWith(sessionDuration: duration);
    debugPrint(state.sessionDuration.toString());
  }

  void setSessionDetails(String details) {
    state = state.copyWith(sessionDetails: details);
    debugPrint(state.sessionDetails);
  }

  void setCurrency(String currency) {
    state = state.copyWith(currency: currency);
    debugPrint(state.currency);
  }

  void setSessionData(SessionModel newData) {
    state = newData;
  }
}
