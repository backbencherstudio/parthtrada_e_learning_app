class ApiEndPoints {
  static const String baseUrl = 'https://parthtrada.obotoronika.com';
  static const String profileInfo = '/profile/me';
  static String expertList(int page, int limit) => '$baseUrl/experts?page=$page&perPage=$limit';
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
  static String getScheduleMeetingsForStudents(int page, int limit) => '$baseUrl/bookings?page=$page&perPage=$limit';
  static String getScheduleMeetingsForExperts(int page, int limit) => '$baseUrl/bookings/schedule/expert?page=$page&perPage=$limit';
  static String getPastCalls(int page, int limit) => '$baseUrl/bookings/past-call?page=$page&perPage=$limit';
  static String getSendRequests(int page, int limit) => '$baseUrl/bookings/request?page=$page&perPage=$limit';
  static String getNotifications(int page, int limit) => '$baseUrl/notifications?page=$page&perPage=$limit';
  static String cancelScheduleMeetings(String scheduleId) => '$baseUrl/bookings/cancel/$scheduleId';
  static String completedScheduleMeetings(String scheduleId) => '$baseUrl/experts/complete-session/$scheduleId';
  static String addReview = '$baseUrl/reviews';
  static String getCards = '$baseUrl/payments/cards';
  static String confirmPayment = '$baseUrl/payments/confirm-payment';
  static String getStudentById(String sId) => '$baseUrl/students/$sId';
  static String transactionsHistory = '/payments/transactions';

  static String createAccount = '/payments/stripe/create-account';
  static String onboardingLink = '/payments/stripe/onboarding-link';
  static String checkAccoutStatus = '/payments/stripe/status';
  static String balanceCheck = '/payments/experts/balance';
  static String payoutBalance = '/payments/experts/payouts';
}
