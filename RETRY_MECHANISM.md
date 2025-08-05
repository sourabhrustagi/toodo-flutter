# Retry Mechanism Implementation

## 🎯 Overview

The Todo Flutter app now includes a comprehensive retry mechanism that automatically handles network failures, timeouts, and transient errors. This ensures a robust user experience even in poor network conditions.

## 🏗️ Architecture

### Retry Interceptor
The retry mechanism is implemented as a Dio interceptor that automatically retries failed requests based on configurable criteria:

```
Request → Dio → RetryInterceptor → Network → Response
                ↓
            Check Error
                ↓
            Should Retry?
                ↓
            Yes → Wait → Retry
            No → Return Error
```

### Key Components

1. **RetryInterceptor**: Main retry logic implementation
2. **RetryConfig**: Configuration for different retry policies
3. **RetryPolicy**: Predefined policies for different request types
4. **RetryStats**: Statistics and monitoring
5. **NetworkService**: Enhanced with retry support

## ⚙️ Configuration

### RetryConfig Options

```dart
const RetryConfig(
  maxRetries: 3,                    // Maximum retry attempts
  baseDelay: Duration(seconds: 1),  // Initial delay
  backoffMultiplier: 2.0,           // Exponential backoff multiplier
  retryableStatusCodes: [408, 429, 500, 502, 503, 504], // Retryable HTTP codes
  retryableExceptions: [DioException], // Retryable exception types
)
```

### Predefined Retry Policies

#### Authentication Requests
```dart
RetryPolicy.auth = RetryConfig(
  maxRetries: 2,
  baseDelay: Duration(seconds: 1),
  backoffMultiplier: 2.0,
  retryableStatusCodes: [401, 408, 429, 500, 502, 503, 504],
)
```

#### Data Fetching Requests
```dart
RetryPolicy.dataFetch = RetryConfig(
  maxRetries: 3,
  baseDelay: Duration(seconds: 1),
  backoffMultiplier: 2.0,
  retryableStatusCodes: [408, 429, 500, 502, 503, 504],
)
```

#### Data Modification Requests
```dart
RetryPolicy.dataModify = RetryConfig(
  maxRetries: 2,
  baseDelay: Duration(seconds: 2),
  backoffMultiplier: 3.0,
  retryableStatusCodes: [408, 429, 500, 502, 503, 504],
)
```

#### Critical Operations
```dart
RetryPolicy.critical = RetryConfig(
  maxRetries: 5,
  baseDelay: Duration(milliseconds: 500),
  backoffMultiplier: 1.5,
  retryableStatusCodes: [408, 429, 500, 502, 503, 504],
)
```

## 🔄 Retry Logic

### When to Retry

The retry mechanism automatically retries requests in the following scenarios:

#### HTTP Status Codes
- **408 Request Timeout**: Server timeout
- **429 Too Many Requests**: Rate limiting
- **500 Internal Server Error**: Server error
- **502 Bad Gateway**: Gateway error
- **503 Service Unavailable**: Service temporarily unavailable
- **504 Gateway Timeout**: Gateway timeout

#### Network Exceptions
- **Connection Timeout**: Network connection timeout
- **Receive Timeout**: Response timeout
- **Send Timeout**: Request timeout
- **Connection Error**: Network connectivity issues

#### DioException Types
- `DioExceptionType.connectionTimeout`
- `DioExceptionType.receiveTimeout`
- `DioExceptionType.sendTimeout`
- `DioExceptionType.connectionError`
- `DioExceptionType.badResponse` (for 5xx errors)

### When NOT to Retry

- **4xx Client Errors** (except 408, 429): User error, no point retrying
- **401 Unauthorized**: Authentication required
- **403 Forbidden**: Permission denied
- **404 Not Found**: Resource doesn't exist
- **422 Unprocessable Entity**: Invalid request data

## ⏱️ Exponential Backoff

### Delay Calculation

The retry mechanism uses exponential backoff with jitter to prevent thundering herd:

```dart
// Exponential backoff
final exponentialDelay = baseDelay * pow(backoffMultiplier, retryCount);

// Add jitter (±25%) to prevent thundering herd
final jitter = exponentialDelay.inMilliseconds * 0.25;
final jitterAmount = (random.nextDouble() * 2 - 1) * jitter;

final totalDelay = exponentialDelay.inMilliseconds + jitterAmount;
```

### Example Delays

| Retry Attempt | Base Delay | With Jitter |
|---------------|------------|-------------|
| 1st Retry     | 1 second   | 0.75-1.25s  |
| 2nd Retry     | 2 seconds  | 1.5-2.5s    |
| 3rd Retry     | 4 seconds  | 3-5s        |
| 4th Retry     | 8 seconds  | 6-10s       |

## 📊 Usage Examples

### Basic Usage

```dart
// Use default retry configuration
final response = await networkService.get('/api/data');

// Use specific retry configuration
final response = await networkService.get(
  '/api/data',
  retryConfig: RetryPolicy.dataFetch,
);

// Disable retry for specific requests
final response = await networkService.get(
  '/api/data',
  disableRetry: true,
);
```

### API Service Integration

```dart
// Authentication with retry
Future<Map<String, dynamic>> sendOTP(String phoneNumber) async {
  if (_useMockApi) {
    return _mockSendOTP(phoneNumber);
  } else {
    return _realSendOTP(phoneNumber);
  }
}

Future<Map<String, dynamic>> _realSendOTP(String phoneNumber) async {
  try {
    final response = await _networkService.post<Map<String, dynamic>>(
      '/auth/send-otp',
      data: {'phoneNumber': phoneNumber},
      retryConfig: RetryPolicy.auth,
    );

    return response.data ?? {};
  } catch (e) {
    logger.error('Failed to send OTP', e);
    rethrow;
  }
}
```

### Task Operations with Retry

```dart
// Fetch tasks with retry
Future<Map<String, dynamic>> getTasks() async {
  try {
    final response = await _networkService.get<Map<String, dynamic>>(
      '/tasks',
      retryConfig: RetryPolicy.dataFetch,
    );

    return response.data ?? {};
  } catch (e) {
    logger.error('Failed to get tasks', e);
    rethrow;
  }
}

// Create task with retry
Future<Map<String, dynamic>> createTask(Map<String, dynamic> taskData) async {
  try {
    final response = await _networkService.post<Map<String, dynamic>>(
      '/tasks',
      data: taskData,
      retryConfig: RetryPolicy.dataModify,
    );

    return response.data ?? {};
  } catch (e) {
    logger.error('Failed to create task', e);
    rethrow;
  }
}
```

## 📈 Monitoring & Statistics

### Retry Statistics

The retry mechanism provides comprehensive statistics:

```dart
// Get retry statistics
final stats = networkService.retryStats;
print('Retry Rate: ${stats['retryRate']}');
print('Success Rate: ${stats['retrySuccessRate']}');

// Reset statistics
networkService.resetRetryStats();
```

### Available Metrics

- **totalRequests**: Total number of requests made
- **retriedRequests**: Number of requests that were retried
- **successfulRetries**: Number of retries that succeeded
- **failedRetries**: Number of retries that failed
- **retrySuccessRate**: Percentage of retries that succeeded
- **retryRate**: Percentage of requests that were retried

### Logging

The retry mechanism provides detailed logging:

```
🌐 GET /api/tasks
✅ 200 GET /api/tasks
🌐 GET /api/tasks
❌ 500 GET /api/tasks
🔄 Retrying request /api/tasks (attempt 1/3) after 1000ms
✅ 200 GET /api/tasks
```

## 🛠️ Customization

### Custom Retry Configuration

```dart
// Create custom retry configuration
const customRetryConfig = RetryConfig(
  maxRetries: 5,
  baseDelay: Duration(milliseconds: 500),
  backoffMultiplier: 1.5,
  retryableStatusCodes: [408, 429, 500, 502, 503, 504],
);

// Use custom configuration
final response = await networkService.get(
  '/api/data',
  retryConfig: customRetryConfig,
);
```

### Disable Retry for Specific Requests

```dart
// Disable retry for non-critical requests
final response = await networkService.get(
  '/api/analytics',
  disableRetry: true,
);
```

### Custom Retry Logic

```dart
// Extend RetryInterceptor for custom logic
class CustomRetryInterceptor extends RetryInterceptor {
  @override
  bool _shouldRetry(DioException err) {
    // Custom retry logic
    if (err.response?.statusCode == 429) {
      // Don't retry rate limit errors immediately
      return false;
    }
    
    return super._shouldRetry(err);
  }
}
```

## 🧪 Testing

### Unit Testing Retry Logic

```dart
test('retries failed requests with exponential backoff', () async {
  // Arrange
  final mockDio = MockDio();
  when(mockDio.get(any)).thenThrow(DioException(
    requestOptions: RequestOptions(path: '/test'),
    type: DioExceptionType.connectionTimeout,
  ));

  // Act
  final result = await networkService.get('/test');

  // Assert
  verify(mockDio.get(any)).called(3); // Default max retries
});
```

### Integration Testing

```dart
testWidgets('handles network failures gracefully', (tester) async {
  // Arrange - Simulate network failure
  await tester.pumpWidget(const MyApp());

  // Act - Trigger API call
  await tester.tap(find.text('Load Tasks'));
  await tester.pumpAndSettle();

  // Assert - Should show retry option or handle gracefully
  expect(find.text('Retry'), findsOneWidget);
});
```

## 🚀 Performance Considerations

### Memory Usage
- Retry interceptor adds minimal memory overhead
- Statistics tracking uses minimal memory
- No persistent storage of retry data

### Network Efficiency
- Exponential backoff prevents overwhelming servers
- Jitter prevents thundering herd problems
- Configurable retry limits prevent infinite loops

### Battery Impact
- Minimal battery impact due to efficient implementation
- Delays are calculated, not slept
- Network calls are batched when possible

## 🔧 Troubleshooting

### Common Issues

#### Too Many Retries
```dart
// Reduce retry attempts
const conservativeRetryConfig = RetryConfig(
  maxRetries: 1,
  baseDelay: Duration(seconds: 2),
);
```

#### Slow Response Times
```dart
// Use aggressive retry for critical operations
const aggressiveRetryConfig = RetryConfig(
  maxRetries: 5,
  baseDelay: Duration(milliseconds: 500),
  backoffMultiplier: 1.5,
);
```

#### Rate Limiting
```dart
// Don't retry rate limit errors
if (err.response?.statusCode == 429) {
  return false; // Don't retry
}
```

### Debug Mode

Enable detailed logging for debugging:

```dart
// In development
logger.setLevel(Level.debug);

// Check retry statistics
final stats = networkService.retryStats;
logger.info('Retry Statistics: $stats');
```

## 📋 Best Practices

### Do's
- ✅ Use appropriate retry policies for different request types
- ✅ Monitor retry statistics in production
- ✅ Set reasonable retry limits
- ✅ Use exponential backoff with jitter
- ✅ Log retry attempts for debugging

### Don'ts
- ❌ Don't retry on 4xx client errors (except 408, 429)
- ❌ Don't set unlimited retries
- ❌ Don't retry on authentication failures (401, 403)
- ❌ Don't retry on validation errors (422)
- ❌ Don't retry on resource not found (404)

## 🎯 Benefits

### User Experience
- **Improved Reliability**: Handles network failures gracefully
- **Better Performance**: Reduces failed requests
- **Consistent Behavior**: Predictable retry patterns
- **Reduced Frustration**: Users see fewer errors

### Developer Experience
- **Easy Configuration**: Simple retry policies
- **Comprehensive Logging**: Detailed retry information
- **Flexible Implementation**: Customizable retry logic
- **Good Testing**: Easy to test retry scenarios

### System Benefits
- **Reduced Server Load**: Prevents thundering herd
- **Better Monitoring**: Retry statistics for insights
- **Scalable Design**: Handles high traffic scenarios
- **Maintainable Code**: Clean, documented implementation

This retry mechanism ensures the Todo app provides a robust and reliable user experience even in challenging network conditions. 