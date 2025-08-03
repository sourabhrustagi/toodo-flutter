import 'package:equatable/equatable.dart';

/// Base class for all failures in the application
abstract class Failure extends Equatable {
  const Failure([this.message = '']);
  
  final String message;
  
  @override
  List<Object?> get props => [message];
}

/// Network-related failures
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Network error occurred']);
}

/// Server-related failures
class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error occurred']);
}

/// Database-related failures
class DatabaseFailure extends Failure {
  const DatabaseFailure([super.message = 'Database error occurred']);
}

/// Authentication-related failures
class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Authentication error occurred']);
}

/// Validation-related failures
class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'Validation error occurred']);
}

/// Cache-related failures
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache error occurred']);
}

/// Permission-related failures
class PermissionFailure extends Failure {
  const PermissionFailure([super.message = 'Permission denied']);
}

/// Unknown failures
class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'An unknown error occurred']);
} 