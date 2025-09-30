abstract class ExpertProfileRepository {
  Future<bool> saveExpertProfile({
    String? name,
    String? university,
    String? profession,
    String? organization,
    String? location,
    String? description,
    String? experience,
    int? hourlyRate,
    List<String>? skills,
    List<String>? availableDays,
    List<String>? availableTime,
  });
}
