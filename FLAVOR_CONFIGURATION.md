# Flavor Configuration Guide

## Overview

The Todo Flutter app now supports three distinct flavors for different environments:

- **Mock** - For development and testing with mock data
- **Development** - For development with real API endpoints
- **Production** - For production deployment

## Flavor Configuration

### Environment Variables

The app uses the `FLAVOR` environment variable to determine the current environment:

```dart
static String get currentFlavor => const String.fromEnvironment('FLAVOR', defaultValue: 'mock');
```

### Available Flavors

| Flavor | Environment Variable | Description |
|--------|-------------------|-------------|
| **Mock** | `FLAVOR=mock` | Development with mock data |
| **Development** | `FLAVOR=development` | Development with real API |
| **Production** | `FLAVOR=production` | Production deployment |

## Configuration by Flavor

### API Configuration

| Setting | Mock | Development | Production |
|---------|------|-------------|------------|
| **Base URL** | `https://mock-api.todoapp.com/v1` | `https://dev-api.todoapp.com/v1` | `https://api.todoapp.com/v1` |
| **Timeout** | 5 seconds | 15 seconds | 30 seconds |
| **Max Retries** | 1 | 2 | 3 |
| **Mock API** | ✅ Enabled | ❌ Disabled | ❌ Disabled |
| **API Logging** | ✅ Enabled | ✅ Enabled | ❌ Disabled |
| **API Retry** | ❌ Disabled | ✅ Enabled | ✅ Enabled |

### Mock API Settings

| Setting | Mock | Development | Production |
|---------|------|-------------|------------|
| **Delay** | 2 seconds | 1 second | 0.5 seconds |
| **Failure Rate** | 10% | 5% | 0% |

### App Configuration

| Setting | Mock | Development | Production |
|---------|------|-------------|------------|
| **App Name** | "Todo App (Mock)" | "Todo App (Dev)" | "Todo App" |
| **Bundle ID Suffix** | `.mock` | `.dev` | (none) |
| **Version Suffix** | `-mock` | `-dev` | (none) |

## Running Different Flavors

### Mock Flavor (Default)

```bash
# Run mock flavor
flutter run

# Or explicitly
flutter run --dart-define=FLAVOR=mock
```

### Development Flavor

```bash
# Run development flavor
flutter run --dart-define=FLAVOR=development
```

### Production Flavor

```bash
# Run production flavor
flutter run --dart-define=FLAVOR=production
```

## Building Different Flavors

### Android

```bash
# Build mock APK
flutter build apk --dart-define=FLAVOR=mock

# Build development APK
flutter build apk --dart-define=FLAVOR=development

# Build production APK
flutter build apk --dart-define=FLAVOR=production
```

### iOS

```bash
# Build mock IPA
flutter build ios --dart-define=FLAVOR=mock

# Build development IPA
flutter build ios --dart-define=FLAVOR=development

# Build production IPA
flutter build ios --dart-define=FLAVOR=production
```

## Flavor-Specific Features

### Mock Flavor

- ✅ **No backend required** - Perfect for development
- ✅ **Consistent data** - Pre-defined mock tasks
- ✅ **Controlled delays** - Simulates network conditions
- ✅ **Error simulation** - Configurable failure rates
- ✅ **Fast development** - No network dependencies

### Development Flavor

- 🌐 **Real API endpoints** - Connects to development server
- 🔍 **Enhanced logging** - Detailed API request/response logs
- ⚡ **Faster timeouts** - Quick feedback for development
- 🛠️ **Debug features** - Development-specific optimizations

### Production Flavor

- 🚀 **Production API** - Connects to production server
- 🔒 **Security optimized** - Disabled logging for security
- ⚡ **Performance optimized** - Longer timeouts for reliability
- 📱 **Release ready** - Production-optimized settings

## Android Configuration

### Product Flavors

The Android build configuration includes three product flavors:

```gradle
productFlavors {
    mock {
        dimension "environment"
        applicationIdSuffix ".mock"
        versionNameSuffix "-mock"
        buildConfigField "String", "FLAVOR", "\"mock\""
        manifestPlaceholders = [
            appName: "Todo App (Mock)"
        ]
    }
    
    development {
        dimension "environment"
        applicationIdSuffix ".dev"
        versionNameSuffix "-dev"
        buildConfigField "String", "FLAVOR", "\"development\""
        manifestPlaceholders = [
            appName: "Todo App (Dev)"
        ]
    }
    
    production {
        dimension "environment"
        buildConfigField "String", "FLAVOR", "\"production\""
        manifestPlaceholders = [
            appName: "Todo App"
        ]
    }
}
```

### Bundle IDs

| Flavor | Bundle ID |
|--------|-----------|
| Mock | `com.example.toodoflutter.mock` |
| Development | `com.example.toodoflutter.dev` |
| Production | `com.example.toodoflutter` |

## iOS Configuration

### Build Configurations

The iOS project supports different build configurations for each flavor:

- **Debug** - Development builds
- **Release** - Production builds
- **Profile** - Performance testing

### App Names

| Flavor | App Name |
|--------|----------|
| Mock | "Todo App (Mock)" |
| Development | "Todo App (Dev)" |
| Production | "Todo App" |

## Development Workflow

### 1. Local Development

```bash
# Start with mock flavor for fast development
flutter run --dart-define=FLAVOR=mock
```

### 2. API Testing

```bash
# Test with development API
flutter run --dart-define=FLAVOR=development
```

### 3. Production Testing

```bash
# Test production configuration
flutter run --dart-define=FLAVOR=production
```

## Environment Detection

### In Code

```dart
// Check current flavor
if (AppConstants.isMock) {
  // Mock-specific logic
} else if (AppConstants.isDevelopment) {
  // Development-specific logic
} else if (AppConstants.isProduction) {
  // Production-specific logic
}

// Get current flavor name
String flavor = AppConstants.currentFlavor;
```

### Runtime Information

The app displays the current flavor in:
- App title
- Log messages
- Debug information

## Configuration Management

### Adding New Settings

To add a new flavor-specific setting:

1. **Add to AppConstants**:
```dart
static bool get myNewSetting {
  switch (const String.fromEnvironment('FLAVOR', defaultValue: 'mock')) {
    case 'production':
      return false;
    case 'development':
      return true;
    case 'mock':
    default:
      return true;
  }
}
```

2. **Use in code**:
```dart
if (AppConstants.myNewSetting) {
  // Feature enabled
}
```

### Environment-Specific Files

You can create flavor-specific files:

```
lib/
├── config/
│   ├── mock_config.dart
│   ├── development_config.dart
│   └── production_config.dart
```

## Testing

### Unit Tests

```bash
# Run tests for all flavors
flutter test --dart-define=FLAVOR=mock
flutter test --dart-define=FLAVOR=development
flutter test --dart-define=FLAVOR=production
```

### Integration Tests

```bash
# Run integration tests
flutter drive --target=test_driver/app.dart --dart-define=FLAVOR=mock
```

## Deployment

### CI/CD Configuration

```yaml
# Example GitHub Actions workflow
jobs:
  build:
    steps:
      - name: Build Mock APK
        run: flutter build apk --dart-define=FLAVOR=mock
      
      - name: Build Development APK
        run: flutter build apk --dart-define=FLAVOR=development
      
      - name: Build Production APK
        run: flutter build apk --dart-define=FLAVOR=production
```

### App Store Deployment

```bash
# Build for App Store (Production)
flutter build ios --dart-define=FLAVOR=production --release
```

## Troubleshooting

### Common Issues

1. **Flavor not detected**
   - Check `--dart-define=FLAVOR=flavor_name`
   - Verify environment variable is set

2. **Build errors**
   - Clean and rebuild: `flutter clean && flutter pub get`
   - Check flavor-specific configurations

3. **API not working**
   - Verify base URL for current flavor
   - Check network connectivity
   - Review API configuration

### Debug Information

The app logs flavor information on startup:

```
Current flavor: mock
API Base URL: https://mock-api.todoapp.com/v1
Mock API enabled: true
```

## Best Practices

### Development

1. **Use Mock for Development** - Fast iteration without API dependencies
2. **Test with Development** - Verify API integration before production
3. **Use Production for Final Testing** - Ensure production configuration works

### Configuration

1. **Keep Flavors Simple** - Avoid complex flavor-specific logic
2. **Use Constants** - Centralize configuration in AppConstants
3. **Document Changes** - Update this guide when adding new features

### Security

1. **Disable Logging in Production** - Prevent sensitive data exposure
2. **Use Secure Storage** - Store sensitive data securely
3. **Validate Configuration** - Ensure production settings are correct

## Migration Guide

### From Single Environment

1. **Update AppConstants** - Add flavor-specific getters
2. **Test Each Flavor** - Verify all flavors work correctly
3. **Update Build Scripts** - Add flavor-specific build commands
4. **Update Documentation** - Document flavor usage

### Adding New Flavors

1. **Define Configuration** - Add flavor-specific settings
2. **Update Build Files** - Add Android/iOS configurations
3. **Test Thoroughly** - Verify all features work
4. **Update Documentation** - Document new flavor

---

**Note**: Always test all flavors before deployment to ensure consistent behavior across environments. 