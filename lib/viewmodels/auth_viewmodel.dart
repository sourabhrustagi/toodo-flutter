import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  
  bool _isLoggedIn = false;
  bool _isLoading = false;
  String? _userId;
  String? _userPhone;
  String? _generatedOTP;
  String _phoneNumber = '';
  String _enteredOTP = '';
  String _errorMessage = '';

  // Getters
  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;
  String? get userId => _userId;
  String? get userPhone => _userPhone;
  String get phoneNumber => _phoneNumber;
  String get enteredOTP => _enteredOTP;
  String get errorMessage => _errorMessage;

  // Initialize
  Future<void> initialize() async {
    _setLoading(true);
    try {
      _isLoggedIn = await _authService.isLoggedIn();
      if (_isLoggedIn) {
        _userId = await _authService.getUserId();
        _userPhone = await _authService.getUserPhone();
      }
    } catch (e) {
      _errorMessage = 'Failed to check login status: $e';
    } finally {
      _setLoading(false);
    }
  }

  // Set phone number
  void setPhoneNumber(String phone) {
    _phoneNumber = phone;
    _errorMessage = '';
    notifyListeners();
  }

  // Set entered OTP
  void setEnteredOTP(String otp) {
    _enteredOTP = otp;
    _errorMessage = '';
    notifyListeners();
  }

  // Generate OTP
  Future<bool> generateOTP() async {
    if (_phoneNumber.isEmpty) {
      _errorMessage = 'Please enter a phone number';
      notifyListeners();
      return false;
    }

    _setLoading(true);
    try {
      _generatedOTP = await _authService.generateOTP();
      _errorMessage = '';
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to generate OTP: $e';
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Verify OTP
  Future<bool> verifyOTP() async {
    if (_enteredOTP.isEmpty) {
      _errorMessage = 'Please enter the OTP';
      notifyListeners();
      return false;
    }

    if (_generatedOTP == null) {
      _errorMessage = 'Please generate OTP first';
      notifyListeners();
      return false;
    }

    _setLoading(true);
    try {
      final success = await _authService.verifyOTP(
        _phoneNumber,
        _enteredOTP,
        _generatedOTP!,
      );

      if (success) {
        _isLoggedIn = true;
        _userId = await _authService.getUserId();
        _userPhone = await _authService.getUserPhone();
        _errorMessage = '';
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Invalid OTP. Please try again.';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Failed to verify OTP: $e';
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Logout
  Future<void> logout() async {
    _setLoading(true);
    try {
      await _authService.logout();
      _isLoggedIn = false;
      _userId = null;
      _userPhone = null;
      _phoneNumber = '';
      _enteredOTP = '';
      _generatedOTP = null;
      _errorMessage = '';
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to logout: $e';
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  // Clear all data (for testing)
  Future<void> clearAllData() async {
    _setLoading(true);
    try {
      await _authService.clearAllData();
      _isLoggedIn = false;
      _userId = null;
      _userPhone = null;
      _phoneNumber = '';
      _enteredOTP = '';
      _generatedOTP = null;
      _errorMessage = '';
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to clear data: $e';
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  // Clear error message
  void clearError() {
    _errorMessage = '';
    notifyListeners();
  }

  // Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Get OTP for testing (in real app, this would be sent via SMS)
  String? get generatedOTP => _generatedOTP;
} 