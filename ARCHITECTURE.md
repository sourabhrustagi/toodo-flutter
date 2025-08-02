# Todo App Architecture

This Flutter app uses modern state management and navigation patterns with **BLoC** for state management and **GoRouter** for navigation.

## 🏗️ Architecture Overview

### State Management: BLoC Pattern
- **BLoC (Business Logic Component)** provides a clean separation between business logic and UI
- **Predictable state changes** through events and states
- **Testable** - each BLoC can be tested independently
- **Reactive** - UI automatically updates when state changes

### Navigation: GoRouter
- **Declarative routing** with type-safe navigation
- **Route guards** for authentication
- **Deep linking** support
- **Nested routes** for complex navigation structures

## 📁 Project Structure

```
lib/
├── blocs/                    # State management
│   ├── auth/
│   │   └── auth_bloc.dart   # Authentication state
│   ├── task/
│   │   └── task_bloc.dart   # Task management state
│   └── theme/
│       └── theme_bloc.dart  # Theme state
├── router/
│   └── app_router.dart      # Navigation configuration
├── screens/                  # UI screens
├── services/                 # Business logic services
├── repositories/             # Data access layer
├── models/                   # Data models
└── widgets/                  # Reusable UI components
```

## 🔄 BLoC Pattern

### Events → BLoC → States

**Events**: Actions that can be performed (e.g., `AuthGenerateOTP`, `TaskAdded`)
**BLoC**: Processes events and emits states
**States**: Current state of the app (e.g., `AuthLoading`, `TaskLoaded`)

### Example: Authentication Flow

```dart
// Event
context.read<AuthBloc>().add(AuthGenerateOTP('1234567890'));

// BLoC processes event and emits state
emit(AuthOTPSent(phoneNumber: '1234567890', generatedOTP: '123456'));

// UI reacts to state change
BlocBuilder<AuthBloc, AuthState>(
  builder: (context, state) {
    if (state is AuthOTPSent) {
      return OTPInputField();
    }
    return PhoneInputField();
  },
)
```

## 🧭 Navigation with GoRouter

### Route Configuration

```dart
GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    // Authentication guard
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthUnauthenticated && 
        state.matchedLocation == '/home') {
      return '/login';
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomeScreen(),
    ),
  ],
)
```

### Navigation Methods

```dart
// Navigate to a route
context.go('/home');

// Navigate with parameters
context.go('/task/${taskId}');

// Navigate and replace current route
context.goNamed('home');

// Go back
context.pop();
```

## 🎯 Key Features

### 1. Authentication BLoC
- **Events**: `AuthInitialized`, `AuthGenerateOTP`, `AuthVerifyOTP`, `AuthLogout`
- **States**: `AuthLoading`, `AuthUnauthenticated`, `AuthOTPSent`, `AuthAuthenticated`
- **Features**: OTP-based authentication, session management

### 2. Task BLoC
- **Events**: `TaskAdded`, `TaskUpdated`, `TaskDeleted`, `TaskToggled`, `TaskSearched`
- **States**: `TaskLoading`, `TaskLoaded`, `TaskError`
- **Features**: CRUD operations, search, filtering

### 3. Theme BLoC
- **Events**: `ThemeInitialized`, `ThemeChanged`, `ThemeToggled`
- **States**: `ThemeLoaded`
- **Features**: Light/dark theme switching, persistence

### 4. Navigation Guards
- **Authentication**: Redirects unauthenticated users to login
- **Route Protection**: Prevents access to protected routes
- **Auto-redirect**: Handles root path routing

## 🧪 Testing

### BLoC Testing
```dart
blocTest<AuthBloc, AuthState>(
  'emits [AuthLoading, AuthOTPSent] when AuthGenerateOTP is added',
  build: () => AuthBloc(authService: mockAuthService),
  act: (bloc) => bloc.add(AuthGenerateOTP('1234567890')),
  expect: () => [
    AuthLoading(),
    AuthOTPSent(phoneNumber: '1234567890', generatedOTP: '123456'),
  ],
);
```

### Navigation Testing
```dart
testWidgets('redirects to login when not authenticated', (tester) async {
  await tester.pumpWidget(MyApp());
  await tester.pumpAndSettle();
  
  expect(find.text('Todo App'), findsOneWidget);
  expect(find.text('My Tasks'), findsNothing);
});
```

## 🚀 Benefits

### BLoC Benefits
- ✅ **Separation of Concerns**: Business logic separated from UI
- ✅ **Testability**: Easy to unit test business logic
- ✅ **Predictable**: State changes are explicit and traceable
- ✅ **Reactive**: UI automatically updates with state changes
- ✅ **Scalable**: Easy to add new features and states

### GoRouter Benefits
- ✅ **Type Safety**: Compile-time route checking
- ✅ **Declarative**: Routes defined in one place
- ✅ **Guards**: Built-in authentication and authorization
- ✅ **Deep Linking**: Support for deep links and web URLs
- ✅ **Nested Routes**: Complex navigation structures

## 📚 Best Practices

### BLoC Best Practices
1. **Keep BLoCs focused** - One BLoC per feature
2. **Use meaningful event names** - Clear action descriptions
3. **Handle errors gracefully** - Always emit error states
4. **Test thoroughly** - Unit test all BLoC logic
5. **Use equatable** - For proper state comparison

### Navigation Best Practices
1. **Centralize routes** - Define all routes in one place
2. **Use route guards** - Protect sensitive routes
3. **Handle deep links** - Support external navigation
4. **Test navigation** - Ensure routes work correctly
5. **Use named routes** - For better maintainability

## 🔧 Migration from Provider

### Before (Provider)
```dart
Consumer<AuthViewModel>(
  builder: (context, authVM, child) {
    return Text(authVM.isLoggedIn ? 'Logged In' : 'Not Logged In');
  },
)
```

### After (BLoC)
```dart
BlocBuilder<AuthBloc, AuthState>(
  builder: (context, state) {
    if (state is AuthAuthenticated) {
      return Text('Logged In');
    }
    return Text('Not Logged In');
  },
)
```

## 🎯 Next Steps

1. **Update remaining screens** to use BLoC pattern
2. **Add comprehensive tests** for all BLoCs
3. **Implement error handling** and loading states
4. **Add offline support** with proper state management
5. **Optimize performance** with BLoC selectors

This architecture provides a solid foundation for a scalable, maintainable, and testable Flutter application. 