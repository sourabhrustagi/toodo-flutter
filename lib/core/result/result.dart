

/// A functional Result type that can represent either success or failure
sealed class Result<T> {
  const Result();
  
  /// Returns true if this is a success result
  bool get isSuccess => this is Success<T>;
  
  /// Returns true if this is a failure result
  bool get isFailure => this is Failure<T>;
  
  /// Returns the success value if this is a success, otherwise throws
  T get successValue {
    if (this is Success<T>) {
      return (this as Success<T>).value;
    }
    throw StateError('Result is not a success');
  }
  
  /// Returns the failure if this is a failure, otherwise throws
  Failure get failureValue {
    if (this is Failure<T>) {
      return (this as Failure<T>).failure;
    }
    throw StateError('Result is not a failure');
  }
  
  /// Maps the success value using the given function
  Result<R> map<R>(R Function(T value) mapper) {
    if (this is Success<T>) {
      return Success(mapper((this as Success<T>).value));
    }
    return Failure((this as Failure<T>).failure);
  }
  
  /// Maps the failure using the given function
  Result<T> mapFailure(Failure Function(Failure failure) mapper) {
    if (this is Success<T>) {
      return this;
    }
    return Failure(mapper((this as Failure<T>).failure));
  }
  
  /// Executes the given function if this is a success
  Result<T> onSuccess(void Function(T value) callback) {
    if (this is Success<T>) {
      callback((this as Success<T>).value);
    }
    return this;
  }
  
  /// Executes the given function if this is a failure
  Result<T> onFailure(void Function(Failure failure) callback) {
    if (this is Failure<T>) {
      callback((this as Failure<T>).failure);
    }
    return this;
  }
  
  /// Returns the success value or the given default value
  T getOrElse(T defaultValue) {
    if (this is Success<T>) {
      return (this as Success<T>).value;
    }
    return defaultValue;
  }
  
  /// Returns the success value or throws the failure
  T getOrThrow() {
    if (this is Success<T>) {
      return (this as Success<T>).value;
    }
    throw (this as Failure<T>).failure;
  }
}

/// Represents a successful result
class Success<T> extends Result<T> {
  const Success(this.value);
  
  final T value;
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Success<T> && other.value == value;
  }
  
  @override
  int get hashCode => value.hashCode;
  
  @override
  String toString() => 'Success($value)';
}

/// Represents a failed result
class Failure<T> extends Result<T> {
  const Failure(this.failure);
  
  final Failure failure;
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Failure<T> && other.failure == failure;
  }
  
  @override
  int get hashCode => failure.hashCode;
  
  @override
  String toString() => 'Failure($failure)';
} 