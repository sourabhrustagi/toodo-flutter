import 'secure_storage_service.dart';
import 'api_service.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final SecureStorageService _secureStorage = SecureStorageService();
  final ApiService _apiService = ApiService();

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
    // Use ApiService to send OTP
    final phoneNumber = await getUserPhone() ?? '';
    if (phoneNumber.isEmpty) {
      throw Exception('No phone number found');
    }
    
    final response = await _apiService.sendOTP(phoneNumber);
    if (response['success'] == true) {
      return '123456'; // Return fixed OTP for testing
    } else {
      throw Exception('Failed to send OTP');
    }
  }

  Future<bool> verifyOTP(String phoneNumber, String enteredOTP, String expectedOTP) async {
    // Use ApiService to verify OTP
    final response = await _apiService.verifyOTP(phoneNumber, enteredOTP);
    if (response['success'] == true) {
      // Save user data from response
      final userData = response['data']['user'];
      await _secureStorage.saveLoginState(userData['id'], userData['phoneNumber']);
      return true;
    } else {
      throw Exception('Invalid OTP. Please enter 123456');
    }
  }

  Future<bool> verifyEmailLogin(String email, String password) async {
    // For now, keep the existing mock implementation
    // In a real app, you would use ApiService to verify email/password
    await Future.delayed(const Duration(seconds: 1));
    if (password == 'password123') {
      await _saveEmailLoginState(email);
      return true;
    }
    throw Exception('Invalid email or password. Use "password123" for testing');
  }

  Future<void> _saveEmailLoginState(String email) async {
    final userId = 'user_${DateTime.now().millisecondsSinceEpoch}';
    await _secureStorage.saveEmailLoginState(userId, email);
  }

  Future<void> logout() async {
    // Use ApiService to logout
    final response = await _apiService.logout();
    if (response['success'] == true) {
      await _secureStorage.clearLoginState();
    } else {
      throw Exception('Failed to logout');
    }
  }

  Future<void> clearAllData() async {
    // Use ApiService to clear all data
    await _secureStorage.clearAllData();
  }
} 