// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class AvailabilityData {
//   final String? firstAvailableDay;
//   final String? lastAvailableDay;
//   final String? firstAvailableTime;
//   final String? lastAvailableTime;

//   AvailabilityData({
//     this.firstAvailableDay,
//     this.lastAvailableDay,
//     this.firstAvailableTime,
//     this.lastAvailableTime,
//   });
// }

// class AvailabilityNotifier extends StateNotifier<AvailabilityData?> {
//   AvailabilityNotifier() : super(null);

//   void setAvailability({
//     required String firstAvailableDay,
//     required String lastAvailableDay,
//     required String firstAvailableTime,
//     required String lastAvailableTime,
//   }) {
//     state = AvailabilityData(
//       firstAvailableDay: firstAvailableDay,
//       lastAvailableDay: lastAvailableDay,
//       firstAvailableTime: firstAvailableTime,
//       lastAvailableTime: lastAvailableTime,
//     );
//   }
// }

// // Provider for availability
// final availabilityProvider =
//     StateNotifierProvider<AvailabilityNotifier, AvailabilityData?>(
//       (ref) => AvailabilityNotifier(),
//     );
