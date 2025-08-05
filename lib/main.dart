import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/task/task_bloc.dart';
import 'blocs/theme/theme_bloc.dart';
import 'router/app_router.dart';
import 'core/services/logger_service.dart';
import 'core/services/network_service.dart';
import 'core/services/theme_service.dart';
import 'services/api_service.dart';
import 'services/auth_service.dart';
import 'repositories/task_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize services
  await _initializeServices();
  
  runApp(const MyApp());
}

Future<void> _initializeServices() async {
  logger.info('Starting application initialization');
  
  // Initialize core services
  await NetworkService().initialize();
  await ThemeService().initialize();
  
  // Initialize API service
  await ApiService().initialize();
  
  // Initialize repositories
  await TaskRepository().initialize();
  
  logger.info('Application initialization completed');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(authService: AuthService())..add(AuthInitialized()),
        ),
        BlocProvider<TaskBloc>(
          create: (context) => TaskBloc(taskRepository: TaskRepository())..add(const TaskEvent.initialized()),
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc()..add(ThemeInitialized()),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'todo-flt',
            theme: state is ThemeLoaded ? state.lightTheme : ThemeData.light(),
            darkTheme: state is ThemeLoaded ? state.darkTheme : ThemeData.dark(),
            themeMode: state is ThemeLoaded ? state.themeMode : ThemeMode.system,
            routerConfig: AppRouter.router,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
