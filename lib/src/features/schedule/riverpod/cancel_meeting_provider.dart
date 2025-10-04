import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../repository/api/schedule/cancel_schedule.dart';

final cancelScheduleRepositoryProvider = Provider<CancelSchedule>((ref) {
  return CancelSchedule();
});

final cancelScheduleProvider = FutureProvider.family<bool, String>((ref, id) async {
  final repo = ref.read(cancelScheduleRepositoryProvider);
  return await repo.cancelScheduleMeetings(id: id);
});
