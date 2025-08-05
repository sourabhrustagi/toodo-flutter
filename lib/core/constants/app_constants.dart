import 'package:flutter/foundation.dart';

/// Application constants and configuration values
class AppConstants {
  // App Information
  static const String appName = 'Todo App';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'A modern todo application built with Flutter';
  
  // Database
  static const String databaseName = 'todo_app.db';
  static const int databaseVersion = 1;
  
  // API Configuration based on flavor
  static String get baseUrl {
    switch (const String.fromEnvironment('FLAVOR', defaultValue: 'mock')) {
      case 'production':
        return 'https://api.todoapp.com/v1';
      case 'development':
        return 'https://dev-api.todoapp.com/v1';
      case 'mock':
      default:
        return 'https://mock-api.todoapp.com/v1';
    }
  }
  
  static Duration get apiTimeout {
    switch (const String.fromEnvironment('FLAVOR', defaultValue: 'mock')) {
      case 'production':
        return const Duration(seconds: 30);
      case 'development':
        return const Duration(seconds: 15);
      case 'mock':
      default:
        return const Duration(seconds: 5);
    }
  }
  
  static int get maxRetries {
    switch (const String.fromEnvironment('FLAVOR', defaultValue: 'mock')) {
      case 'production':
        return 3;
      case 'development':
        return 2;
      case 'mock':
      default:
        return 1;
    }
  }
  
  // API Feature Flags based on flavor
  static bool get useMockApi {
    switch (const String.fromEnvironment('FLAVOR', defaultValue: 'mock')) {
      case 'production':
        return false;
      case 'development':
        return false;
      case 'mock':
      default:
        return true;
    }
  }
  
  static bool get enableApiLogging {
    switch (const String.fromEnvironment('FLAVOR', defaultValue: 'mock')) {
      case 'production':
        return false;
      case 'development':
        return true;
      case 'mock':
      default:
        return true;
    }
  }
  
  static bool get enableApiRetry {
    switch (const String.fromEnvironment('FLAVOR', defaultValue: 'mock')) {
      case 'production':
        return true;
      case 'development':
        return true;
      case 'mock':
      default:
        return false;
    }
  }
  
  // Mock API Configuration
  static Duration get mockApiDelay {
    switch (const String.fromEnvironment('FLAVOR', defaultValue: 'mock')) {
      case 'production':
        return const Duration(milliseconds: 500);
      case 'development':
        return const Duration(seconds: 1);
      case 'mock':
      default:
        return const Duration(seconds: 2);
    }
  }
  
  static double get mockApiFailureRate {
    switch (const String.fromEnvironment('FLAVOR', defaultValue: 'mock')) {
      case 'production':
        return 0.0;
      case 'development':
        return 0.05;
      case 'mock':
      default:
        return 0.1;
    }
  }
  
  // Current flavor
  static String get currentFlavor => const String.fromEnvironment('FLAVOR', defaultValue: 'mock');
  
  // Environment-specific settings
  static bool get isProduction => currentFlavor == 'production';
  static bool get isDevelopment => currentFlavor == 'development';
  static bool get isMock => currentFlavor == 'mock';
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double borderRadius = 12.0;
  static const double cardElevation = 2.0;
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
  
  // Task Constants
  static const String defaultCategory = 'General';
  static const int maxTitleLength = 100;
  static const int maxDescriptionLength = 500;
  
  // Validation Messages
  static const String titleRequired = 'Title is required';
  static const String titleTooLong = 'Title must be less than $maxTitleLength characters';
  static const String descriptionTooLong = 'Description must be less than $maxDescriptionLength characters';
  
  // Error Messages
  static const String networkError = 'Network error occurred. Please check your connection.';
  static const String serverError = 'Server error occurred. Please try again later.';
  static const String unknownError = 'An unknown error occurred.';
  static const String databaseError = 'Database error occurred.';
  
  // Success Messages
  static const String taskCreated = 'Task created successfully';
  static const String taskUpdated = 'Task updated successfully';
  static const String taskDeleted = 'Task deleted successfully';
  
  // Default Categories
  static const List<String> defaultCategories = [
    'General',
    'Work',
    'Personal',
    'Shopping',
    'Health',
    'Education',
    'Finance',
  ];
  
  // Category Colors
  static const Map<String, int> categoryColors = {
    'General': 0xFF2196F3, // Blue
    'Work': 0xFFFF5722,     // Orange
    'Personal': 0xFF4CAF50, // Green
    'Shopping': 0xFF9C27B0, // Purple
    'Health': 0xFFF44336,   // Red
    'Education': 0xFF607D8B, // Blue Grey
    'Finance': 0xFFFF9800,  // Orange
  };
  
  // Storage Keys
  static const String themeKey = 'theme_mode';
  static const String authTokenKey = 'auth_token';
  static const String userIdKey = 'user_id';
  static const String lastSyncKey = 'last_sync';
  
  // Feature Flags
  static const bool enableAnalytics = true;
  static const bool enableCrashReporting = true;
  static const bool enablePushNotifications = true;
  
  // Cache Configuration
  static const Duration cacheExpiration = Duration(hours: 24);
  static const int maxCacheSize = 50; // MB
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  
  // Search
  static const int minSearchLength = 2;
  static const Duration searchDebounce = Duration(milliseconds: 300);
  
  // Offline
  static const bool enableOfflineMode = true;
  static const Duration offlineSyncInterval = Duration(minutes: 15);
} 