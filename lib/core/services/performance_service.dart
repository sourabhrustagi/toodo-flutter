import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'logger_service.dart';

/// Performance monitoring service for tracking app performance metrics
class PerformanceService {
  static final PerformanceService _instance = PerformanceService._internal();
  factory PerformanceService() => _instance;
  PerformanceService._internal();

  final Map<String, Stopwatch> _timers = {};
  final Map<String, List<Duration>> _metrics = {};
  final Map<String, int> _counters = {};

  /// Start timing an operation
  void startTimer(String operationName) {
    if (_timers.containsKey(operationName)) {
      logger.warning('Timer already started for operation: $operationName');
      return;
    }
    
    _timers[operationName] = Stopwatch()..start();
    logger.debug('Started timer for operation: $operationName');
  }

  /// Stop timing an operation and log the result
  Duration? stopTimer(String operationName) {
    final stopwatch = _timers.remove(operationName);
    if (stopwatch == null) {
      logger.warning('No timer found for operation: $operationName');
      return null;
    }
    
    stopwatch.stop();
    final duration = stopwatch.elapsed;
    
    // Log performance metric
    logger.logPerformance(operationName, duration);
    
    // Store metric for analysis
    _metrics.putIfAbsent(operationName, () => []).add(duration);
    
    // Log to developer console in debug mode
    if (kDebugMode) {
      developer.log(
        'Performance: $operationName took ${duration.inMilliseconds}ms',
        name: 'PerformanceService',
      );
    }
    
    return duration;
  }

  /// Time an operation with a callback
  Future<T> timeOperation<T>(
    String operationName,
    Future<T> Function() operation,
  ) async {
    startTimer(operationName);
    try {
      final result = await operation();
      stopTimer(operationName);
      return result;
    } catch (e) {
      stopTimer(operationName);
      rethrow;
    }
  }

  /// Time a synchronous operation
  T timeSyncOperation<T>(
    String operationName,
    T Function() operation,
  ) {
    startTimer(operationName);
    try {
      final result = operation();
      stopTimer(operationName);
      return result;
    } catch (e) {
      stopTimer(operationName);
      rethrow;
    }
  }

  /// Increment a counter
  void incrementCounter(String counterName, [int increment = 1]) {
    _counters[counterName] = (_counters[counterName] ?? 0) + increment;
    logger.debug('Counter incremented: $counterName = ${_counters[counterName]}');
  }

  /// Get counter value
  int getCounter(String counterName) {
    return _counters[counterName] ?? 0;
  }

  /// Reset counter
  void resetCounter(String counterName) {
    _counters.remove(counterName);
    logger.debug('Counter reset: $counterName');
  }

  /// Get average duration for an operation
  Duration? getAverageDuration(String operationName) {
    final durations = _metrics[operationName];
    if (durations == null || durations.isEmpty) {
      return null;
    }
    
    final totalMilliseconds = durations
        .map((d) => d.inMilliseconds)
        .reduce((a, b) => a + b);
    
    return Duration(milliseconds: totalMilliseconds ~/ durations.length);
  }

  /// Get minimum duration for an operation
  Duration? getMinDuration(String operationName) {
    final durations = _metrics[operationName];
    if (durations == null || durations.isEmpty) {
      return null;
    }
    
    return durations.reduce((a, b) => a < b ? a : b);
  }

  /// Get maximum duration for an operation
  Duration? getMaxDuration(String operationName) {
    final durations = _metrics[operationName];
    if (durations == null || durations.isEmpty) {
      return null;
    }
    
    return durations.reduce((a, b) => a > b ? a : b);
  }

  /// Get operation count
  int getOperationCount(String operationName) {
    return _metrics[operationName]?.length ?? 0;
  }

  /// Get all performance metrics
  Map<String, Map<String, dynamic>> getAllMetrics() {
    final result = <String, Map<String, dynamic>>{};
    
    for (final entry in _metrics.entries) {
      final operationName = entry.key;
      final durations = entry.value;
      
      if (durations.isNotEmpty) {
        final totalMilliseconds = durations
            .map((d) => d.inMilliseconds)
            .reduce((a, b) => a + b);
        
        result[operationName] = {
          'count': durations.length,
          'average': Duration(milliseconds: totalMilliseconds ~/ durations.length),
          'min': durations.reduce((a, b) => a < b ? a : b),
          'max': durations.reduce((a, b) => a > b ? a : b),
          'total': Duration(milliseconds: totalMilliseconds),
        };
      }
    }
    
    return result;
  }

  /// Get all counters
  Map<String, int> getAllCounters() {
    return Map.from(_counters);
  }

  /// Clear all metrics
  void clearMetrics() {
    _metrics.clear();
    _counters.clear();
    logger.info('All performance metrics cleared');
  }

  /// Clear metrics for specific operation
  void clearMetricsForOperation(String operationName) {
    _metrics.remove(operationName);
    logger.info('Metrics cleared for operation: $operationName');
  }

  /// Generate performance report
  String generateReport() {
    final buffer = StringBuffer();
    buffer.writeln('=== Performance Report ===');
    
    // Metrics
    buffer.writeln('\n--- Metrics ---');
    for (final entry in _metrics.entries) {
      final operationName = entry.key;
      final durations = entry.value;
      
      if (durations.isNotEmpty) {
        final avg = getAverageDuration(operationName);
        final min = getMinDuration(operationName);
        final max = getMaxDuration(operationName);
        final count = durations.length;
        
        buffer.writeln('$operationName:');
        buffer.writeln('  Count: $count');
        buffer.writeln('  Average: ${avg?.inMilliseconds}ms');
        buffer.writeln('  Min: ${min?.inMilliseconds}ms');
        buffer.writeln('  Max: ${max?.inMilliseconds}ms');
        buffer.writeln();
      }
    }
    
    // Counters
    buffer.writeln('--- Counters ---');
    for (final entry in _counters.entries) {
      buffer.writeln('${entry.key}: ${entry.value}');
    }
    
    return buffer.toString();
  }

  /// Log performance report
  void logReport() {
    logger.info('Performance Report:\n${generateReport()}');
  }

  /// Check if operation is taking too long
  bool isOperationSlow(String operationName, Duration threshold) {
    final avg = getAverageDuration(operationName);
    return avg != null && avg > threshold;
  }

  /// Get slow operations
  List<String> getSlowOperations(Duration threshold) {
    final slowOperations = <String>[];
    
    for (final entry in _metrics.entries) {
      if (isOperationSlow(entry.key, threshold)) {
        slowOperations.add(entry.key);
      }
    }
    
    return slowOperations;
  }

  /// Monitor memory usage
  void logMemoryUsage() {
    // This is a simplified version. In a real app, you might use
    // platform-specific APIs to get actual memory usage
    logger.info('Memory usage monitoring enabled');
  }

  /// Track widget rebuilds
  void trackWidgetRebuild(String widgetName) {
    incrementCounter('widget_rebuilds_$widgetName');
  }

  /// Track API calls
  void trackApiCall(String endpoint) {
    incrementCounter('api_calls_$endpoint');
  }

  /// Track user actions
  void trackUserAction(String action) {
    incrementCounter('user_actions_$action');
  }

  /// Track errors
  void trackError(String errorType) {
    incrementCounter('errors_$errorType');
  }

  /// Track navigation
  void trackNavigation(String from, String to) {
    incrementCounter('navigation_${from}_to_$to');
  }
} 