import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/task/task_bloc.dart';
import 'blocs/theme/theme_bloc.dart';
import 'core/services/logger_service.dart';
import 'core/services/network_service.dart';
import 'core/services/theme_service.dart';
import 'repositories/task_repository.dart';
import 'services/auth_service.dart';
import 'router/app_router.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize services
  await _initializeServices();
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  
  runApp(const MyApp());
}

/// Initialize all services
Future<void> _initializeServices() async {
  try {
    // Initialize logger
    logger.initialize();
    logger.info('Starting application initialization');
    
    // Initialize network service
    await NetworkService().initialize();
    
    // Initialize theme service
    await ThemeService().initialize();
    
    logger.info('Application initialization completed');
  } catch (e, stackTrace) {
    logger.error('Failed to initialize services', e, stackTrace);
    rethrow;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            authService: AuthService(),
          )..add(AuthInitialized()),
        ),
        BlocProvider<TaskBloc>(
          create: (context) => TaskBloc(
            taskRepository: TaskRepository(),
          )..add(const TaskEvent.initialized()),
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc()..add(ThemeInitialized()),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp.router(
            title: 'todo-flt',
            theme: ThemeService().getLightTheme(),
            darkTheme: ThemeService().getDarkTheme(),
            themeMode: themeState is ThemeLoaded ? themeState.themeMode : ThemeMode.system,
            routerConfig: AppRouter.router,
            debugShowCheckedModeBanner: false,
            // Performance optimizations
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: MediaQuery.of(context).textScaler.clamp(
                    minScaleFactor: 0.8,
                    maxScaleFactor: 1.2,
                  ),
                ),
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
