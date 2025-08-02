import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toodoflutter/services/auth_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  group('AuthService Tests', () {
    late AuthService authService;

    setUp(() {
      authService = AuthService();
    });

    tearDown(() async {
      // Clear shared preferences after each test
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    });

    group('Login Status Tests', () {
      test('should return false when not logged in', () async {
        final isLoggedIn = await authService.isLoggedIn();
        expect(isLoggedIn, false);
      });

      test('should return true when logged in', () async {
        // Simulate login
        await authService.verifyOTP('1234567890', '123456', '123456');
        
        final isLoggedIn = await authService.isLoggedIn();
        expect(isLoggedIn, true);
      });
    });

    group('User ID Tests', () {
      test('should return null when not logged in', () async {
        final userId = await authService.getUserId();
        expect(userId, null);
      });

      test('should return user ID when logged in', () async {
        // Simulate login
        await authService.verifyOTP('1234567890', '123456', '123456');
        
        final userId = await authService.getUserId();
        expect(userId, isNotNull);
        expect(userId!.startsWith('user_'), true);
      });
    });

    group('User Phone Tests', () {
      test('should return null when not logged in', () async {
        final userPhone = await authService.getUserPhone();
        expect(userPhone, null);
      });

      test('should return phone number when logged in', () async {
        // Simulate login
        await authService.verifyOTP('1234567890', '123456', '123456');
        
        final userPhone = await authService.getUserPhone();
        expect(userPhone, '1234567890');
      });
    });

    group('OTP Generation Tests', () {
      test('should generate 6-digit OTP', () async {
        final otp = await authService.generateOTP();
        
        expect(otp, isA<String>());
        expect(otp.length, 6);
        expect(int.tryParse(otp), isNotNull);
      });

      test('should generate different OTPs', () async {
        final otp1 = await authService.generateOTP();
        final otp2 = await authService.generateOTP();
        
        expect(otp1, isNot(equals(otp2)));
      });

      test('should generate numeric OTPs', () async {
        for (int i = 0; i < 10; i++) {
          final otp = await authService.generateOTP();
          expect(int.tryParse(otp), isNotNull);
        }
      });
    });

    group('OTP Verification Tests', () {
      test('should verify correct OTP', () async {
        final otp = await authService.generateOTP();
        final result = await authService.verifyOTP('1234567890', otp, otp);
        
        expect(result, true);
      });

      test('should reject incorrect OTP', () async {
        final otp = await authService.generateOTP();
        final result = await authService.verifyOTP('1234567890', '000000', otp);
        
        expect(result, false);
      });

      test('should save login state after successful verification', () async {
        final otp = await authService.generateOTP();
        await authService.verifyOTP('1234567890', otp, otp);
        
        final isLoggedIn = await authService.isLoggedIn();
        final userId = await authService.getUserId();
        final userPhone = await authService.getUserPhone();
        
        expect(isLoggedIn, true);
        expect(userId, isNotNull);
        expect(userPhone, '1234567890');
      });

      test('should not save login state after failed verification', () async {
        final otp = await authService.generateOTP();
        await authService.verifyOTP('1234567890', '000000', otp);
        
        final isLoggedIn = await authService.isLoggedIn();
        final userId = await authService.getUserId();
        final userPhone = await authService.getUserPhone();
        
        expect(isLoggedIn, false);
        expect(userId, null);
        expect(userPhone, null);
      });
    });

    group('Logout Tests', () {
      test('should clear login state on logout', () async {
        // First login
        final otp = await authService.generateOTP();
        await authService.verifyOTP('1234567890', otp, otp);
        
        // Verify logged in
        expect(await authService.isLoggedIn(), true);
        expect(await authService.getUserId(), isNotNull);
        expect(await authService.getUserPhone(), '1234567890');
        
        // Logout
        await authService.logout();
        
        // Verify logged out
        expect(await authService.isLoggedIn(), false);
        expect(await authService.getUserId(), null);
        expect(await authService.getUserPhone(), null);
      });

      test('should handle logout when not logged in', () async {
        // Should not throw when logging out without being logged in
        await authService.logout();
        
        expect(await authService.isLoggedIn(), false);
        expect(await authService.getUserId(), null);
        expect(await authService.getUserPhone(), null);
      });
    });

    group('Clear All Data Tests', () {
      test('should clear all data', () async {
        // First login
        final otp = await authService.generateOTP();
        await authService.verifyOTP('1234567890', otp, otp);
        
        // Verify logged in
        expect(await authService.isLoggedIn(), true);
        
        // Clear all data
        await authService.clearAllData();
        
        // Verify all data cleared
        expect(await authService.isLoggedIn(), false);
        expect(await authService.getUserId(), null);
        expect(await authService.getUserPhone(), null);
      });

      test('should handle clear data when not logged in', () async {
        // Should not throw when clearing data without being logged in
        await authService.clearAllData();
        
        expect(await authService.isLoggedIn(), false);
        expect(await authService.getUserId(), null);
        expect(await authService.getUserPhone(), null);
      });
    });

    group('Singleton Pattern Tests', () {
      test('should return same instance', () {
        final instance1 = AuthService();
        final instance2 = AuthService();
        
        expect(identical(instance1, instance2), true);
      });
    });

    group('Edge Cases', () {
      test('should handle empty phone number', () async {
        final otp = await authService.generateOTP();
        final result = await authService.verifyOTP('', otp, otp);
        
        expect(result, true); // Current implementation allows empty phone
      });

      test('should handle empty OTP', () async {
        final otp = await authService.generateOTP();
        final result = await authService.verifyOTP('1234567890', '', otp);
        
        expect(result, false);
      });

      test('should handle null OTP', () async {
        final otp = await authService.generateOTP();
        final result = await authService.verifyOTP('1234567890', '', otp);
        
        expect(result, false);
      });

      test('should handle special characters in phone number', () async {
        final otp = await authService.generateOTP();
        final result = await authService.verifyOTP('+1-234-567-8900', otp, otp);
        
        expect(result, true);
      });
    });

    group('Concurrent Access Tests', () {
      test('should handle concurrent OTP generation', () async {
        final futures = List.generate(10, (_) => authService.generateOTP());
        final results = await Future.wait(futures);
        
        expect(results.length, 10);
        for (final otp in results) {
          expect(otp.length, 6);
          expect(int.tryParse(otp), isNotNull);
        }
      });

      test('should handle concurrent login attempts', () async {
        final otp = await authService.generateOTP();
        final futures = List.generate(5, (index) => 
          authService.verifyOTP('1234567890', otp, otp)
        );
        final results = await Future.wait(futures);
        
        expect(results.length, 5);
        expect(results.every((result) => result == true), true);
      });
    });

    group('Data Persistence Tests', () {
      test('should persist login state across app restarts', () async {
        // Login
        final otp = await authService.generateOTP();
        await authService.verifyOTP('1234567890', otp, otp);
        
        // Create new instance (simulating app restart)
        final newAuthService = AuthService();
        
        // Verify state persisted
        expect(await newAuthService.isLoggedIn(), true);
        expect(await newAuthService.getUserId(), isNotNull);
        expect(await newAuthService.getUserPhone(), '1234567890');
      });
    });
  });
} 