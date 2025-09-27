class ApiEndPoints {
  static const String baseUrl = 'https://parthtrada.obotoronika.com';
  static const String profileInfo = '/profile/me';
  static const String expertList = '$baseUrl/experts';
  static String expertDetail(String expertId) => '$baseUrl/experts/$expertId';
  static const String updateProfile = '/profile/me/update';
}
