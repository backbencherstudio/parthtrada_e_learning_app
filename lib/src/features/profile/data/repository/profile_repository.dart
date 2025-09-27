import 'package:e_learning_app/src/features/profile/data/models/profile_response_data.dart';

abstract class ProfileRepository {
  Future<ProfileResponseData> getProfileInfo();
}