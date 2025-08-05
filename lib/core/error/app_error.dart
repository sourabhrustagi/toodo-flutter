/// Base class for all application errors.
/// 
/// This class provides a foundation for type-safe error handling
/// throughout the application. All specific error types should
/// extend this class.
abstract class AppError {
  const AppError();

  /// A user-friendly message that can be displayed to the user.
  String get userMessage;

  /// A technical message for debugging purposes.
  String get technicalMessage;

  /// The error code for programmatic handling.
  String get errorCode;

  /// Whether this error should be reported to analytics/crash reporting.
  bool get shouldReport => true;

  /// Whether this error can be retried.
  bool get canRetry => false;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppError &&
        runtimeType == other.runtimeType &&
        errorCode == other.errorCode;
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorCode);

  @override
  String toString() => 'AppError(code: $errorCode, message: $technicalMessage)';
}

/// Network-related errors.
class NetworkError extends AppError {
  final String message;
  final int? statusCode;
  final String? url;

  const NetworkError(
    this.message, {
    this.statusCode,
    this.url,
  });

  @override
  String get userMessage {
    if (statusCode != null) {
      switch (statusCode) {
        case 401:
          return 'Please log in again to continue.';
        case 403:
          return 'You don\'t have permission to perform this action.';
        case 404:
          return 'The requested resource was not found.';
        case 500:
        case 502:
        case 503:
          return 'The server is temporarily unavailable. Please try again later.';
        default:
          return 'Network error occurred. Please check your connection and try again.';
      }
    }
    return 'Network error occurred. Please check your connection and try again.';
  }

  @override
  String get technicalMessage => 'NetworkError: $message${statusCode != null ? ' (Status: $statusCode)' : ''}${url != null ? ' URL: $url' : ''}';

  @override
  String get errorCode => 'NETWORK_ERROR';

  @override
  bool get canRetry => true;
}

/// Authentication-related errors.
class AuthError extends AppError {
  final String message;
  final AuthErrorType type;

  const AuthError(this.message, {this.type = AuthErrorType.unknown});

  @override
  String get userMessage {
    switch (type) {
      case AuthErrorType.invalidCredentials:
        return 'Invalid phone number or OTP. Please try again.';
      case AuthErrorType.otpExpired:
        return 'OTP has expired. Please request a new one.';
      case AuthErrorType.tooManyAttempts:
        return 'Too many failed attempts. Please try again later.';
      case AuthErrorType.sessionExpired:
        return 'Your session has expired. Please log in again.';
      case AuthErrorType.unknown:
      default:
        return 'Authentication failed. Please try again.';
    }
  }

  @override
  String get technicalMessage => 'AuthError: $message (Type: $type)';

  @override
  String get errorCode => 'AUTH_ERROR';
}

/// Authentication error types.
enum AuthErrorType {
  invalidCredentials,
  otpExpired,
  tooManyAttempts,
  sessionExpired,
  unknown,
}

/// Data-related errors.
class DataError extends AppError {
  final String message;
  final DataErrorType type;

  const DataError(this.message, {this.type = DataErrorType.unknown});

  @override
  String get userMessage {
    switch (type) {
      case DataErrorType.notFound:
        return 'The requested data was not found.';
      case DataErrorType.invalidData:
        return 'The data is invalid or corrupted.';
      case DataErrorType.storageError:
        return 'Failed to save data. Please try again.';
      case DataErrorType.unknown:
      default:
        return 'A data error occurred. Please try again.';
    }
  }

  @override
  String get technicalMessage => 'DataError: $message (Type: $type)';

  @override
  String get errorCode => 'DATA_ERROR';
}

/// Data error types.
enum DataErrorType {
  notFound,
  invalidData,
  storageError,
  unknown,
}

/// Validation errors.
class ValidationError extends AppError {
  final String field;
  final String message;

  const ValidationError(this.field, this.message);

  @override
  String get userMessage => 'Please check the $field field: $message';

  @override
  String get technicalMessage => 'ValidationError: Field "$field" - $message';

  @override
  String get errorCode => 'VALIDATION_ERROR';

  @override
  bool get shouldReport => false;
}

/// Permission errors.
class PermissionError extends AppError {
  final String permission;
  final String message;

  const PermissionError(this.permission, this.message);

  @override
  String get userMessage => 'Permission denied: $message';

  @override
  String get technicalMessage => 'PermissionError: $permission - $message';

  @override
  String get errorCode => 'PERMISSION_ERROR';
}

/// Unknown or unexpected errors.
class UnknownError extends AppError {
  final String message;
  final Object? originalError;

  const UnknownError(this.message, {this.originalError});

  @override
  String get userMessage => 'An unexpected error occurred. Please try again.';

  @override
  String get technicalMessage => 'UnknownError: $message${originalError != null ? ' (Original: $originalError)' : ''}';

  @override
  String get errorCode => 'UNKNOWN_ERROR';
}

/// Error utilities for common operations.
class ErrorUtils {
  /// Creates a network error from an exception.
  static NetworkError fromException(Object exception, {int? statusCode, String? url}) {
    return NetworkError(
      exception.toString(),
      statusCode: statusCode,
      url: url,
    );
  }

  /// Creates an auth error from a response.
  static AuthError fromAuthResponse(String message, {AuthErrorType? type}) {
    return AuthError(message, type: type ?? AuthErrorType.unknown);
  }

  /// Creates a data error from an exception.
  static DataError fromDataException(Object exception, {DataErrorType? type}) {
    return DataError(
      exception.toString(),
      type: type ?? DataErrorType.unknown,
    );
  }

  /// Creates a validation error.
  static ValidationError fromValidation(String field, String message) {
    return ValidationError(field, message);
  }

  /// Creates an unknown error.
  static UnknownError fromUnknown(Object exception) {
    return UnknownError(exception.toString(), originalError: exception);
  }

  /// Determines if an error is retryable.
  static bool isRetryable(AppError error) {
    return error.canRetry || error is NetworkError;
  }

  /// Gets a user-friendly message for any error.
  static String getUserMessage(Object error) {
    if (error is AppError) {
      return error.userMessage;
    }
    return 'An unexpected error occurred. Please try again.';
  }

  /// Gets a technical message for any error.
  static String getTechnicalMessage(Object error) {
    if (error is AppError) {
      return error.technicalMessage;
    }
    return error.toString();
  }
} 