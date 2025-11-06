import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  static SharedPreferences? _prefs;

  // Keys
  static const String loginSuccessKey = "loginSuccess";
  static const String userDataKey = "userData";
  static const String tokenKey = "authToken";
  static const String customerIdKey = "customerId";

  // Call this once at app startup
  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // Save login status
  static Future<void> saveLoginSuccess(bool isSuccess) async {
    await _prefs?.setBool(loginSuccessKey, isSuccess);
  }

  // Save API response (token + customerId + full raw data)
  static Future<void> saveLoginResponse(Map<String, dynamic> response) async {
    final token = response["data"]?["token"] ?? "";
    final customerId = response["customerId"] ?? "";

    await _prefs?.setString(tokenKey, token);
    await _prefs?.setString(customerIdKey, customerId.toString());
    await _prefs?.setString(userDataKey, jsonEncode(response));
    await saveLoginSuccess(true);
  }

  // Get login status
  static bool getLoginSuccess() {
    return _prefs?.getBool(loginSuccessKey) ?? false;
  }

  // Get token
  static String? getToken() {
    return _prefs?.getString(tokenKey);
  }

  // Get customer ID
  static String? getCustomerId() {
    return _prefs?.getString(customerIdKey);
  }

  // Get full user data
  static Map<String, dynamic>? getUserData() {
    final jsonString = _prefs?.getString(userDataKey);
    if (jsonString == null) return null;
    return jsonDecode(jsonString);
  }

  // Clear only login-related data
  static Future<void> clearLoginData() async {
    await _prefs?.remove(loginSuccessKey);
    await _prefs?.remove(tokenKey);
    await _prefs?.remove(customerIdKey);
    await _prefs?.remove(userDataKey);
  }
}
