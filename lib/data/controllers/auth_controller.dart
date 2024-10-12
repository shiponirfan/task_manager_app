import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static const String _accessTokenKey = 'access-token';
  static const String _userName = 'user-name';
  static const String _userEmail = 'user-email';
  static String? accessToken;
  static String? userName;
  static String? userEmail;

  static Future<void> saveAccessToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey, token);
    accessToken = token;
  }

  static Future<String?> getAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessTokenKey);
    accessToken = token;
    return token;
  }

  static Future<void> clearAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    accessToken = null;
  }

  static bool isLoggedIn() {
    return accessToken != null;
  }

  static Future<void> saveUserinfo(
      {required String firstName, required String lastName, required String email}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userName, '$firstName $lastName');
    await sharedPreferences.setString(_userEmail, email);
    userName = '$firstName $lastName';
    userEmail = email;
  }

  static Future<void> getUserInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? name = sharedPreferences.getString(_userName);
    String? email = sharedPreferences.getString(_userEmail);
    userName = name;
    userEmail = email;
  }
}
