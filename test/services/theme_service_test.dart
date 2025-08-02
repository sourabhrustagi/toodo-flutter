import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toodoflutter/services/theme_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  group('ThemeService Tests', () {
    late ThemeService themeService;

    setUp(() {
      themeService = ThemeService();
    });

    tearDown(() async {
      // Clear shared preferences after each test
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    });

    group('Initialization Tests', () {
      test('should initialize with system theme mode', () {
        expect(themeService.themeMode, ThemeMode.system);
      });

      test('should be singleton instance', () {
        final instance1 = ThemeService();
        final instance2 = ThemeService();
        
        expect(identical(instance1, instance2), true);
      });
    });

    group('Theme Mode Tests', () {
      test('should set theme mode to light', () async {
        await themeService.setThemeMode(ThemeMode.light);
        expect(themeService.themeMode, ThemeMode.light);
      });

      test('should set theme mode to dark', () async {
        await themeService.setThemeMode(ThemeMode.dark);
        expect(themeService.themeMode, ThemeMode.dark);
      });

      test('should set theme mode to system', () async {
        await themeService.setThemeMode(ThemeMode.system);
        expect(themeService.themeMode, ThemeMode.system);
      });

      test('should persist theme mode', () async {
        await themeService.setThemeMode(ThemeMode.dark);
        
        // Create new instance to test persistence
        final newThemeService = ThemeService();
        await Future.delayed(const Duration(milliseconds: 100)); // Wait for async load
        
        expect(newThemeService.themeMode, ThemeMode.dark);
      });
    });

    group('Toggle Theme Tests', () {
      test('should toggle from light to dark', () async {
        await themeService.setThemeMode(ThemeMode.light);
        await themeService.toggleTheme();
        expect(themeService.themeMode, ThemeMode.dark);
      });

      test('should toggle from dark to light', () async {
        await themeService.setThemeMode(ThemeMode.dark);
        await themeService.toggleTheme();
        expect(themeService.themeMode, ThemeMode.light);
      });

      test('should toggle from system to light', () async {
        await themeService.setThemeMode(ThemeMode.system);
        await themeService.toggleTheme();
        expect(themeService.themeMode, ThemeMode.light);
      });
    });

    group('Dark Mode Detection Tests', () {
      test('should return false for light mode', () async {
        await themeService.setThemeMode(ThemeMode.light);
        expect(themeService.isDarkMode, false);
      });

      test('should return true for dark mode', () async {
        await themeService.setThemeMode(ThemeMode.dark);
        expect(themeService.isDarkMode, true);
      });

      test('should return false for system mode (default)', () async {
        await themeService.setThemeMode(ThemeMode.system);
        expect(themeService.isDarkMode, false); // Default implementation returns false
      });
    });

    group('Light Theme Tests', () {
      test('should create light theme with correct properties', () {
        final theme = themeService.lightTheme;
        
        expect(theme.useMaterial3, true);
        expect(theme.colorScheme.brightness, Brightness.light);
        expect(theme.appBarTheme.centerTitle, true);
        expect(theme.appBarTheme.elevation, 0);
        expect(theme.cardTheme.elevation, 2);
        expect(theme.floatingActionButtonTheme.elevation, 4);
      });

      test('should have correct color scheme', () {
        final theme = themeService.lightTheme;
        final colorScheme = theme.colorScheme;
        
        expect(colorScheme.brightness, Brightness.light);
        expect(colorScheme.primary, isNotNull);
        expect(colorScheme.onPrimary, isNotNull);
        expect(colorScheme.surface, isNotNull);
        expect(colorScheme.onSurface, isNotNull);
      });

      test('should have correct card theme', () {
        final theme = themeService.lightTheme;
        final cardTheme = theme.cardTheme;
        
        expect(cardTheme.elevation, 2);
        expect(cardTheme.shape, isA<RoundedRectangleBorder>());
        
        final shape = cardTheme.shape as RoundedRectangleBorder;
        expect(shape.borderRadius, BorderRadius.circular(12));
      });

      test('should have correct app bar theme', () {
        final theme = themeService.lightTheme;
        final appBarTheme = theme.appBarTheme;
        
        expect(appBarTheme.centerTitle, true);
        expect(appBarTheme.elevation, 0);
      });

      test('should have correct floating action button theme', () {
        final theme = themeService.lightTheme;
        final fabTheme = theme.floatingActionButtonTheme;
        
        expect(fabTheme.elevation, 4);
      });
    });

    group('Dark Theme Tests', () {
      test('should create dark theme with correct properties', () {
        final theme = themeService.darkTheme;
        
        expect(theme.useMaterial3, true);
        expect(theme.colorScheme.brightness, Brightness.dark);
        expect(theme.appBarTheme.centerTitle, true);
        expect(theme.appBarTheme.elevation, 0);
        expect(theme.cardTheme.elevation, 2);
        expect(theme.floatingActionButtonTheme.elevation, 4);
      });

      test('should have correct color scheme', () {
        final theme = themeService.darkTheme;
        final colorScheme = theme.colorScheme;
        
        expect(colorScheme.brightness, Brightness.dark);
        expect(colorScheme.primary, isNotNull);
        expect(colorScheme.onPrimary, isNotNull);
        expect(colorScheme.surface, isNotNull);
        expect(colorScheme.onSurface, isNotNull);
      });

      test('should have correct card theme', () {
        final theme = themeService.darkTheme;
        final cardTheme = theme.cardTheme;
        
        expect(cardTheme.elevation, 2);
        expect(cardTheme.shape, isA<RoundedRectangleBorder>());
        
        final shape = cardTheme.shape as RoundedRectangleBorder;
        expect(shape.borderRadius, BorderRadius.circular(12));
      });

      test('should have correct app bar theme', () {
        final theme = themeService.darkTheme;
        final appBarTheme = theme.appBarTheme;
        
        expect(appBarTheme.centerTitle, true);
        expect(appBarTheme.elevation, 0);
      });

      test('should have correct floating action button theme', () {
        final theme = themeService.darkTheme;
        final fabTheme = theme.floatingActionButtonTheme;
        
        expect(fabTheme.elevation, 4);
      });
    });

    group('Theme Consistency Tests', () {
      test('should have consistent properties between light and dark themes', () {
        final lightTheme = themeService.lightTheme;
        final darkTheme = themeService.darkTheme;
        
        expect(lightTheme.useMaterial3, darkTheme.useMaterial3);
        expect(lightTheme.appBarTheme.centerTitle, darkTheme.appBarTheme.centerTitle);
        expect(lightTheme.appBarTheme.elevation, darkTheme.appBarTheme.elevation);
        expect(lightTheme.cardTheme.elevation, darkTheme.cardTheme.elevation);
        expect(lightTheme.floatingActionButtonTheme.elevation, darkTheme.floatingActionButtonTheme.elevation);
      });

      test('should have different brightness', () {
        final lightTheme = themeService.lightTheme;
        final darkTheme = themeService.darkTheme;
        
        expect(lightTheme.colorScheme.brightness, Brightness.light);
        expect(darkTheme.colorScheme.brightness, Brightness.dark);
      });
    });

    group('Shared Preferences Tests', () {
      test('should load theme mode from shared preferences', () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('theme_mode', ThemeMode.dark.index);
        
        // Create new instance to test loading
        final newThemeService = ThemeService();
        await Future.delayed(const Duration(milliseconds: 100)); // Wait for async load
        
        expect(newThemeService.themeMode, ThemeMode.dark);
      });

      test('should handle missing theme mode in shared preferences', () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('theme_mode');
        
        // Create new instance to test loading
        final newThemeService = ThemeService();
        await Future.delayed(const Duration(milliseconds: 100)); // Wait for async load
        
        expect(newThemeService.themeMode, ThemeMode.system);
      });

      test('should save theme mode to shared preferences', () async {
        await themeService.setThemeMode(ThemeMode.light);
        
        final prefs = await SharedPreferences.getInstance();
        final savedIndex = prefs.getInt('theme_mode');
        
        expect(savedIndex, ThemeMode.light.index);
      });
    });

    group('Change Notifier Tests', () {
      test('should notify listeners when theme mode changes', () async {
        bool notified = false;
        
        themeService.addListener(() {
          notified = true;
        });
        
        await themeService.setThemeMode(ThemeMode.dark);
        
        expect(notified, true);
      });

      test('should notify listeners when theme is toggled', () async {
        bool notified = false;
        
        themeService.addListener(() {
          notified = true;
        });
        
        await themeService.toggleTheme();
        
        expect(notified, true);
      });
    });

    group('Edge Cases', () {
      test('should handle invalid theme mode index', () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('theme_mode', 999); // Invalid index
        
        // Create new instance to test loading
        final newThemeService = ThemeService();
        await Future.delayed(const Duration(milliseconds: 100)); // Wait for async load
        
        // Should default to system mode
        expect(newThemeService.themeMode, ThemeMode.system);
      });

      test('should handle null theme mode in shared preferences', () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('theme_mode', 'invalid'); // Wrong type
        
        // Create new instance to test loading
        final newThemeService = ThemeService();
        await Future.delayed(const Duration(milliseconds: 100)); // Wait for async load
        
        // Should default to system mode
        expect(newThemeService.themeMode, ThemeMode.system);
      });
    });

    group('Performance Tests', () {
      test('should create themes quickly', () {
        final stopwatch = Stopwatch()..start();
        
        themeService.lightTheme;
        themeService.darkTheme;
        
        stopwatch.stop();
        expect(stopwatch.elapsed.inMilliseconds, lessThan(100));
      });

      test('should toggle theme quickly', () async {
        final stopwatch = Stopwatch()..start();
        
        await themeService.toggleTheme();
        
        stopwatch.stop();
        expect(stopwatch.elapsed.inMilliseconds, lessThan(100));
      });
    });

    group('Memory Tests', () {
      test('should not create new theme instances unnecessarily', () {
        final lightTheme1 = themeService.lightTheme;
        final lightTheme2 = themeService.lightTheme;
        final darkTheme1 = themeService.darkTheme;
        final darkTheme2 = themeService.darkTheme;
        
        // Themes should be the same instances (though this depends on implementation)
        expect(lightTheme1, lightTheme2);
        expect(darkTheme1, darkTheme2);
      });
    });
  });
} 