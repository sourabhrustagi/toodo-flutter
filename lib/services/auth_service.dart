import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'secure_storage_service.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final SecureStorageService _secureStorage = SecureStorageService();

  Future<bool> isLoggedIn() async {
    final result = await _secureStorage.isLoggedIn();
    print('AuthService: isLoggedIn() returned $result');
    return result;
  }

  Future<String?> getUserId() async {
    return await _secureStorage.getUserId();
  }

  Future<String?> getUserPhone() async {
    return await _secureStorage.getUserPhone();
  }

  Future<String?> getUserEmail() async {
    return await _secureStorage.getUserEmail();
  }

  Future<String> generateOTP() async {
    // Simulate API call with 1 second delay
    await Future.delayed(const Duration(seconds: 1));
    // Return fixed OTP for testing
    return '123456';
  }

  Future<bool> verifyOTP(String phoneNumber, String enteredOTP, String expectedOTP) async {
    // Simulate API call with 1 second delay
    await Future.delayed(const Duration(seconds: 1));
    // In a real app, you would verify OTP with a server
    // For now, we'll just compare the entered OTP with the expected OTP
    if (enteredOTP == expectedOTP) {
      await _saveLoginState(phoneNumber);
      return true;
    }
    // Throw an error for invalid OTP
    throw Exception('Invalid OTP. Please enter 123456');
  }

  Future<bool> verifyEmailLogin(String email, String password) async {
    // Simulate API call with 1 second delay
    await Future.delayed(const Duration(seconds: 1));
    // In a real app, you would verify email/password with a server
    // For testing, accept any email with password "password123"
    if (password == 'password123') {
      await _saveEmailLoginState(email);
      return true;
    }
    // Throw an error for invalid credentials
    throw Exception('Invalid email or password. Use "password123" for testing');
  }

  Future<void> _saveLoginState(String phoneNumber) async {
    final userId = 'user_${DateTime.now().millisecondsSinceEpoch}';
    await _secureStorage.saveLoginState(userId, phoneNumber);
  }

  Future<void> _saveEmailLoginState(String email) async {
    final userId = 'user_${DateTime.now().millisecondsSinceEpoch}';
    await _secureStorage.saveEmailLoginState(userId, email);
  }

  Future<void> logout() async {
    // Simulate API call with 1 second delay
    await Future.delayed(const Duration(seconds: 1));
    await _secureStorage.clearLoginState();
  }

  Future<void> clearAllData() async {
    // Simulate API call with 1 second delay
    await Future.delayed(const Duration(seconds: 1));
    await _secureStorage.clearAllData();
  }
} 