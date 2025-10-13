import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/local_storage_services/user_type_storage.dart';

class UserTypeController extends StateNotifier<String?> {
  UserTypeController() : super(null) {
    loadUserType();
  }

  Future<void> loadUserType() async {
    final userType = await UserTypeStorage().getUserType();
    state = userType;
  }

  void setUserType(String? type) {
    state = type;
  }
}

final userRoleProvider = StateNotifierProvider<UserTypeController, String?>((ref) {
  return UserTypeController();
});
