# API Configuration Guide

## Overview

The Todo Flutter app now supports both **Mock API** and **Real API** modes through a simple configuration flag. This allows for easy development, testing, and production deployment.

## Configuration

### API Mode Flag

The API mode is controlled by the `useMockApi` flag in `lib/core/constants/app_constants.dart`:

```dart
// API Feature Flags
static const bool useMockApi = true; // Set to false to use real API
```

### Available Settings

```dart
// API Configuration
static const String baseUrl = 'https://api.todoapp.com/v1';
static const Duration apiTimeout = Duration(seconds: 30);
static const int maxRetries = 3;

// API Feature Flags
static const bool useMockApi = true; // Set to false to use real API
static const bool enableApiLogging = true;
static const bool enableApiRetry = true;

// Mock API Configuration
static const Duration mockApiDelay = Duration(seconds: 1);
static const double mockApiFailureRate = 0.1; // 10% failure rate
```

## Usage

### Mock API Mode (Default)

When `useMockApi = true`:

- ✅ **No backend required** - Perfect for development and testing
- ✅ **Consistent data** - Pre-defined mock tasks and categories
- ✅ **Controlled delays** - Simulates real network conditions
- ✅ **Error simulation** - Configurable failure rate for testing
- ✅ **All features work** - Complete CRUD operations, search, analytics

### Real API Mode

When `useMockApi = false`:

- 🌐 **Real backend** - Connects to `https://api.todoapp.com/v1`
- 🔐 **Authentication** - Uses Bearer tokens for API calls
- 📊 **Live data** - Real-time task management
- 🚀 **Production ready** - Full API integration

## API Endpoints

The app implements all the documented API endpoints:

### Authentication
- `POST /auth/login` - Send OTP
- `POST /auth/verify-otp` - Verify OTP and get token
- `POST /auth/logout` - Logout user

### Tasks
- `GET /tasks` - Get all tasks with filters
- `POST /tasks` - Create new task
- `GET /tasks/{id}` - Get specific task
- `PUT /tasks/{id}` - Update task
- `DELETE /tasks/{id}` - Delete task
- `PATCH /tasks/{id}/complete` - Mark task as completed

### Categories
- `GET /categories` - Get all categories
- `POST /categories` - Create new category

### Bulk Operations
- `POST /tasks/bulk` - Bulk task operations

### Search
- `GET /tasks/search` - Search tasks

### Analytics
- `GET /tasks/analytics` - Get task statistics

### Feedback
- `POST /feedback` - Submit feedback
- `GET /feedback` - Get feedback history

## Switching Between Modes

### For Development
```dart
static const bool useMockApi = true;
```

### For Production
```dart
static const bool useMockApi = false;
```

## Mock Data

When using mock API mode, the app includes:

### Sample Tasks
- "Complete project documentation" (High priority, Work category)
- "Buy groceries" (Medium priority, Personal category)

### Sample Categories
- Work (#FF5722)
- Personal (#4CAF50)

### Authentication
- OTP: `123456` (for testing)
- Email login: `password123` (for testing)

## Error Handling

Both modes include comprehensive error handling:

- **Network errors** - Connection timeouts, server errors
- **Authentication errors** - Invalid tokens, expired sessions
- **Validation errors** - Invalid data, missing required fields
- **Mock failures** - Configurable 10% failure rate for testing

## Performance

### Mock Mode
- **Fast response** - No network latency
- **Configurable delays** - Simulates real API timing
- **Predictable behavior** - Consistent for testing

### Real Mode
- **Network optimization** - Connection pooling, retry logic
- **Caching** - Local data persistence
- **Error recovery** - Automatic retries for transient failures

## Testing

The mock API mode is perfect for:

- ✅ **Unit testing** - No external dependencies
- ✅ **Integration testing** - Predictable data
- ✅ **UI testing** - Consistent behavior
- ✅ **Performance testing** - Configurable delays

## Deployment

### Development
```bash
# Use mock API for development
flutter run
```

### Production
```bash
# Switch to real API for production
# Edit lib/core/constants/app_constants.dart
# Set useMockApi = false
flutter build apk --release
```

## Troubleshooting

### Common Issues

1. **API not responding**
   - Check `useMockApi` flag
   - Verify network connectivity
   - Check API base URL

2. **Authentication errors**
   - Verify token storage
   - Check token expiration
   - Clear app data if needed

3. **Mock data not loading**
   - Restart the app
   - Check mock initialization
   - Verify mock data structure

### Debug Mode

Enable API logging for debugging:

```dart
static const bool enableApiLogging = true;
```

This will log all API requests and responses to the console.

## Migration Guide

### From Mock to Real API

1. **Update configuration**
   ```dart
   static const bool useMockApi = false;
   ```

2. **Verify API endpoints**
   - Ensure all endpoints are implemented
   - Test authentication flow
   - Validate data formats

3. **Update error handling**
   - Handle real network errors
   - Implement retry logic
   - Add offline support

4. **Test thoroughly**
   - Test all CRUD operations
   - Verify authentication
   - Check error scenarios

## Support

For issues or questions:

1. Check the API documentation
2. Verify configuration settings
3. Test with mock mode first
4. Review error logs
5. Contact development team

---

**Note**: The mock API mode is designed for development and testing. For production use, always switch to real API mode and ensure proper backend implementation. 