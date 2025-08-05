import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants/app_constants.dart';
import '../services/logger_service.dart';
import '../services/network_service.dart';
import '../services/retry_interceptor.dart';
import '../services/theme_service.dart';
import '../services/validation_service.dart';
import '../services/performance_service.dart';
import '../../services/secure_storage_service.dart';
import '../../services/api_service.dart';
import '../../services/auth_service.dart';
import '../../data/database_helper.dart';
import '../../repositories/task_repository.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/task/task_bloc.dart';
import '../../blocs/theme/theme_bloc.dart';

/// Global GetIt instance for dependency injection
final GetIt getIt = GetIt.instance;

/// Injectable configuration for dependency injection
@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
Future<void> configureDependencies() async {
  // Manual configuration since we're not using code generation yet
  await _configureDependencies();
}

/// Manual dependency configuration
Future<void> _configureDependencies() async {
  // Register core services
  getIt.registerLazySingleton<LoggerService>(() => LoggerService());
  getIt.registerLazySingleton<NetworkService>(() => NetworkService());
  getIt.registerLazySingleton<ThemeService>(() => ThemeService());
  getIt.registerLazySingleton<ValidationService>(() => ValidationService());
  getIt.registerLazySingleton<PerformanceService>(() => PerformanceService());
  getIt.registerLazySingleton<SecureStorageService>(() => SecureStorageService());
  getIt.registerLazySingleton<ApiService>(() => ApiService());
  getIt.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<TaskRepository>(() => TaskRepository());

  // Register BLoCs with dependencies
  getIt.registerLazySingleton<AuthBloc>(() => AuthBloc(
    authService: getIt<AuthService>(),
  ));
  getIt.registerLazySingleton<TaskBloc>(() => TaskBloc(
    taskRepository: getIt<TaskRepository>(),
  ));
  getIt.registerLazySingleton<ThemeBloc>(() => ThemeBloc());
}

/// Core services module
@module
abstract class CoreModule {
  /// Dio HTTP client
  @lazySingleton
  Dio get dio => Dio(BaseOptions(
    baseUrl: AppConstants.baseUrl,
    connectTimeout: AppConstants.apiTimeout,
    receiveTimeout: AppConstants.apiTimeout,
    sendTimeout: AppConstants.apiTimeout,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  /// Connectivity instance
  @lazySingleton
  Connectivity get connectivity => Connectivity();

  /// Shared preferences instance
  @preResolve
  Future<SharedPreferences> get sharedPreferences => SharedPreferences.getInstance();

  /// Secure storage instance
  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  /// Database instance
  @preResolve
  Future<Database> get database async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'todo_app.db');
    
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tasks(
            id TEXT PRIMARY KEY,
            title TEXT NOT NULL,
            description TEXT,
            priority TEXT NOT NULL,
            category TEXT NOT NULL,
            dueDate TEXT,
            isCompleted INTEGER NOT NULL DEFAULT 0,
            createdAt TEXT NOT NULL,
            updatedAt TEXT NOT NULL
          )
        ''');
      },
    );
  }
}

/// Service layer module
@module
abstract class ServiceModule {
  /// Logger service
  @lazySingleton
  LoggerService get loggerService => LoggerService();

  /// Network service
  @lazySingleton
  NetworkService get networkService => NetworkService();

  /// Theme service
  @lazySingleton
  ThemeService get themeService => ThemeService();

  /// Validation service
  @lazySingleton
  ValidationService get validationService => ValidationService();

  /// Performance service
  @lazySingleton
  PerformanceService get performanceService => PerformanceService();

  /// Secure storage service
  @lazySingleton
  SecureStorageService get secureStorageService => SecureStorageService();

  /// API service
  @lazySingleton
  ApiService get apiService => ApiService();

  /// Database helper
  @lazySingleton
  DatabaseHelper get databaseHelper => DatabaseHelper();

  /// Auth service
  @lazySingleton
  AuthService get authService => AuthService();

  /// Task repository
  @lazySingleton
  TaskRepository get taskRepository => TaskRepository();
}

/// BLoC layer module
@module
abstract class BlocModule {
  /// Auth BLoC
  @lazySingleton
  AuthBloc get authBloc => AuthBloc(
    authService: getIt<AuthService>(),
  );

  /// Task BLoC
  @lazySingleton
  TaskBloc get taskBloc => TaskBloc(
    taskRepository: getIt<TaskRepository>(),
  );

  /// Theme BLoC
  @lazySingleton
  ThemeBloc get themeBloc => ThemeBloc();
}

/// Repository layer module
@module
abstract class RepositoryModule {
  /// Task repository
  @lazySingleton
  TaskRepository get taskRepository => TaskRepository();
}

/// ViewModel layer module
@module
abstract class ViewModelModule {
  // Add view models here if needed
}

/// Utility functions for DI
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

      // Database helper doesn't need explicit initialization
      logger.info('DatabaseHelper ready');

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

  /// Get service with type safety
  static T getService<T extends Object>() {
    return getIt<T>();
  }

  /// Check if service is registered
  static bool isRegistered<T extends Object>() {
    return getIt.isRegistered<T>();
  }

  /// Register singleton
  static void registerSingleton<T extends Object>(T instance) {
    getIt.registerSingleton<T>(instance);
  }

  /// Register factory
  static void registerFactory<T extends Object>(T Function() factory) {
    getIt.registerFactory<T>(factory);
  }

  /// Register lazy singleton
  static void registerLazySingleton<T extends Object>(T Function() factory) {
    getIt.registerLazySingleton<T>(factory);
  }
}

/// Extension for BuildContext to access DI
extension DIExtension on BuildContext {
  /// Get service from DI container
  T getService<T extends Object>() => getIt<T>();
  
  /// Get auth service
  AuthService get authService => getIt<AuthService>();
  
  /// Get task repository
  TaskRepository get taskRepository => getIt<TaskRepository>();
  
  /// Get API service
  ApiService get apiService => getIt<ApiService>();
  
  /// Get network service
  NetworkService get networkService => getIt<NetworkService>();
  
  /// Get logger service
  LoggerService get loggerService => getIt<LoggerService>();
  
  /// Get theme service
  ThemeService get themeService => getIt<ThemeService>();
  
  /// Get secure storage service
  SecureStorageService get secureStorageService => getIt<SecureStorageService>();
  
  /// Get database helper
  DatabaseHelper get databaseHelper => getIt<DatabaseHelper>();
  
  /// Get validation service
  ValidationService get validationService => getIt<ValidationService>();
  
  /// Get performance service
  PerformanceService get performanceService => getIt<PerformanceService>();
}

/// Environment configuration for DI
enum Environment {
  mock,
  development,
  production,
}

/// Injectable configuration for different environments
@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependenciesForEnvironment(Environment environment) async {
  switch (environment) {
    case Environment.mock:
      await configureDependencies();
      break;
    case Environment.development:
      await configureDependencies();
      break;
    case Environment.production:
      await configureDependencies();
      break;
  }
}

/// Service locator pattern wrapper
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