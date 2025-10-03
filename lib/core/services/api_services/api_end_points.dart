class ApiEndPoints {
  static const String baseUrl = 'https://parthtrada.obotoronika.com';
  static const String profileInfo = '/profile/me';
  static const String expertList = '$baseUrl/experts';
  static const String skillList = '$baseUrl/experts/skills';
  static const String statList = '$baseUrl/home/stats';
  static String expertDetail(String expertId) => '$baseUrl/experts/$expertId';
  static String expertReviewsById(String expertId, int page, int limit) => '$baseUrl/experts/$expertId/reviews?page=$page&limit=$limit';
  static String expertReview= '$baseUrl/experts/reviews';
  static const String updateProfile = '/profile/me/update';
  static const String beExpert = '/auth/be-expert';
  static const String conversation = '/conversations';
  static String getMessages(String conversationId, String page, String perPage ) => '$baseUrl/conversations/messages/$conversationId?page=$page&perPage=$perPage';
  static String postMesssage = '/conversations/messages';
  static String addCard = '/payments/add-card';
  static String bookExpert = '$baseUrl/bookings';
  static String getScheduleMeetings(int page, int limit) => '$baseUrl/bookings?page=$page&perPage=$limit';
}
