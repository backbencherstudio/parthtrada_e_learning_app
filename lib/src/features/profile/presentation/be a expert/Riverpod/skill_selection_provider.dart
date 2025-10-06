import 'package:e_learning_app/src/features/profile/data/viewmodels/profile_viewmodel.dart';
import 'package:e_learning_app/src/features/profile/presentation/be%20a%20expert/repository/expert_profile_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/user_profile.dart';

final skillSelectionProvider =
StateNotifierProvider<SkillSelectionNotifier, Set<String>>(
      (ref) => SkillSelectionNotifier(ref),
);

class SkillSelectionNotifier extends StateNotifier<Set<String>> {
  final Ref ref;
  SkillSelectionNotifier(this.ref) : super({});

  bool isLoading = false;
  String? errorMessage;

  // Store profile data using UserProfile model
  UserProfile profileData = UserProfile();

  void toggle(String skill) {
    if (state.contains(skill)) {
      state = {...state}..remove(skill);
    } else {
      state = {...state, skill};
    }
  }

  void remove(String skill) {
    state = {...state}..remove(skill);
  }

  void clear() {
    state = {};
    profileData = UserProfile();
  }

  void updateProfileData(UserProfile newData) {
    profileData = UserProfile(
      name: newData.name ?? profileData.name,
      university: newData.university ?? profileData.university,
      profession: newData.profession ?? profileData.profession,
      organization: newData.organization ?? profileData.organization,
      location: newData.location ?? profileData.location,
      description: newData.description ?? profileData.description,
      experience: newData.experience ?? profileData.experience,
      hourlyRate: newData.hourlyRate ?? profileData.hourlyRate,
      skills: newData.skills ?? profileData.skills,
      availableDays: newData.availableDays ?? profileData.availableDays,
      availableTime: newData.availableTime ?? profileData.availableTime,
    );
  }


  bool validateFields(List<String> fields) {
    final fieldValues = {
      'name': profileData.name,
      'university': profileData.university,
      'profession': profileData.profession,
      'organization': profileData.organization,
      'location': profileData.location,
      'description': profileData.description,
      'experience': profileData.experience,
      'hourlyRate': profileData.hourlyRate,
      'skills': profileData.skills,
      'availableDays': profileData.availableDays,
      'availableTime': profileData.availableTime,
    };
    return fields.every((field) {
      final value = fieldValues[field];
      if (value is String) return value.isNotEmpty;
      if (value is int) return value > 0;
      if (value is List) return value.isNotEmpty;
      return value != null;
    });
  }

  Future<bool> saveExpertProfile() async {
    isLoading = true;
    errorMessage = null;
    final skills = state.toList();
    final ExpertProfileRepositoryImpl expertProfileRepositoryImpl = ExpertProfileRepositoryImpl();

    try {
      final success = await expertProfileRepositoryImpl.saveExpertProfile(
        name: profileData.name,
        university: profileData.university,
        profession: profileData.profession,
        organization: profileData.organization,
        location: profileData.location,
        description: profileData.description,
        experience: profileData.experience,
        hourlyRate: profileData.hourlyRate,
        skills: skills,
        availableDays: profileData.availableDays,
        availableTime: profileData.availableTime,
      );
      isLoading = false;
      return success;


    } catch (e) {
      errorMessage = "Failed to update profile";
      isLoading = false;
      return false;
    }
  }
}