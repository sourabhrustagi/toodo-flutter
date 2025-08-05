# Testing Strategy & Best Practices

## 🎯 Testing Philosophy

### Testing Pyramid
```
    ┌─────────────┐
    │   E2E Tests │ ← Few, Critical Paths
    └─────────────┘
    ┌─────────────┐
    │Integration  │ ← Some, Key Features
    │   Tests     │
    └─────────────┘
    ┌─────────────┐
    │  Unit Tests │ ← Many, All Components
    └─────────────┘
```

### Testing Principles
- **Fast**: Tests should run quickly (< 30 seconds for unit tests)
- **Reliable**: Tests should be deterministic and not flaky
- **Isolated**: Each test should be independent
- **Maintainable**: Tests should be easy to understand and modify
- **Comprehensive**: Cover all critical paths and edge cases

## 📊 Testing Coverage Goals

### Unit Tests: 90%+ Coverage
- **BLoCs**: All events and state transitions
- **Services**: All business logic methods
- **Repositories**: All data access methods
- **Models**: All data transformations
- **Utils**: All utility functions

### Integration Tests: Key Features
- **Authentication Flow**: Login, logout, session management
- **Task Management**: CRUD operations, search, filtering
- **Data Persistence**: Database operations, API calls
- **Navigation**: Route transitions, deep linking

### E2E Tests: Critical Paths
- **User Journey**: Complete user workflows
- **Error Handling**: Network failures, validation errors
- **Performance**: App startup, memory usage

## 🧪 Unit Testing

### BLoC Testing

#### Test Structure
```dart
group('AuthBloc', () {
  late AuthBloc authBloc;
  late MockAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
    authBloc = AuthBloc(authService: mockAuthService);
  });

  tearDown(() {
    authBloc.close();
  });

  group('AuthGenerateOTP', () {
    test('emits [AuthLoading, AuthOTPSent] when successful', () {
      // Arrange
      when(mockAuthService.generateOTP(any))
          .thenAnswer((_) async => '123456');

      // Act & Assert
      expectLater(
        authBloc.stream,
        emitsInOrder([
          AuthLoading(),
          AuthOTPSent(phoneNumber: '1234567890', generatedOTP: '123456'),
        ]),
      );

      authBloc.add(AuthGenerateOTP('1234567890'));
    });

    test('emits [AuthLoading, AuthError] when failed', () {
      // Arrange
      when(mockAuthService.generateOTP(any))
          .thenThrow(AuthError('Failed to send OTP'));

      // Act & Assert
      expectLater(
        authBloc.stream,
        emitsInOrder([
          AuthLoading(),
          AuthError(message: 'Failed to send OTP'),
        ]),
      );

      authBloc.add(AuthGenerateOTP('1234567890'));
    });
  });
});
```

#### BLoC Test Best Practices
```dart
// Use blocTest for complex scenarios
blocTest<AuthBloc, AuthState>(
  'emits [AuthLoading, AuthOTPSent] when AuthGenerateOTP is added',
  build: () => AuthBloc(authService: mockAuthService),
  act: (bloc) => bloc.add(AuthGenerateOTP('1234567890')),
  expect: () => [
    AuthLoading(),
    AuthOTPSent(phoneNumber: '1234567890', generatedOTP: '123456'),
  ],
  verify: (bloc) {
    verify(mockAuthService.generateOTP('1234567890')).called(1);
  },
);

// Test error scenarios
blocTest<AuthBloc, AuthState>(
  'emits [AuthLoading, AuthError] when AuthGenerateOTP fails',
  build: () => AuthBloc(authService: mockAuthService),
  act: (bloc) => bloc.add(AuthGenerateOTP('1234567890')),
  expect: () => [
    AuthLoading(),
    AuthError(message: 'Network error'),
  ],
  errors: () => [isA<NetworkError>()],
);
```

### Service Testing

#### Repository Testing
```dart
group('TaskRepository', () {
  late TaskRepository taskRepository;
  late MockApiService mockApiService;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockApiService = MockApiService();
    mockDatabaseHelper = MockDatabaseHelper();
    taskRepository = TaskRepository(
      apiService: mockApiService,
      databaseHelper: mockDatabaseHelper,
    );
  });

  group('getAllTasks', () {
    test('returns success with tasks when API call succeeds', () async {
      // Arrange
      final mockTasks = [mockTask1, mockTask2];
      when(mockApiService.getTasks())
          .thenAnswer((_) async => {'success': true, 'data': {'tasks': mockTasks}});

      // Act
      final result = await taskRepository.getAllTasks();

      // Assert
      expect(result.isSuccess, true);
      expect(result.data, mockTasks);
      verify(mockApiService.getTasks()).called(1);
    });

    test('returns failure when API call fails', () async {
      // Arrange
      when(mockApiService.getTasks())
          .thenThrow(NetworkError('Connection failed'));

      // Act
      final result = await taskRepository.getAllTasks();

      // Assert
      expect(result.isFailure, true);
      expect(result.error, isA<NetworkError>());
    });
  });
});
```

#### Service Testing
```dart
group('AuthService', () {
  late AuthService authService;
  late MockApiService mockApiService;
  late MockSecureStorageService mockSecureStorage;

  setUp(() {
    mockApiService = MockApiService();
    mockSecureStorage = MockSecureStorageService();
    authService = AuthService(
      apiService: mockApiService,
      secureStorageService: mockSecureStorage,
    );
  });

  group('generateOTP', () {
    test('returns success when API call succeeds', () async {
      // Arrange
      when(mockApiService.sendOTP(any))
          .thenAnswer((_) async => {'success': true, 'otp': '123456'});

      // Act
      final result = await authService.generateOTP('1234567890');

      // Assert
      expect(result.isSuccess, true);
      expect(result.data, '123456');
    });

    test('returns failure when API call fails', () async {
      // Arrange
      when(mockApiService.sendOTP(any))
          .thenThrow(NetworkError('Connection failed'));

      // Act
      final result = await authService.generateOTP('1234567890');

      // Assert
      expect(result.isFailure, true);
      expect(result.error, isA<NetworkError>());
    });
  });
});
```

### Widget Testing

#### Screen Testing
```dart
group('LoginScreen', () {
  testWidgets('shows phone input field initially', (tester) async {
    // Arrange
    await tester.pumpWidget(
      BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(authService: MockAuthService()),
        child: const MaterialApp(home: LoginScreen()),
      ),
    );

    // Assert
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Phone Number'), findsOneWidget);
  });

  testWidgets('shows OTP input when OTP is sent', (tester) async {
    // Arrange
    final authBloc = AuthBloc(authService: MockAuthService());
    await tester.pumpWidget(
      BlocProvider<AuthBloc>.value(
        value: authBloc,
        child: const MaterialApp(home: LoginScreen()),
      ),
    );

    // Act
    authBloc.add(AuthGenerateOTP('1234567890'));
    await tester.pump();

    // Assert
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('OTP'), findsOneWidget);
  });

  testWidgets('shows error message when login fails', (tester) async {
    // Arrange
    final authBloc = AuthBloc(authService: MockAuthService());
    await tester.pumpWidget(
      BlocProvider<AuthBloc>.value(
        value: authBloc,
        child: const MaterialApp(home: LoginScreen()),
      ),
    );

    // Act
    authBloc.add(AuthGenerateOTP('1234567890'));
    authBloc.add(AuthError(message: 'Invalid phone number'));
    await tester.pump();

    // Assert
    expect(find.text('Invalid phone number'), findsOneWidget);
  });
});
```

#### Widget Testing Best Practices
```dart
// Use testWidgets for UI testing
testWidgets('TaskCard displays task information correctly', (tester) async {
  // Arrange
  final task = Task(
    id: '1',
    title: 'Test Task',
    description: 'Test Description',
    priority: TaskPriority.high,
    isCompleted: false,
  );

  // Act
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: TaskCard(
          task: task,
          onToggle: (task) {},
          onDelete: (task) {},
        ),
      ),
    ),
  );

  // Assert
  expect(find.text('Test Task'), findsOneWidget);
  expect(find.text('Test Description'), findsOneWidget);
  expect(find.byIcon(Icons.priority_high), findsOneWidget);
});

// Test user interactions
testWidgets('TaskCard calls onToggle when checkbox is tapped', (tester) async {
  // Arrange
  final task = mockTask;
  bool toggleCalled = false;

  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: TaskCard(
          task: task,
          onToggle: (task) => toggleCalled = true,
          onDelete: (task) {},
        ),
      ),
    ),
  );

  // Act
  await tester.tap(find.byType(Checkbox));
  await tester.pump();

  // Assert
  expect(toggleCalled, true);
});
```

## 🔄 Integration Testing

### Repository Integration Tests
```dart
group('TaskRepository Integration', () {
  late TaskRepository taskRepository;
  late ApiService apiService;
  late DatabaseHelper databaseHelper;

  setUp(() async {
    databaseHelper = DatabaseHelper();
    await databaseHelper.initialize();
    
    apiService = ApiService();
    await apiService.initialize();
    
    taskRepository = TaskRepository(
      apiService: apiService,
      databaseHelper: databaseHelper,
    );
  });

  tearDown(() async {
    await databaseHelper.close();
  });

  test('creates and retrieves task successfully', () async {
    // Arrange
    final task = Task(
      title: 'Integration Test Task',
      description: 'Test Description',
      priority: TaskPriority.medium,
    );

    // Act
    final createdTask = await taskRepository.createTask(task);
    final retrievedTask = await taskRepository.getTask(createdTask.id!);

    // Assert
    expect(retrievedTask, isNotNull);
    expect(retrievedTask!.title, 'Integration Test Task');
    expect(retrievedTask.description, 'Test Description');
  });
});
```

### Service Integration Tests
```dart
group('AuthService Integration', () {
  late AuthService authService;
  late ApiService apiService;
  late SecureStorageService secureStorage;

  setUp(() async {
    secureStorage = SecureStorageService();
    apiService = ApiService();
    await apiService.initialize();
    
    authService = AuthService(
      apiService: apiService,
      secureStorageService: secureStorage,
    );
  });

  test('generates and verifies OTP successfully', () async {
    // Act
    final otp = await authService.generateOTP('1234567890');
    final isVerified = await authService.verifyOTP(
      '1234567890',
      otp,
      otp,
    );

    // Assert
    expect(otp, isNotEmpty);
    expect(isVerified, true);
  });
});
```

## 🚀 E2E Testing

### Critical Path Testing
```dart
group('E2E Tests', () {
  testWidgets('complete user journey: login -> create task -> logout', (tester) async {
    // Start app
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Login
    await tester.enterText(find.byType(TextField).first, '1234567890');
    await tester.tap(find.text('Send OTP'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).last, '123456');
    await tester.tap(find.text('Verify OTP'));
    await tester.pumpAndSettle();

    // Verify login success
    expect(find.text('My Tasks'), findsOneWidget);

    // Create task
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, 'E2E Test Task');
    await tester.enterText(find.byType(TextField).last, 'E2E Test Description');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    // Verify task created
    expect(find.text('E2E Test Task'), findsOneWidget);

    // Logout
    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Logout'));
    await tester.pumpAndSettle();

    // Verify logout success
    expect(find.text('Login'), findsOneWidget);
  });
});
```

## 📊 Test Coverage

### Coverage Configuration
```yaml
# pubspec.yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: ^5.4.4
  bloc_test: ^9.1.5
  integration_test:
    sdk: flutter
  coverage: ^1.6.3
```

### Coverage Commands
```bash
# Run tests with coverage
flutter test --coverage

# Generate coverage report
genhtml coverage/lcov.info -o coverage/html

# Run specific test files
flutter test test/blocs/auth/auth_bloc_test.dart

# Run integration tests
flutter test integration_test/

# Run E2E tests
flutter drive --target=test_driver/app.dart
```

### Coverage Goals
- **Unit Tests**: 90%+ line coverage
- **Integration Tests**: 70%+ feature coverage
- **E2E Tests**: 100% critical path coverage

## 🛠️ Test Utilities

### Mock Factories
```dart
class MockFactory {
  static Task mockTask({
    String? id,
    String? title,
    String? description,
    TaskPriority? priority,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? 'mock_id',
      title: title ?? 'Mock Task',
      description: description ?? 'Mock Description',
      priority: priority ?? TaskPriority.medium,
      isCompleted: isCompleted ?? false,
    );
  }

  static List<Task> mockTasks([int count = 3]) {
    return List.generate(
      count,
      (index) => mockTask(
        id: 'task_$index',
        title: 'Task $index',
        description: 'Description $index',
      ),
    );
  }
}
```

### Test Helpers
```dart
class TestHelpers {
  static Future<void> pumpWidgetWithDependencies(
    WidgetTester tester,
    Widget widget, {
    List<BlocProvider> providers = const [],
  }) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: providers,
        child: MaterialApp(home: widget),
      ),
    );
  }

  static Future<void> waitForBlocState<T extends BlocBase>(
    WidgetTester tester,
    T bloc,
    bool Function(T state) predicate,
  ) async {
    while (!predicate(bloc.state)) {
      await tester.pump(const Duration(milliseconds: 100));
    }
  }
}
```

## 📈 Performance Testing

### Memory Testing
```dart
testWidgets('does not leak memory during navigation', (tester) async {
  // Arrange
  final initialMemory = ProcessInfo.currentRss;
  
  // Act - Navigate multiple times
  for (int i = 0; i < 10; i++) {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
  }
  
  // Assert
  final finalMemory = ProcessInfo.currentRss;
  final memoryIncrease = finalMemory - initialMemory;
  expect(memoryIncrease, lessThan(10 * 1024 * 1024)); // 10MB limit
});
```

### Performance Testing
```dart
testWidgets('app startup time is acceptable', (tester) async {
  // Arrange
  final stopwatch = Stopwatch()..start();
  
  // Act
  await tester.pumpWidget(const MyApp());
  await tester.pumpAndSettle();
  stopwatch.stop();
  
  // Assert
  expect(stopwatch.elapsedMilliseconds, lessThan(3000)); // 3 seconds
});
```

## 🔍 Debugging Tests

### Common Issues & Solutions

#### Flaky Tests
```dart
// Problem: Tests fail intermittently
// Solution: Use proper waiting mechanisms
testWidgets('waits for async operations', (tester) async {
  await tester.pumpWidget(const MyApp());
  
  // Wait for all animations to complete
  await tester.pumpAndSettle();
  
  // Wait for specific condition
  await tester.pumpUntil(() => find.text('Loaded').evaluate().isNotEmpty);
});
```

#### Mock Verification
```dart
// Problem: Mocks not called as expected
// Solution: Use proper verification
verify(mockService.method(any)).called(1);
verifyNever(mockService.method(any));
verifyInOrder([
  mockService.method1(),
  mockService.method2(),
]);
```

## 📋 Test Checklist

### Before Writing Tests
- [ ] Understand the component's behavior
- [ ] Identify critical paths and edge cases
- [ ] Plan test scenarios and expected outcomes
- [ ] Set up proper mocks and test data

### While Writing Tests
- [ ] Follow AAA pattern (Arrange, Act, Assert)
- [ ] Use descriptive test names
- [ ] Keep tests focused and isolated
- [ ] Use proper assertions and matchers

### After Writing Tests
- [ ] Run tests locally
- [ ] Check coverage reports
- [ ] Review test readability
- [ ] Update documentation if needed

## 🎯 Best Practices Summary

### Do's
- ✅ Write tests first (TDD approach)
- ✅ Use descriptive test names
- ✅ Keep tests simple and focused
- ✅ Mock external dependencies
- ✅ Test error scenarios
- ✅ Use proper assertions
- ✅ Maintain test data factories

### Don'ts
- ❌ Test implementation details
- ❌ Write flaky tests
- ❌ Skip error scenarios
- ❌ Use hardcoded test data
- ❌ Test multiple things in one test
- ❌ Ignore test failures

This testing strategy ensures high code quality, reliability, and maintainability of the Flutter application. 