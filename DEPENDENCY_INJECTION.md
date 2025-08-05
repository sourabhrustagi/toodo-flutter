# Dependency Injection with GetIt

## 🎯 Overview

The Todo Flutter app now uses **GetIt** as the primary dependency injection container, which is one of the most popular and robust DI libraries for Flutter. This provides a clean, type-safe, and efficient way to manage dependencies throughout the application.

## 🏗️ Architecture

### GetIt Container
GetIt is a simple service locator that provides:
- **Type-safe dependency resolution**
- **Lazy singleton pattern**
- **Factory pattern support**
- **Scoped dependencies**
- **Easy testing with dependency replacement**

### Key Components

1. **GetIt Instance**: Global service locator
2. **Injectable**: Code generation for automatic DI setup
3. **Service Registration**: Manual and automatic registration
4. **Dependency Resolution**: Type-safe service retrieval

## ⚙️ Configuration

### Core Setup

```dart
// Global GetIt instance
final GetIt getIt = GetIt.instance;

// Initialize dependencies
await configureDependencies();
```

### Service Registration

#### Lazy Singleton (Recommended)
```dart
getIt.registerLazySingleton<LoggerService>(() => LoggerService());
```

#### Singleton
```dart
getIt.registerSingleton<NetworkService>(NetworkService());
```

#### Factory
```dart
getIt.registerFactory<TaskBloc>(() => TaskBloc(
  taskRepository: getIt<TaskRepository>(),
));
```

## 📦 Service Modules

### Core Services
```dart
// Logger Service
getIt.registerLazySingleton<LoggerService>(() => LoggerService());

// Network Service
getIt.registerLazySingleton<NetworkService>(() => NetworkService());

// Theme Service
getIt.registerLazySingleton<ThemeService>(() => ThemeService());

// Validation Service
getIt.registerLazySingleton<ValidationService>(() => ValidationService());

// Performance Service
getIt.registerLazySingleton<PerformanceService>(() => PerformanceService());
```

### Data Services
```dart
// Secure Storage Service
getIt.registerLazySingleton<SecureStorageService>(() => SecureStorageService());

// API Service
getIt.registerLazySingleton<ApiService>(() => ApiService());

// Database Helper
getIt.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
```

### Business Logic
```dart
// Auth Service
getIt.registerLazySingleton<AuthService>(() => AuthService());

// Task Repository
getIt.registerLazySingleton<TaskRepository>(() => TaskRepository());
```

### BLoCs
```dart
// Auth BLoC
getIt.registerLazySingleton<AuthBloc>(() => AuthBloc(
  authService: getIt<AuthService>(),
));

// Task BLoC
getIt.registerLazySingleton<TaskBloc>(() => TaskBloc(
  taskRepository: getIt<TaskRepository>(),
));

// Theme BLoC
getIt.registerLazySingleton<ThemeBloc>(() => ThemeBloc());
```

## 🔧 Usage Examples

### Basic Service Retrieval
```dart
// Get service instance
final logger = getIt<LoggerService>();
final apiService = getIt<ApiService>();

// Use service
logger.info('Application started');
await apiService.initialize();
```

### In Widgets
```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get service from DI container
    final authService = getIt<AuthService>();
    final taskRepository = getIt<TaskRepository>();
    
    return Container();
  }
}
```

### Using BuildContext Extension
```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use extension methods
    final authService = context.authService;
    final taskRepository = context.taskRepository;
    final logger = context.loggerService;
    
    return Container();
  }
}
```

### In BLoCs
```dart
class MyBloc extends Bloc<MyEvent, MyState> {
  final AuthService _authService;
  final TaskRepository _taskRepository;

  MyBloc() 
    : _authService = getIt<AuthService>(),
      _taskRepository = getIt<TaskRepository>(),
      super(MyInitial());
}
```

## 🚀 Initialization

### Main App Initialization
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await DIUtils.initialize();

  runApp(const MyApp());
}
```

### DIUtils Class
```dart
class DIUtils {
  /// Initialize all dependencies
  static Future<void> initialize() async {
    // Configure dependencies
    await configureDependencies();
    
    // Initialize services that need async setup
    await _initializeServices();
    
    // Log initialization
    final logger = getIt<LoggerService>();
    logger.info('Dependency injection initialized successfully');
  }

  /// Initialize services that require async setup
  static Future<void> _initializeServices() async {
    final logger = getIt<LoggerService>();
    
    try {
      // Initialize network service
      await getIt<NetworkService>().initialize();
      logger.info('NetworkService initialized');

      // Initialize API service
      await getIt<ApiService>().initialize();
      logger.info('ApiService initialized');

      // Initialize task repository
      await getIt<TaskRepository>().initialize();
      logger.info('TaskRepository initialized');

      // Initialize theme service
      await getIt<ThemeService>().initialize();
      logger.info('ThemeService initialized');

    } catch (e) {
      logger.error('Error initializing services', e);
      rethrow;
    }
  }

  /// Dispose all dependencies
  static Future<void> dispose() async {
    final logger = getIt<LoggerService>();
    logger.info('Disposing dependencies...');

    try {
      // Dispose services
      getIt<ApiService>().dispose();
      await getIt<DatabaseHelper>().close();
      
      // Reset GetIt
      await getIt.reset();
      
      logger.info('Dependencies disposed successfully');
    } catch (e) {
      logger.error('Error disposing dependencies', e);
    }
  }

  /// Reset dependencies (useful for testing)
  static Future<void> reset() async {
    await getIt.reset();
  }
}
```

## 🔍 Service Discovery

### Check if Service is Registered
```dart
if (getIt.isRegistered<AuthService>()) {
  final authService = getIt<AuthService>();
}
```

### Get Service with Type Safety
```dart
T getService<T extends Object>() {
  return getIt<T>();
}
```

### Service Locator Pattern
```dart
class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  /// Get service
  T get<T extends Object>() => getIt<T>();

  /// Check if service is registered
  bool isRegistered<T extends Object>() => getIt.isRegistered<T>();

  /// Register singleton
  void registerSingleton<T extends Object>(T instance) {
    getIt.registerSingleton<T>(instance);
  }

  /// Register factory
  void registerFactory<T extends Object>(T Function() factory) {
    getIt.registerFactory<T>(factory);
  }

  /// Register lazy singleton
  void registerLazySingleton<T extends Object>(T Function() factory) {
    getIt.registerLazySingleton<T>(factory);
  }

  /// Reset all registrations
  Future<void> reset() async => await getIt.reset();
}
```

## 🧪 Testing

### Mock Dependencies
```dart
void setUp() {
  // Register mock services
  getIt.registerLazySingleton<AuthService>(() => MockAuthService());
  getIt.registerLazySingleton<TaskRepository>(() => MockTaskRepository());
}

void tearDown() async {
  // Reset all registrations
  await getIt.reset();
}
```

### Test BLoC with DI
```dart
test('auth bloc should emit authenticated state', () async {
  // Arrange
  getIt.registerLazySingleton<AuthService>(() => MockAuthService());
  final authBloc = getIt<AuthBloc>();

  // Act
  authBloc.add(AuthInitialized());

  // Assert
  await expectLater(
    authBloc.stream,
    emitsInOrder([
      isA<AuthLoading>(),
      isA<AuthAuthenticated>(),
    ]),
  );
});
```

### Integration Testing
```dart
testWidgets('app should initialize with DI', (tester) async {
  // Arrange
  await DIUtils.initialize();

  // Act
  await tester.pumpWidget(const MyApp());

  // Assert
  expect(find.byType(MaterialApp), findsOneWidget);
});
```

## 🔄 Environment Configuration

### Environment-Specific DI
```dart
enum Environment {
  mock,
  development,
  production,
}

Future<void> configureDependenciesForEnvironment(Environment environment) async {
  switch (environment) {
    case Environment.mock:
      // Register mock services
      getIt.registerLazySingleton<ApiService>(() => MockApiService());
      break;
    case Environment.development:
      // Register development services
      getIt.registerLazySingleton<ApiService>(() => DevApiService());
      break;
    case Environment.production:
      // Register production services
      getIt.registerLazySingleton<ApiService>(() => ProdApiService());
      break;
  }
}
```

## 📊 Performance Benefits

### Lazy Loading
- Services are created only when first accessed
- Reduces initial app startup time
- Memory efficient

### Singleton Pattern
- Single instance per service
- Consistent state across app
- Memory efficient

### Type Safety
- Compile-time dependency checking
- IDE autocomplete support
- Reduced runtime errors

## 🔧 Advanced Features

### Scoped Dependencies
```dart
// Register scoped dependency
getIt.registerLazySingleton<ScopedService>(
  () => ScopedService(),
  instanceName: 'scope1',
);

// Get scoped dependency
final scopedService = getIt<ScopedService>(instanceName: 'scope1');
```

### Async Dependencies
```dart
// Register async dependency
getIt.registerSingletonAsync<Database>(
  () async {
    final db = await openDatabase('path');
    return db;
  },
);

// Get async dependency
final db = await getIt.getAsync<Database>();
```

### Parameter Injection
```dart
// Register factory with parameters
getIt.registerFactoryParam<TaskBloc, String, void>(
  (param1, param2) => TaskBloc(userId: param1),
);

// Get with parameters
final taskBloc = getIt<TaskBloc>(param1: 'user123');
```

## 📋 Best Practices

### Do's
- ✅ Use lazy singletons for most services
- ✅ Register dependencies in a centralized location
- ✅ Use type-safe service retrieval
- ✅ Dispose resources properly
- ✅ Use dependency injection for testing

### Don'ts
- ❌ Don't create circular dependencies
- ❌ Don't register services in widgets
- ❌ Don't forget to dispose resources
- ❌ Don't use global variables instead of DI

## 🎯 Benefits

### Developer Experience
- **Type Safety**: Compile-time dependency checking
- **IDE Support**: Autocomplete and refactoring
- **Testing**: Easy mock injection
- **Maintainability**: Centralized dependency management

### Performance
- **Lazy Loading**: Services created on demand
- **Memory Efficiency**: Singleton pattern
- **Fast Resolution**: O(1) service lookup
- **Minimal Overhead**: Lightweight implementation

### Architecture
- **Clean Architecture**: Proper separation of concerns
- **SOLID Principles**: Dependency inversion
- **Testability**: Easy unit and integration testing
- **Scalability**: Easy to add new services

## 🔄 Migration from Custom DI

### Before (Custom AppDependencies)
```dart
class AppDependencies {
  late final AuthService authService;
  late final TaskRepository taskRepository;
  
  Future<void> initialize() async {
    authService = AuthService();
    taskRepository = TaskRepository();
  }
}

// Usage
final deps = AppDependencies();
await deps.initialize();
final authService = deps.authService;
```

### After (GetIt)
```dart
// Registration
getIt.registerLazySingleton<AuthService>(() => AuthService());
getIt.registerLazySingleton<TaskRepository>(() => TaskRepository());

// Usage
final authService = getIt<AuthService>();
final taskRepository = getIt<TaskRepository>();
```

## 🚀 Getting Started

1. **Add Dependencies**
```yaml
dependencies:
  get_it: ^7.6.7
  injectable: ^2.3.2
```

2. **Initialize DI**
```dart
void main() async {
  await DIUtils.initialize();
  runApp(const MyApp());
}
```

3. **Register Services**
```dart
getIt.registerLazySingleton<MyService>(() => MyService());
```

4. **Use Services**
```dart
final myService = getIt<MyService>();
```

This GetIt implementation provides a robust, type-safe, and efficient dependency injection system that follows Flutter best practices and industry standards. 