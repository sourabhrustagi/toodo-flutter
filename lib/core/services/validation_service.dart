import '../constants/app_constants.dart';

/// Validation service for form and data validation
class ValidationService {
  static final ValidationService _instance = ValidationService._internal();
  factory ValidationService() => _instance;
  ValidationService._internal();

  /// Validate email format
  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    }
    
    return null;
  }

  /// Validate password strength
  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    
    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    
    if (!password.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }
    
    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    
    return null;
  }

  /// Validate task title
  String? validateTaskTitle(String? title) {
    if (title == null || title.trim().isEmpty) {
      return AppConstants.titleRequired;
    }
    
    if (title.length > AppConstants.maxTitleLength) {
      return AppConstants.titleTooLong;
    }
    
    return null;
  }

  /// Validate task description
  String? validateTaskDescription(String? description) {
    if (description != null && description.length > AppConstants.maxDescriptionLength) {
      return AppConstants.descriptionTooLong;
    }
    
    return null;
  }

  /// Validate required field
  String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    
    return null;
  }

  /// Validate minimum length
  String? validateMinLength(String? value, int minLength, String fieldName) {
    if (value == null || value.length < minLength) {
      return '$fieldName must be at least $minLength characters long';
    }
    
    return null;
  }

  /// Validate maximum length
  String? validateMaxLength(String? value, int maxLength, String fieldName) {
    if (value != null && value.length > maxLength) {
      return '$fieldName must be less than $maxLength characters';
    }
    
    return null;
  }

  /// Validate URL format
  String? validateUrl(String? url) {
    if (url == null || url.isEmpty) {
      return 'URL is required';
    }
    
    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$'
    );
    
    if (!urlRegex.hasMatch(url)) {
      return 'Please enter a valid URL';
    }
    
    return null;
  }

  /// Validate phone number
  String? validatePhoneNumber(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'Phone number is required';
    }
    
    final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]+$');
    if (!phoneRegex.hasMatch(phone)) {
      return 'Please enter a valid phone number';
    }
    
    return null;
  }

  /// Validate date is not in the past
  String? validateFutureDate(DateTime? date) {
    if (date == null) {
      return 'Date is required';
    }
    
    if (date.isBefore(DateTime.now())) {
      return 'Date cannot be in the past';
    }
    
    return null;
  }

  /// Validate date range
  String? validateDateRange(DateTime? startDate, DateTime? endDate) {
    if (startDate == null || endDate == null) {
      return 'Both start and end dates are required';
    }
    
    if (startDate.isAfter(endDate)) {
      return 'Start date cannot be after end date';
    }
    
    return null;
  }

  /// Validate numeric value
  String? validateNumeric(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    
    if (double.tryParse(value) == null) {
      return '$fieldName must be a valid number';
    }
    
    return null;
  }

  /// Validate positive number
  String? validatePositiveNumber(String? value, String fieldName) {
    final numericError = validateNumeric(value, fieldName);
    if (numericError != null) {
      return numericError;
    }
    
    final number = double.parse(value!);
    if (number <= 0) {
      return '$fieldName must be greater than 0';
    }
    
    return null;
  }

  /// Validate integer
  String? validateInteger(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    
    if (int.tryParse(value) == null) {
      return '$fieldName must be a valid integer';
    }
    
    return null;
  }

  /// Validate alphanumeric
  String? validateAlphanumeric(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    
    final alphanumericRegex = RegExp(r'^[a-zA-Z0-9]+$');
    if (!alphanumericRegex.hasMatch(value)) {
      return '$fieldName must contain only letters and numbers';
    }
    
    return null;
  }

  /// Validate username
  String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Username is required';
    }
    
    if (username.length < 3) {
      return 'Username must be at least 3 characters long';
    }
    
    if (username.length > 20) {
      return 'Username must be less than 20 characters';
    }
    
    final usernameRegex = RegExp(r'^[a-zA-Z0-9_]+$');
    if (!usernameRegex.hasMatch(username)) {
      return 'Username can only contain letters, numbers, and underscores';
    }
    
    return null;
  }

  /// Validate confirmation password
  String? validateConfirmPassword(String? password, String? confirmPassword) {
    final passwordError = validatePassword(password);
    if (passwordError != null) {
      return passwordError;
    }
    
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }
    
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    
    return null;
  }

  /// Validate form data
  Map<String, String?> validateForm(Map<String, dynamic> formData) {
    final errors = <String, String?>{};
    
    for (final entry in formData.entries) {
      final fieldName = entry.key;
      final value = entry.value;
      
      String? error;
      
      switch (fieldName) {
        case 'email':
          error = validateEmail(value);
          break;
        case 'password':
          error = validatePassword(value);
          break;
        case 'username':
          error = validateUsername(value);
          break;
        case 'title':
          error = validateTaskTitle(value);
          break;
        case 'description':
          error = validateTaskDescription(value);
          break;
        case 'url':
          error = validateUrl(value);
          break;
        case 'phone':
          error = validatePhoneNumber(value);
          break;
        default:
          // Default validation for required fields
          if (value == null || (value is String && value.trim().isEmpty)) {
            error = '${fieldName[0].toUpperCase()}${fieldName.substring(1)} is required';
          }
      }
      
      if (error != null) {
        errors[fieldName] = error;
      }
    }
    
    return errors;
  }

  /// Check if form is valid
  bool isFormValid(Map<String, String?> errors) {
    return errors.values.every((error) => error == null);
  }
} 