import 'package:e_learning_app/src/features/profile/data/models/profile_response_data.dart';
import 'package:e_learning_app/src/features/profile/data/repository/profile_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileState {
  final bool isProfileLoding;
  final bool isProfileSuccess;
  final String profileErrorMessage;
  final ProfileResponseData profileResponseData;

  ProfileState({
    required this.isProfileLoding,
    required this.isProfileSuccess,
    required this.profileErrorMessage,
    required this.profileResponseData,
  });

  ProfileState.initial()
    : isProfileLoding = false,
      isProfileSuccess = false,
      profileResponseData = ProfileResponseData(),
      profileErrorMessage = '';

  ProfileState copyWith({
    bool? isProfileLoding,
    bool? isProfileSuccess,
    String? profileErrorMessage,
    ProfileResponseData? profileResponseData,
  }) {
    return ProfileState(
      isProfileLoding: isProfileLoding ?? this.isProfileLoding,
      isProfileSuccess: isProfileSuccess ?? this.isProfileSuccess,
      profileErrorMessage: profileErrorMessage ?? this.profileErrorMessage,
      profileResponseData: profileResponseData ?? this.profileResponseData,
    );
  }
}

class ProfileProvider extends StateNotifier<ProfileState> {
  ProfileProvider() : super(ProfileState.initial());

  final ProfileRepositoryImpl _profileRepository = ProfileRepositoryImpl();

  Future<void> getProfileInfo() async {
    state = state.copyWith(
      isProfileLoding: true,
      isProfileSuccess: false,
      profileErrorMessage: '',
    );

    try {
      final profileResponse = await _profileRepository.getProfileInfo();

      state = state.copyWith(
        isProfileLoding: false,
        isProfileSuccess: profileResponse.success ?? false,
        profileErrorMessage: profileResponse.message ?? '',
        profileResponseData: profileResponse,
      );
    } catch (e) {
      state = state.copyWith(
        isProfileLoding: false,
        isProfileSuccess: false,
        profileErrorMessage: 'Failed to fetch profile: ${e.toString()}',
        profileResponseData: ProfileResponseData(),
      );
    }
  }
}

final profileViewmodel = StateNotifierProvider<ProfileProvider, ProfileState>(
  (ref) => ProfileProvider(),
);
