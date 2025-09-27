import 'package:shared_preferences/shared_preferences.dart';

class LoginPreferences {

  Future<void> setAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
  }

  Future<String?> loadAuthToken() async {
    final pref = await SharedPreferences.getInstance();
    final authToken = pref.getString('authToken');

    return authToken;
  }

  Future<void> clearAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
  }

}
