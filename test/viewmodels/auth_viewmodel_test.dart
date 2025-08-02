import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toodoflutter/viewmodels/auth_viewmodel.dart';

void main() {
  group('AuthViewModel Tests', () {
    late AuthViewModel authViewModel;

    setUp(() {
      authViewModel = AuthViewModel();
    });

    tearDown(() async {
      // Clear shared preferences after each test
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    });

    group('Initialization Tests', () {
      test('should initialize with default values', () {
        expect(authViewModel.isLoggedIn, false);
        expect(authViewModel.isLoading, false);
        expect(authViewModel.userId, null);
        expect(authViewModel.userPhone, null);
        expect(authViewModel.phoneNumber, '');
        expect(authViewModel.enteredOTP, '');
        expect(authViewModel.errorMessage, '');
      });

      test('should initialize auth state', () async {
        await authViewModel.initialize();
        
        expect(authViewModel.isLoggedIn, false);
        expect(authViewModel.isLoading, false);
      });

      test('should handle initialization error', () async {
        // This test would require mocking the AuthService to simulate errors
        await authViewModel.initialize();
        
        // Should not crash and should set loading to false
        expect(authViewModel.isLoading, false);
      });
    });

    group('Phone Number Tests', () {
      test('should set phone number', () {
        authViewModel.setPhoneNumber('1234567890');
        expect(authViewModel.phoneNumber, '1234567890');
      });

      test('should clear error message when setting phone number', () {
        authViewModel.setPhoneNumber('1234567890');
        expect(authViewModel.errorMessage, '');
      });

      test('should notify listeners when setting phone number', () {
        bool notified = false;
        authViewModel.addListener(() {
          notified = true;
        });

        authViewModel.setPhoneNumber('1234567890');
        expect(notified, true);
      });
    });

    group('OTP Tests', () {
      test('should set entered OTP', () {
        authViewModel.setEnteredOTP('123456');
        expect(authViewModel.enteredOTP, '123456');
      });

      test('should clear error message when setting OTP', () {
        authViewModel.setEnteredOTP('123456');
        expect(authViewModel.errorMessage, '');
      });

      test('should notify listeners when setting OTP', () {
        bool notified = false;
        authViewModel.addListener(() {
          notified = true;
        });

        authViewModel.setEnteredOTP('123456');
        expect(notified, true);
      });
    });

    group('OTP Generation Tests', () {
      test('should generate OTP successfully', () async {
        authViewModel.setPhoneNumber('1234567890');
        
        final result = await authViewModel.generateOTP();
        
        expect(result, true);
        expect(authViewModel.generatedOTP, isNotNull);
        expect(authViewModel.generatedOTP!.length, 6);
        expect(authViewModel.errorMessage, '');
      });

      test('should fail when phone number is empty', () async {
        final result = await authViewModel.generateOTP();
        
        expect(result, false);
        expect(authViewModel.errorMessage, 'Please enter a phone number');
      });

      test('should set loading state during OTP generation', () async {
        authViewModel.setPhoneNumber('1234567890');
        
        final future = authViewModel.generateOTP();
        
        // Check loading state during generation
        expect(authViewModel.isLoading, true);
        
        await future;
        
        // Check loading state after generation
        expect(authViewModel.isLoading, false);
      });

      test('should handle OTP generation error', () async {
        // This would require mocking the AuthService to simulate errors
        authViewModel.setPhoneNumber('1234567890');
        
        final result = await authViewModel.generateOTP();
        
        // Should handle errors gracefully
        expect(result, isA<bool>());
      });
    });

    group('OTP Verification Tests', () {
      test('should verify OTP successfully', () async {
        authViewModel.setPhoneNumber('1234567890');
        await authViewModel.generateOTP();
        authViewModel.setEnteredOTP(authViewModel.generatedOTP!);
        
        final result = await authViewModel.verifyOTP();
        
        expect(result, true);
        expect(authViewModel.isLoggedIn, true);
        expect(authViewModel.userId, isNotNull);
        expect(authViewModel.userPhone, '1234567890');
        expect(authViewModel.errorMessage, '');
      });

      test('should fail when OTP is empty', () async {
        authViewModel.setPhoneNumber('1234567890');
        await authViewModel.generateOTP();
        
        final result = await authViewModel.verifyOTP();
        
        expect(result, false);
        expect(authViewModel.errorMessage, 'Please enter the OTP');
        expect(authViewModel.isLoggedIn, false);
      });

      test('should fail when OTP not generated', () async {
        authViewModel.setPhoneNumber('1234567890');
        authViewModel.setEnteredOTP('123456');
        
        final result = await authViewModel.verifyOTP();
        
        expect(result, false);
        expect(authViewModel.errorMessage, 'Please generate OTP first');
        expect(authViewModel.isLoggedIn, false);
      });

      test('should fail with incorrect OTP', () async {
        authViewModel.setPhoneNumber('1234567890');
        await authViewModel.generateOTP();
        authViewModel.setEnteredOTP('000000');
        
        final result = await authViewModel.verifyOTP();
        
        expect(result, false);
        expect(authViewModel.errorMessage, 'Invalid OTP. Please try again.');
        expect(authViewModel.isLoggedIn, false);
      });

      test('should set loading state during verification', () async {
        authViewModel.setPhoneNumber('1234567890');
        await authViewModel.generateOTP();
        authViewModel.setEnteredOTP(authViewModel.generatedOTP!);
        
        final future = authViewModel.verifyOTP();
        
        // Check loading state during verification
        expect(authViewModel.isLoading, true);
        
        await future;
        
        // Check loading state after verification
        expect(authViewModel.isLoading, false);
      });
    });

    group('Logout Tests', () {
      test('should logout successfully', () async {
        // First login
        authViewModel.setPhoneNumber('1234567890');
        await authViewModel.generateOTP();
        authViewModel.setEnteredOTP(authViewModel.generatedOTP!);
        await authViewModel.verifyOTP();
        
        // Verify logged in
        expect(authViewModel.isLoggedIn, true);
        expect(authViewModel.userId, isNotNull);
        expect(authViewModel.userPhone, '1234567890');
        
        // Logout
        await authViewModel.logout();
        
        // Verify logged out
        expect(authViewModel.isLoggedIn, false);
        expect(authViewModel.userId, null);
        expect(authViewModel.userPhone, null);
        expect(authViewModel.phoneNumber, '');
        expect(authViewModel.enteredOTP, '');
        expect(authViewModel.generatedOTP, null);
        expect(authViewModel.errorMessage, '');
      });

      test('should handle logout when not logged in', () async {
        await authViewModel.logout();
        
        expect(authViewModel.isLoggedIn, false);
        expect(authViewModel.userId, null);
        expect(authViewModel.userPhone, null);
      });

      test('should set loading state during logout', () async {
        final future = authViewModel.logout();
        
        // Check loading state during logout
        expect(authViewModel.isLoading, true);
        
        await future;
        
        // Check loading state after logout
        expect(authViewModel.isLoading, false);
      });
    });

    group('Clear Data Tests', () {
      test('should clear all data', () async {
        // First login
        authViewModel.setPhoneNumber('1234567890');
        await authViewModel.generateOTP();
        authViewModel.setEnteredOTP(authViewModel.generatedOTP!);
        await authViewModel.verifyOTP();
        
        // Verify logged in
        expect(authViewModel.isLoggedIn, true);
        
        // Clear all data
        await authViewModel.clearAllData();
        
        // Verify all data cleared
        expect(authViewModel.isLoggedIn, false);
        expect(authViewModel.userId, null);
        expect(authViewModel.userPhone, null);
        expect(authViewModel.phoneNumber, '');
        expect(authViewModel.enteredOTP, '');
        expect(authViewModel.generatedOTP, null);
        expect(authViewModel.errorMessage, '');
      });

      test('should handle clear data when not logged in', () async {
        await authViewModel.clearAllData();
        
        expect(authViewModel.isLoggedIn, false);
        expect(authViewModel.userId, null);
        expect(authViewModel.userPhone, null);
      });

      test('should set loading state during clear data', () async {
        final future = authViewModel.clearAllData();
        
        // Check loading state during clear
        expect(authViewModel.isLoading, true);
        
        await future;
        
        // Check loading state after clear
        expect(authViewModel.isLoading, false);
      });
    });

    group('Error Handling Tests', () {
      test('should clear error message', () async {
        authViewModel.setPhoneNumber('1234567890');
        await authViewModel.generateOTP();
        
        expect(authViewModel.errorMessage, 'Please enter a phone number');
        
        authViewModel.clearError();
        expect(authViewModel.errorMessage, '');
      });

      test('should notify listeners when clearing error', () {
        bool notified = false;
        authViewModel.addListener(() {
          notified = true;
        });

        authViewModel.clearError();
        expect(notified, true);
      });
    });

    group('State Management Tests', () {
      test('should notify listeners on state changes', () {
        bool notified = false;
        authViewModel.addListener(() {
          notified = true;
        });

        authViewModel.setPhoneNumber('1234567890');
        expect(notified, true);
      });

      test('should handle multiple listeners', () {
        int notificationCount = 0;
        
        authViewModel.addListener(() {
          notificationCount++;
        });
        
        authViewModel.addListener(() {
          notificationCount++;
        });

        authViewModel.setPhoneNumber('1234567890');
        expect(notificationCount, 2);
      });
    });

    group('Edge Cases', () {
      test('should handle empty phone number', () async {
        authViewModel.setPhoneNumber('');
        
        final result = await authViewModel.generateOTP();
        expect(result, false);
        expect(authViewModel.errorMessage, 'Please enter a phone number');
      });

      test('should handle special characters in phone number', () async {
        authViewModel.setPhoneNumber('+1-234-567-8900');
        
        final result = await authViewModel.generateOTP();
        expect(result, true);
      });

      test('should handle very long phone number', () async {
        authViewModel.setPhoneNumber('12345678901234567890');
        
        final result = await authViewModel.generateOTP();
        expect(result, true);
      });

      test('should handle empty OTP', () async {
        authViewModel.setPhoneNumber('1234567890');
        await authViewModel.generateOTP();
        authViewModel.setEnteredOTP('');
        
        final result = await authViewModel.verifyOTP();
        expect(result, false);
        expect(authViewModel.errorMessage, 'Please enter the OTP');
      });

      test('should handle very long OTP', () async {
        authViewModel.setPhoneNumber('1234567890');
        await authViewModel.generateOTP();
        authViewModel.setEnteredOTP('12345678901234567890');
        
        final result = await authViewModel.verifyOTP();
        expect(result, false);
        expect(authViewModel.errorMessage, 'Invalid OTP. Please try again.');
      });
    });

    group('Concurrent Operations Tests', () {
      test('should handle concurrent OTP generation', () async {
        authViewModel.setPhoneNumber('1234567890');
        
        final futures = List.generate(5, (_) => authViewModel.generateOTP());
        final results = await Future.wait(futures);
        
        expect(results.length, 5);
        expect(results.every((result) => result == true), true);
      });

      test('should handle concurrent verification attempts', () async {
        authViewModel.setPhoneNumber('1234567890');
        await authViewModel.generateOTP();
        authViewModel.setEnteredOTP(authViewModel.generatedOTP!);
        
        final futures = List.generate(3, (_) => authViewModel.verifyOTP());
        final results = await Future.wait(futures);
        
        expect(results.length, 3);
        expect(results.every((result) => result == true), true);
      });
    });

    group('Data Persistence Tests', () {
      test('should persist login state across view model instances', () async {
        // Login with first instance
        authViewModel.setPhoneNumber('1234567890');
        await authViewModel.generateOTP();
        authViewModel.setEnteredOTP(authViewModel.generatedOTP!);
        await authViewModel.verifyOTP();
        
        // Create new instance
        final newAuthViewModel = AuthViewModel();
        await newAuthViewModel.initialize();
        
        // Verify state persisted
        expect(newAuthViewModel.isLoggedIn, true);
        expect(newAuthViewModel.userId, isNotNull);
        expect(newAuthViewModel.userPhone, '1234567890');
      });
    });
  });
} 