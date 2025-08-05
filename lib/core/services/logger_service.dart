import 'package:logger/logger.dart';

/// Centralized logging service for the application
class LoggerService {
  static final LoggerService _instance = LoggerService._internal();
  factory LoggerService() => _instance;
  LoggerService._internal();

  late final Logger _logger;

  /// Initialize the logger with configuration
  void initialize({bool enableConsoleOutput = true}) {
    _logger = Logger(
      filter: _CustomLogFilter(),
      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        printTime: true,
      ),
      output: enableConsoleOutput ? ConsoleOutput() : null,
    );
  }

  /// Log a debug message
  void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  /// Log an info message
  void info(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  /// Log a warning message
  void warning(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  /// Log an error message
  void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  /// Log a fatal error message
  void fatal(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }

  /// Log API request
  void logApiRequest(String method, String url, {Map<String, dynamic>? headers, dynamic body}) {
    info('API Request: $method $url');
    if (headers != null) debug('Headers: $headers');
    if (body != null) debug('Body: $body');
  }

  /// Log API response
  void logApiResponse(String method, String url, int statusCode, {dynamic body}) {
    info('API Response: $method $url - $statusCode');
    if (body != null) debug('Response Body: $body');
  }

  /// Log API error
  void logApiError(String method, String url, dynamic error) {
    error('API Error: $method $url', error);
  }

  /// Log database operation
  void logDatabaseOperation(String operation, String table, {dynamic data}) {
    info('Database: $operation on $table');
    if (data != null) debug('Data: $data');
  }

  /// Log database error
  void logDatabaseError(String operation, String table, dynamic error) {
    error('Database Error: $operation on $table', error);
  }

  /// Log user action
  void logUserAction(String action, {Map<String, dynamic>? parameters}) {
    info('User Action: $action');
    if (parameters != null) debug('Parameters: $parameters');
  }

  /// Log performance metric
  void logPerformance(String operation, Duration duration) {
    info('Performance: $operation took ${duration.inMilliseconds}ms');
  }

  /// Log navigation
  void logNavigation(String from, String to) {
    info('Navigation: $from -> $to');
  }

  /// Log state change
  void logStateChange(String bloc, String event, String state) {
    debug('State Change: $bloc - $event -> $state');
  }
}

/// Custom log filter to control what gets logged
class _CustomLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    // In production, only log warnings and errors
    if (const bool.fromEnvironment('dart.vm.product')) {
      return event.level.index >= Level.warning.index;
    }
    
    // In debug mode, log everything
    return true;
  }
}

/// Global logger instance
final logger = LoggerService(); 