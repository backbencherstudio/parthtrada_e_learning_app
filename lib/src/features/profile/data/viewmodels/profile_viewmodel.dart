import 'package:e_learning_app/src/features/profile/data/models/profile_response_data.dart';
import 'package:e_learning_app/src/features/profile/data/repository/profile_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileState {
  final bool isProfileLoding;
  final bool isProfileSuccess;
  final String profileErrorMessage;
  final ProfileResponseData profileResponseData;

  final bool isUpdateProfileLoading;
  final bool isUpdateProfileSuccess;
  final String updateProfileErrorMessage;

  ProfileState({
    required this.isProfileLoding,
    required this.isProfileSuccess,
    required this.profileErrorMessage,
    required this.profileResponseData,

    required this.isUpdateProfileLoading,
    required this.isUpdateProfileSuccess,
    required this.updateProfileErrorMessage,
  });

  ProfileState.initial()
    : isProfileLoding = false,
      isProfileSuccess = false,
      profileResponseData = ProfileResponseData(),
      isUpdateProfileSuccess = false,
      isUpdateProfileLoading = false,
      updateProfileErrorMessage = '',
      profileErrorMessage = '';

  ProfileState copyWith({
    bool? isProfileLoding,
    bool? isProfileSuccess,
    String? profileErrorMessage,
    ProfileResponseData? profileResponseData,

    bool? isUpdateProfileLoading,
    bool? isUpdateProfileSuccess,
    String? updateProfileErrorMessage,
  }) {
    return ProfileState(
      isProfileLoding: isProfileLoding ?? this.isProfileLoding,
      isProfileSuccess: isProfileSuccess ?? this.isProfileSuccess,
      profileErrorMessage: profileErrorMessage ?? this.profileErrorMessage,
      profileResponseData: profileResponseData ?? this.profileResponseData,
      isUpdateProfileLoading:
          isUpdateProfileLoading ?? this.isUpdateProfileLoading,
      isUpdateProfileSuccess:
          isUpdateProfileSuccess ?? this.isUpdateProfileSuccess,
      updateProfileErrorMessage:
          updateProfileErrorMessage ?? this.updateProfileErrorMessage,
    );
  }
}

class ProfileProvider extends StateNotifier<ProfileState> {
  ProfileProvider() : super(ProfileState.initial()) {
    getProfileInfo();
  }


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

  Future<bool> updateProfileInfo(
    String profession,
    String organization,
    String location,
    String description,
  ) async {
    state = state.copyWith(
      isUpdateProfileLoading: true,
      isUpdateProfileSuccess: false,
      updateProfileErrorMessage: '',
    );

    try {
      final isProfileUpdated = await _profileRepository.updateProfile(
        profession,
        organization,
        location,
        description,
      );

      if (isProfileUpdated) {
        state = state.copyWith(
          isUpdateProfileLoading: false,
          isUpdateProfileSuccess: true,
          updateProfileErrorMessage: '',
        );
        return true;
      } else {
        state = state.copyWith(
          isUpdateProfileLoading: false,
          isUpdateProfileSuccess: false,
          updateProfileErrorMessage: 'Failed to update profile. Try Again!',
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        isUpdateProfileLoading: false,
        isUpdateProfileSuccess: false,
        updateProfileErrorMessage: 'Failed to update profile. Try Again!',
      );
      return false;
    }
  }
}



final profileViewmodel = StateNotifierProvider<ProfileProvider, ProfileState>(
  (ref) => ProfileProvider(),
);
