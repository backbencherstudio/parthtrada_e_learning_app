class BeExpert {
  String? name;
  String? university;
  String? profession;
  String? organization;
  String? location;
  String? description;
  String? experience;
  int? hourlyRate;
  List<String>? skills;
  List<String>? availableDays;
  List<String>? availableTime;

  BeExpert({
    this.name,
    this.university,
    this.profession,
    this.organization,
    this.location,
    this.description,
    this.experience,
    this.hourlyRate,
    this.skills,
    this.availableDays,
    this.availableTime,
  });

  factory BeExpert.fromJson(Map<String, dynamic> json) {
    return BeExpert(
      name: json['name'],
      university: json['university'],
      profession: json['profession'],
      organization: json['organization'],
      location: json['location'],
      description: json['description'],
      experience: json['experience'],
      hourlyRate: json['hourlyRate'],
      skills: List<String>.from(json['skills'] ?? []),
      availableDays: List<String>.from(json['availableDays'] ?? []),
      availableTime: List<String>.from(json['availableTime'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'university': university,
      'profession': profession,
      'organization': organization,
      'location': location,
      'description': description,
      'experience': experience,
      'hourlyRate': hourlyRate,
      'skills': skills,
      'availableDays': availableDays,
      'availableTime': availableTime,
    };
  }
}
