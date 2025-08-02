import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _userIdKey = 'userId';
  static const String _userPhoneKey = 'userPhone';

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  Future<String?> getUserPhone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userPhoneKey);
  }

  Future<String> generateOTP() async {
    // Return fixed OTP for testing
    return '123456';
  }

  Future<bool> verifyOTP(String phoneNumber, String enteredOTP, String expectedOTP) async {
    // In a real app, you would verify OTP with a server
    // For now, we'll just compare the entered OTP with the expected OTP
    if (enteredOTP == expectedOTP) {
      await _saveLoginState(phoneNumber);
      return true;
    }
    // Throw an error for invalid OTP
    throw Exception('Invalid OTP. Please enter 123456');
  }

  Future<void> _saveLoginState(String phoneNumber) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, true);
    await prefs.setString(_userIdKey, 'user_${DateTime.now().millisecondsSinceEpoch}');
    await prefs.setString(_userPhoneKey, phoneNumber);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, false);
    await prefs.remove(_userIdKey);
    await prefs.remove(_userPhoneKey);
  }

  Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
} 