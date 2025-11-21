import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/local_storage_services/user_type_storage.dart';

final userTypeProvider = FutureProvider<String?>((ref) async {
  return await UserTypeStorage().getUserType();
});
