import 'package:flutter_riverpod/flutter_riverpod.dart';

final expertSearchQueryProvider = StateProvider<String>((ref) => '');

final availableDaysProvider = StateProvider<List<dynamic>>((ref) => []);
