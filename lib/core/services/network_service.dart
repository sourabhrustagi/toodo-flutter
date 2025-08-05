import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../constants/app_constants.dart';
import 'logger_service.dart';
import 'retry_interceptor.dart';

/// Network service for handling HTTP requests with proper error handling and retry mechanism
class NetworkService {
  static final NetworkService _instance = NetworkService._internal();
  factory NetworkService() => _instance;
  NetworkService._internal();

  late final Dio _dio;
  late final Connectivity _connectivity;
  late final RetryStats _retryStats;

  /// Initialize the network service
  Future<void> initialize() async {
    _dio = Dio(BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: AppConstants.apiTimeout,
      receiveTimeout: AppConstants.apiTimeout,
      sendTimeout: AppConstants.apiTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // Add interceptors
    _dio.interceptors.addAll([
      _LoggingInterceptor(),
      RetryInterceptor(config: RetryConfig.defaultConfig),
      _AuthInterceptor(),
    ]);

    _connectivity = Connectivity();
    _retryStats = RetryStats();
    
    logger.info('NetworkService initialized with retry mechanism');
  }

  /// Check if device is connected to internet
  Future<bool> isConnected() async {
    try {
      final connectivityResult = await _connectivity.checkConnectivity();
      return connectivityResult != ConnectivityResult.none;
    } catch (e) {
      logger.error('Error checking connectivity', e);
      return false;
    }
  }

  /// Make a GET request with retry support
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    RetryConfig? retryConfig,
    bool disableRetry = false,
  }) async {
    _retryStats.recordRequest();
    
    final options = Options(headers: headers);
    if (disableRetry) {
      options.extra = {'disableRetry': true};
    } else if (retryConfig != null) {
      options.extra = {'retryConfig': retryConfig};
    }

    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// Make a POST request with retry support
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    RetryConfig? retryConfig,
    bool disableRetry = false,
  }) async {
    _retryStats.recordRequest();
    
    final options = Options(headers: headers);
    if (disableRetry) {
      options.extra = {'disableRetry': true};
    } else if (retryConfig != null) {
      options.extra = {'retryConfig': retryConfig};
    }

    return _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// Make a PUT request with retry support
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    RetryConfig? retryConfig,
    bool disableRetry = false,
  }) async {
    _retryStats.recordRequest();
    
    final options = Options(headers: headers);
    if (disableRetry) {
      options.extra = {'disableRetry': true};
    } else if (retryConfig != null) {
      options.extra = {'retryConfig': retryConfig};
    }

    return _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// Make a DELETE request with retry support
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    RetryConfig? retryConfig,
    bool disableRetry = false,
  }) async {
    _retryStats.recordRequest();
    
    final options = Options(headers: headers);
    if (disableRetry) {
      options.extra = {'disableRetry': true};
    } else if (retryConfig != null) {
      options.extra = {'retryConfig': retryConfig};
    }

    return _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// Make a PATCH request with retry support
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    RetryConfig? retryConfig,
    bool disableRetry = false,
  }) async {
    _retryStats.recordRequest();
    
    final options = Options(headers: headers);
    if (disableRetry) {
      options.extra = {'disableRetry': true};
    } else if (retryConfig != null) {
      options.extra = {'retryConfig': retryConfig};
    }

    return _dio.patch<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// Set authentication token for requests
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  /// Clear authentication token
  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }

  /// Get retry statistics
  Map<String, dynamic> get retryStats => _retryStats.summary;

  /// Reset retry statistics
  void resetRetryStats() {
    _retryStats.reset();
  }

  /// Dispose the network service
  void dispose() {
    _dio.close();
  }
}

/// Logging interceptor for debugging network requests
class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.info(
      '🌐 ${options.method.toUpperCase()} ${options.path}',
      {
        'headers': options.headers,
        'queryParameters': options.queryParameters,
        'data': options.data,
      },
    );
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.info(
      '✅ ${response.statusCode} ${response.requestOptions.method.toUpperCase()} ${response.requestOptions.path}',
      {
        'statusCode': response.statusCode,
        'data': response.data,
      },
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.error(
      '❌ ${err.response?.statusCode ?? 'NO_STATUS'} ${err.requestOptions.method.toUpperCase()} ${err.requestOptions.path}',
      err,
    );
    handler.next(err);
  }
}

/// Authentication interceptor for adding auth tokens
class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add auth token if available
    final authToken = options.headers['Authorization'];
    if (authToken != null) {
      logger.debug('🔐 Adding auth token to request: ${options.path}');
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle authentication errors
    if (err.response?.statusCode == 401) {
      logger.warning('🔐 Authentication failed for ${err.requestOptions.path}');
      // Could trigger logout or token refresh here
    }
    handler.next(err);
  }
} 