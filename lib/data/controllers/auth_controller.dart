import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/data/models/user_model.dart';

class AuthController {
  static const String _accessTokenKey = 'access-token';
  static const String _userData = 'user-data';
  static String? accessToken;
  static UserModel? userData;

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

  static Future<void> saveUserInfo(UserModel userModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(
        _userData, jsonEncode(userModel.toJson()));
    sharedPreferences.reload();
    userData = userModel;
  }

  static Future<UserModel?> getUserInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userEncodedModel = sharedPreferences.getString(_userData);
    if (userEncodedModel == null) {
      return null;
    }
    UserModel userModel = UserModel.fromJson(jsonDecode(userEncodedModel));
    userData = userModel;
    return userData;
  }
}
