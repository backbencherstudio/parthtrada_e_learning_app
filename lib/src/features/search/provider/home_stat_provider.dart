import 'package:e_learning_app/repository/api/home/fetch_stats.dart';
import 'package:e_learning_app/src/features/search/model/home_stat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../onboarding/riverpod/login_state.dart';

final homeStatProvider = FutureProvider<HomeStatModel>((ref) async {
  final token = ref.watch(authTokenProvider);

  if (token == null) {
    throw Exception('Unauthorized/No auth token found');
  }

  final repository = FetchStats();

  try {
    final stats = await repository.getStats(token);
    debugPrint('Successfully fetched home stats');
    return stats;
  } catch (e) {
    debugPrint('Error in statProvider: $e');
    throw Exception('Failed to fetch stats: $e');
  }
});
