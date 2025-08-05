import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final SecureStorageService _instance = SecureStorageService._internal();
  factory SecureStorageService() => _instance;
  SecureStorageService._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  // User authentication keys
  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _userIdKey = 'userId';
  static const String _userPhoneKey = 'userPhone';
  static const String _userEmailKey = 'userEmail';
  static const String _authTokenKey = 'authToken';
  static const String _refreshTokenKey = 'refreshToken';

  // Task data keys
  static const String _tasksKey = 'tasks';
  static const String _categoriesKey = 'categories';

  // Settings keys
  static const String _themeModeKey = 'themeMode';
  static const String _autoThemeKey = 'autoTheme';

  // User authentication methods
  Future<bool> isLoggedIn() async {
    try {
      final value = await _storage.read(key: _isLoggedInKey);
      print('SecureStorageService: isLoggedIn() - stored value: $value');
      final result = value == 'true';
      print('SecureStorageService: isLoggedIn() - returning: $result');
      return result;
    } catch (e) {
      print('Error reading login state: $e');
      return false;
    }
  }

  Future<String?> getUserId() async {
    try {
      return await _storage.read(key: _userIdKey);
    } catch (e) {
      print('Error reading user ID: $e');
      return null;
    }
  }

  Future<String?> getUserPhone() async {
    try {
      return await _storage.read(key: _userPhoneKey);
    } catch (e) {
      print('Error reading user phone: $e');
      return null;
    }
  }

  Future<String?> getUserEmail() async {
    try {
      return await _storage.read(key: _userEmailKey);
    } catch (e) {
      print('Error reading user email: $e');
      return null;
    }
  }

  Future<String?> getAuthToken() async {
    try {
      return await _storage.read(key: _authTokenKey);
    } catch (e) {
      print('Error reading auth token: $e');
      return null;
    }
  }

  Future<String?> getRefreshToken() async {
    try {
      return await _storage.read(key: _refreshTokenKey);
    } catch (e) {
      print('Error reading refresh token: $e');
      return null;
    }
  }

  Future<void> saveLoginState(String userId, String phoneNumber) async {
    try {
      await _storage.write(key: _isLoggedInKey, value: 'true');
      await _storage.write(key: _userIdKey, value: userId);
      await _storage.write(key: _userPhoneKey, value: phoneNumber);
    } catch (e) {
      print('Error saving login state: $e');
    }
  }

  Future<void> saveEmailLoginState(String userId, String email) async {
    try {
      await _storage.write(key: _isLoggedInKey, value: 'true');
      await _storage.write(key: _userIdKey, value: userId);
      await _storage.write(key: _userEmailKey, value: email);
    } catch (e) {
      print('Error saving email login state: $e');
    }
  }

  Future<void> saveAuthToken(String token) async {
    try {
      await _storage.write(key: _authTokenKey, value: token);
    } catch (e) {
      print('Error saving auth token: $e');
    }
  }

  Future<void> saveRefreshToken(String token) async {
    try {
      await _storage.write(key: _refreshTokenKey, value: token);
    } catch (e) {
      print('Error saving refresh token: $e');
    }
  }

  Future<void> clearLoginState() async {
    try {
      await _storage.delete(key: _isLoggedInKey);
      await _storage.delete(key: _userIdKey);
      await _storage.delete(key: _userPhoneKey);
      await _storage.delete(key: _userEmailKey);
      await _storage.delete(key: _authTokenKey);
      await _storage.delete(key: _refreshTokenKey);
    } catch (e) {
      print('Error clearing login state: $e');
    }
  }

  Future<void> clearAuthToken() async {
    try {
      await _storage.delete(key: _authTokenKey);
      await _storage.delete(key: _refreshTokenKey);
    } catch (e) {
      print('Error clearing auth tokens: $e');
    }
  }

  Future<void> clearAllData() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      print('Error clearing all data: $e');
    }
  }

  // Task data methods
  Future<void> saveTasks(String tasksJson) async {
    try {
      await _storage.write(key: _tasksKey, value: tasksJson);
    } catch (e) {
      print('Error saving tasks: $e');
    }
  }

  Future<String?> getTasks() async {
    try {
      return await _storage.read(key: _tasksKey);
    } catch (e) {
      print('Error reading tasks: $e');
      return null;
    }
  }

  Future<void> saveCategories(String categoriesJson) async {
    try {
      await _storage.write(key: _categoriesKey, value: categoriesJson);
    } catch (e) {
      print('Error saving categories: $e');
    }
  }

  Future<String?> getCategories() async {
    try {
      return await _storage.read(key: _categoriesKey);
    } catch (e) {
      print('Error reading categories: $e');
      return null;
    }
  }

  // Settings methods
  Future<void> saveThemeMode(String themeMode) async {
    try {
      await _storage.write(key: _themeModeKey, value: themeMode);
    } catch (e) {
      print('Error saving theme mode: $e');
    }
  }

  Future<String?> getThemeMode() async {
    try {
      return await _storage.read(key: _themeModeKey);
    } catch (e) {
      print('Error reading theme mode: $e');
      return null;
    }
  }

  Future<void> saveAutoTheme(bool autoTheme) async {
    try {
      await _storage.write(key: _autoThemeKey, value: autoTheme.toString());
    } catch (e) {
      print('Error saving auto theme: $e');
    }
  }

  Future<bool> getAutoTheme() async {
    try {
      final value = await _storage.read(key: _autoThemeKey);
      return value == 'true';
    } catch (e) {
      print('Error reading auto theme: $e');
      return false;
    }
  }

  // Utility methods
  Future<void> deleteKey(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      print('Error deleting key $key: $e');
    }
  }

  Future<List<String>> getAllKeys() async {
    try {
      return await _storage.readAll().then((map) => map.keys.toList());
    } catch (e) {
      print('Error reading all keys: $e');
      return [];
    }
  }

  Future<bool> containsKey(String key) async {
    try {
      return await _storage.containsKey(key: key);
    } catch (e) {
      print('Error checking if key exists: $e');
      return false;
    }
  }
} 