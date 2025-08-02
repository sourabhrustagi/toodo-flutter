# Integration Tests

This directory contains integration tests for the Todo Flutter app. These tests verify that the app works correctly end-to-end, including user interactions, navigation, and data persistence.

## Test Coverage

The integration tests cover the following user flows:

1. **App Launch** - Verifies the app starts and shows the login screen
2. **Login Flow** - Tests the complete OTP-based authentication process
3. **Task Management** - Tests adding, completing, and deleting tasks
4. **Navigation** - Tests navigation between screens (home, feedback)
5. **Search Functionality** - Tests the task search feature
6. **Logout Flow** - Tests user logout and session management
7. **Theme Switching** - Tests theme-related functionality

## Running the Tests

### Prerequisites
- Flutter SDK installed
- A connected device or emulator (integration tests require a real device/emulator)
- Dependencies installed: `flutter pub get`

### Commands

#### Run all integration tests:
```bash
flutter test integration_test/
```

#### Run with specific device:
```bash
flutter test integration_test/ -d <device-id>
```

#### Run using flutter drive (alternative method):
```bash
flutter drive --driver integration_test/driver.dart --target integration_test/app_test.dart
```

### Device Setup

Integration tests must be run on a real device or emulator. They cannot run on web or desktop platforms.

**Android:**
```bash
# Start Android emulator
flutter emulators --launch <emulator-name>

# Or connect physical device
flutter devices
```

**iOS:**
```bash
# Start iOS simulator
open -a Simulator

# Or connect physical device
flutter devices
```

## Test Structure

- `app_test.dart` - Main integration test file containing all test cases
- `driver.dart` - Test driver for setup and teardown (optional)
- `README.md` - This documentation file

## Troubleshooting

### Common Issues:

1. **"No devices connected"** - Ensure you have a device/emulator running
2. **"Web devices are not supported"** - Integration tests cannot run on web
3. **Tests fail on specific elements** - Check if the UI has changed and update selectors
4. **Timeout errors** - Increase timeout values or check device performance

### Debug Mode:
```bash
flutter test integration_test/ --verbose
```

## Adding New Tests

To add new integration tests:

1. Add new `testWidgets` functions in `app_test.dart`
2. Follow the existing pattern of login → perform action → verify result
3. Use descriptive test names that explain the user flow being tested
4. Include proper setup and teardown if needed

## Best Practices

- Each test should be independent and not rely on other tests
- Use meaningful assertions that verify user-visible behavior
- Include both positive and negative test cases
- Test error scenarios and edge cases
- Keep tests focused on user workflows rather than implementation details 