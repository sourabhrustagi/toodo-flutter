import 'dart:async';
import 'dart:math';
import 'package:dio/dio.dart';
import '../constants/app_constants.dart';
import 'logger_service.dart';

/// Retry configuration for different types of requests
class RetryConfig {
  final int maxRetries;
  final Duration baseDelay;
  final double backoffMultiplier;
  final List<int> retryableStatusCodes;
  final List<Type> retryableExceptions;

  const RetryConfig({
    this.maxRetries = 3,
    this.baseDelay = const Duration(seconds: 1),
    this.backoffMultiplier = 2.0,
    this.retryableStatusCodes = const [408, 429, 500, 502, 503, 504],
    this.retryableExceptions = const [DioException],
  });

  /// Default retry configuration
  static const RetryConfig defaultConfig = RetryConfig();

  /// Aggressive retry configuration for critical requests
  static const RetryConfig aggressive = RetryConfig(
    maxRetries: 5,
    baseDelay: Duration(milliseconds: 500),
    backoffMultiplier: 1.5,
  );

  /// Conservative retry configuration for non-critical requests
  static const RetryConfig conservative = RetryConfig(
    maxRetries: 2,
    baseDelay: const Duration(seconds: 2),
    backoffMultiplier: 3.0,
  );
}

/// Retry interceptor for Dio HTTP client
/// 
/// This interceptor automatically retries failed requests based on
/// configurable criteria such as status codes, exceptions, and retry limits.
/// It implements exponential backoff to avoid overwhelming the server.
class RetryInterceptor extends Interceptor {
  final RetryConfig config;
  final Random _random = Random();

  RetryInterceptor({this.config = RetryConfig.defaultConfig});

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Check if request should be retried
    if (!_shouldRetry(err)) {
      return handler.next(err);
    }

    // Get retry count from request options
    final retryCount = _getRetryCount(err.requestOptions);
    
    if (retryCount >= config.maxRetries) {
      logger.warning(
        'Max retries (${config.maxRetries}) exceeded for ${err.requestOptions.path}',
      );
      return handler.next(err);
    }

    // Calculate delay with jitter to prevent thundering herd
    final delay = _calculateDelay(retryCount);
    
    logger.info(
      'Retrying request ${err.requestOptions.path} (attempt ${retryCount + 1}/${config.maxRetries + 1}) after ${delay.inMilliseconds}ms',
    );

    // Wait before retrying
    await Future.delayed(delay);

    try {
      // Create a new request with updated retry count
      final newOptions = _updateRetryCount(err.requestOptions, retryCount + 1);
      
      // Retry the request
      final response = await _retryRequest(newOptions);
      return handler.resolve(response);
    } catch (retryError) {
      // If retry also fails, continue with the original error
      return handler.next(err);
    }
  }

  /// Check if the error should be retried
  bool _shouldRetry(DioException err) {
    // Don't retry if retry is disabled
    if (err.requestOptions.extra['disableRetry'] == true) {
      return false;
    }

    // Check status code
    if (err.response?.statusCode != null) {
      final statusCode = err.response!.statusCode!;
      if (config.retryableStatusCodes.contains(statusCode)) {
        return true;
      }
    }

    // Check exception type
    if (config.retryableExceptions.contains(err.runtimeType)) {
      return true;
    }

    // Check specific DioException types
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.connectionError:
        return true;
      case DioExceptionType.badResponse:
        // Only retry for server errors (5xx) and specific client errors
        final statusCode = err.response?.statusCode;
        return statusCode != null && 
               (statusCode >= 500 || config.retryableStatusCodes.contains(statusCode));
      default:
        return false;
    }
  }

  /// Get current retry count from request options
  int _getRetryCount(RequestOptions options) {
    return options.extra['retryCount'] as int? ?? 0;
  }

  /// Update retry count in request options
  RequestOptions _updateRetryCount(RequestOptions options, int retryCount) {
    return options.copyWith(
      extra: {
        ...options.extra,
        'retryCount': retryCount,
      },
    );
  }

  /// Calculate delay with exponential backoff and jitter
  Duration _calculateDelay(int retryCount) {
    // Exponential backoff
    final exponentialDelay = config.baseDelay * pow(config.backoffMultiplier, retryCount).round();
    
    // Add jitter (±25%) to prevent thundering herd
    final jitter = exponentialDelay.inMilliseconds * 0.25;
    final jitterAmount = (_random.nextDouble() * 2 - 1) * jitter;
    
    final totalDelay = exponentialDelay.inMilliseconds + jitterAmount;
    
    return Duration(milliseconds: totalDelay.round());
  }

  /// Retry the request with updated options
  Future<Response> _retryRequest(RequestOptions options) async {
    final dio = Dio();
    
    switch (options.method.toUpperCase()) {
      case 'GET':
        return await dio.get(
          options.path,
          queryParameters: options.queryParameters,
          options: Options(
            headers: options.headers,
            extra: options.extra,
          ),
        );
      case 'POST':
        return await dio.post(
          options.path,
          data: options.data,
          queryParameters: options.queryParameters,
          options: Options(
            headers: options.headers,
            extra: options.extra,
          ),
        );
      case 'PUT':
        return await dio.put(
          options.path,
          data: options.data,
          queryParameters: options.queryParameters,
          options: Options(
            headers: options.headers,
            extra: options.extra,
          ),
        );
      case 'DELETE':
        return await dio.delete(
          options.path,
          data: options.data,
          queryParameters: options.queryParameters,
          options: Options(
            headers: options.headers,
            extra: options.extra,
          ),
        );
      case 'PATCH':
        return await dio.patch(
          options.path,
          data: options.data,
          queryParameters: options.queryParameters,
          options: Options(
            headers: options.headers,
            extra: options.extra,
          ),
        );
      default:
        throw DioException(
          requestOptions: options,
          error: 'Unsupported HTTP method: ${options.method}',
        );
    }
  }
}

/// Retry policy for different types of requests
class RetryPolicy {
  /// Retry policy for authentication requests
  static const RetryConfig auth = RetryConfig(
    maxRetries: 2,
    baseDelay: Duration(seconds: 1),
    backoffMultiplier: 2.0,
    retryableStatusCodes: [401, 408, 429, 500, 502, 503, 504],
  );

  /// Retry policy for data fetching requests
  static const RetryConfig dataFetch = RetryConfig(
    maxRetries: 3,
    baseDelay: Duration(seconds: 1),
    backoffMultiplier: 2.0,
    retryableStatusCodes: [408, 429, 500, 502, 503, 504],
  );

  /// Retry policy for data modification requests
  static const RetryConfig dataModify = RetryConfig(
    maxRetries: 2,
    baseDelay: Duration(seconds: 2),
    backoffMultiplier: 3.0,
    retryableStatusCodes: [408, 429, 500, 502, 503, 504],
  );

  /// Retry policy for critical operations
  static const RetryConfig critical = RetryConfig(
    maxRetries: 5,
    baseDelay: Duration(milliseconds: 500),
    backoffMultiplier: 1.5,
    retryableStatusCodes: [408, 429, 500, 502, 503, 504],
  );

  /// Retry policy for non-critical operations
  static const RetryConfig nonCritical = RetryConfig(
    maxRetries: 1,
    baseDelay: Duration(seconds: 2),
    backoffMultiplier: 2.0,
    retryableStatusCodes: [408, 429, 500, 502, 503, 504],
  );
}

/// Extension methods for RequestOptions to support retry functionality
extension RetryOptions on RequestOptions {
  /// Disable retry for this request
  RequestOptions disableRetry() {
    return copyWith(
      extra: {
        ...extra,
        'disableRetry': true,
      },
    );
  }

  /// Set custom retry configuration for this request
  RequestOptions withRetryConfig(RetryConfig config) {
    return copyWith(
      extra: {
        ...extra,
        'retryConfig': config,
      },
    );
  }

  /// Get retry configuration for this request
  RetryConfig? get retryConfig {
    return extra['retryConfig'] as RetryConfig?;
  }

  /// Check if retry is disabled for this request
  bool get isRetryDisabled {
    return extra['disableRetry'] == true;
  }
}

/// Retry statistics for monitoring and analytics
class RetryStats {
  int _totalRequests = 0;
  int _retriedRequests = 0;
  int _successfulRetries = 0;
  int _failedRetries = 0;

  /// Record a request attempt
  void recordRequest() {
    _totalRequests++;
  }

  /// Record a retry attempt
  void recordRetry() {
    _retriedRequests++;
  }

  /// Record a successful retry
  void recordSuccessfulRetry() {
    _successfulRetries++;
  }

  /// Record a failed retry
  void recordFailedRetry() {
    _failedRetries++;
  }

  /// Get retry success rate
  double get retrySuccessRate {
    if (_retriedRequests == 0) return 0.0;
    return _successfulRetries / _retriedRequests;
  }

  /// Get retry rate
  double get retryRate {
    if (_totalRequests == 0) return 0.0;
    return _retriedRequests / _totalRequests;
  }

  /// Get statistics summary
  Map<String, dynamic> get summary {
    return {
      'totalRequests': _totalRequests,
      'retriedRequests': _retriedRequests,
      'successfulRetries': _successfulRetries,
      'failedRetries': _failedRetries,
      'retrySuccessRate': retrySuccessRate,
      'retryRate': retryRate,
    };
  }

  /// Reset statistics
  void reset() {
    _totalRequests = 0;
    _retriedRequests = 0;
    _successfulRetries = 0;
    _failedRetries = 0;
  }
} 