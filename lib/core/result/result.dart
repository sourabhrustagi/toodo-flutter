

/// A functional Result type that represents either a success or failure.
/// 
/// This type is used throughout the application to handle errors in a
/// type-safe and functional way. It eliminates the need for try-catch
/// blocks in many cases and provides a consistent error handling pattern.
/// 
/// Example usage:
/// ```dart
/// final result = await repository.getData();
/// result.when(
///   success: (data) => print('Success: $data'),
///   failure: (error) => print('Error: $error'),
/// );
/// ```
sealed class Result<T> {
  const Result();

  /// Creates a successful result with the given data.
  const factory Result.success(T data) = Success<T>;

  /// Creates a failed result with the given error.
  const factory Result.failure(Object error) = Failure<T>;

  /// Returns true if this is a success result.
  bool get isSuccess => this is Success<T>;

  /// Returns true if this is a failure result.
  bool get isFailure => this is Failure<T>;

  /// Gets the data if this is a success result, otherwise throws.
  /// 
  /// Use this only when you're certain the result is a success.
  /// For safe access, use [when] or [map].
  T get data {
    if (this is Success<T>) {
      return (this as Success<T>).data;
    }
    throw StateError('Cannot get data from a failure result');
  }

  /// Gets the error if this is a failure result, otherwise throws.
  /// 
  /// Use this only when you're certain the result is a failure.
  /// For safe access, use [when] or [mapError].
  Object get error {
    if (this is Failure<T>) {
      return (this as Failure<T>).error;
    }
    throw StateError('Cannot get error from a success result');
  }

  /// Transforms the data if this is a success result.
  /// 
  /// If this is a failure result, the error is preserved.
  Result<R> map<R>(R Function(T data) transform) {
    return when(
      success: (data) => Result.success(transform(data)),
      failure: (error) => Result.failure(error),
    );
  }

  /// Transforms the error if this is a failure result.
  /// 
  /// If this is a success result, the data is preserved.
  Result<T> mapError(Object Function(Object error) transform) {
    return when(
      success: (data) => Result.success(data),
      failure: (error) => Result.failure(transform(error)),
    );
  }

  /// Executes different functions based on whether this is a success or failure.
  /// 
  /// This is the primary way to handle Result values safely.
  R when<R>({
    required R Function(T data) success,
    required R Function(Object error) failure,
  }) {
    if (this is Success<T>) {
      return success((this as Success<T>).data);
    } else if (this is Failure<T>) {
      return failure((this as Failure<T>).error);
    }
    throw StateError('Unknown Result type');
  }

  /// Executes a function if this is a success result.
  /// 
  /// Returns this result unchanged if it's a failure.
  Result<T> onSuccess(void Function(T data) action) {
    if (this is Success<T>) {
      action((this as Success<T>).data);
    }
    return this;
  }

  /// Executes a function if this is a failure result.
  /// 
  /// Returns this result unchanged if it's a success.
  Result<T> onFailure(void Function(Object error) action) {
    if (this is Failure<T>) {
      action((this as Failure<T>).error);
    }
    return this;
  }

  /// Returns the data if this is a success result, otherwise returns the default value.
  T getOrElse(T defaultValue) {
    return when(
      success: (data) => data,
      failure: (_) => defaultValue,
    );
  }

  /// Returns the data if this is a success result, otherwise throws the error.
  T getOrThrow() {
    return when(
      success: (data) => data,
      failure: (error) => throw error,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Result<T> &&
        runtimeType == other.runtimeType &&
        when(
          success: (data) => other is Success<T> && other.data == data,
          failure: (error) => other is Failure<T> && other.error == error,
        );
  }

  @override
  int get hashCode {
    return when(
      success: (data) => Object.hash(Success, data),
      failure: (error) => Object.hash(Failure, error),
    );
  }

  @override
  String toString() {
    return when(
      success: (data) => 'Result.success($data)',
      failure: (error) => 'Result.failure($error)',
    );
  }
}

/// A successful result containing data.
class Success<T> extends Result<T> {
  final T data;

  const Success(this.data);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Success<T> && other.data == data;
  }

  @override
  int get hashCode => Object.hash(Success, data);

  @override
  String toString() => 'Success($data)';
}

/// A failed result containing an error.
class Failure<T> extends Result<T> {
  final Object error;

  const Failure(this.error);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Failure<T> && other.error == error;
  }

  @override
  int get hashCode => Object.hash(Failure, error);

  @override
  String toString() => 'Failure($error)';
}

/// Extension methods for working with Result types.
extension ResultExtensions<T> on Result<T> {
  /// Converts this result to an optional value.
  /// 
  /// Returns the data if this is a success result, otherwise returns null.
  T? toOption() {
    return when(
      success: (data) => data,
      failure: (_) => null,
    );
  }

  /// Converts this result to a nullable value.
  /// 
  /// Returns the data if this is a success result, otherwise returns null.
  T? toNullable() {
    return when(
      success: (data) => data,
      failure: (_) => null,
    );
  }
}

/// Extension methods for working with nullable values as Results.
extension NullableResultExtensions<T> on T? {
  /// Converts a nullable value to a Result.
  /// 
  /// Returns a success result if the value is not null,
  /// otherwise returns a failure result with the given error.
  Result<T> toResult(Object error) {
    if (this == null) {
      return Result.failure(error);
    }
    return Result.success(this!);
  }
} 