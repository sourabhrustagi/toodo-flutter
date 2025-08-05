import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'core/di/injection.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/task/task_bloc.dart';
import 'blocs/theme/theme_bloc.dart';
import 'router/app_router.dart';
import 'core/services/logger_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await DIUtils.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => getIt<AuthBloc>()..add(AuthInitialized()),
        ),
        BlocProvider<TaskBloc>(
          create: (context) => getIt<TaskBloc>()..add(const TaskEvent.initialized()),
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => getIt<ThemeBloc>()..add(ThemeInitialized()),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Todo App',
            debugShowCheckedModeBanner: false,
            theme: state is ThemeLoaded ? state.lightTheme : ThemeData.light(),
            darkTheme: state is ThemeLoaded ? state.darkTheme : ThemeData.dark(),
            themeMode: state is ThemeLoaded ? state.themeMode : ThemeMode.system,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
