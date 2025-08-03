import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/auth/auth_bloc.dart';
import '../screens/main_screen.dart';
import '../screens/login_screen_bloc.dart';
import '../screens/feedback_screen.dart';
import '../screens/task_detail_screen.dart';

// Simple refresh notifier for GoRouter
class RouterRefreshNotifier extends ChangeNotifier {
  void refresh() => notifyListeners();
}

class AppRouter {
  static final RouterRefreshNotifier refreshNotifier = RouterRefreshNotifier();
  
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    refreshListenable: refreshNotifier,
    redirect: (BuildContext context, GoRouterState state) {
      final authBloc = context.read<AuthBloc>();
      final authState = authBloc.state;
      
      // Debug logging
      print('Router redirect - Current location: ${state.matchedLocation}');
      print('Router redirect - Auth state: ${authState.runtimeType}');
      
      // If we're loading or in initial state, don't redirect
      if (authState is AuthLoading || authState is AuthInitial) {
        print('Router redirect - Auth loading/initial, staying on current route');
        return null;
      }
      
      // If we're authenticated and trying to access login, redirect to home
      if (authState is AuthAuthenticated && state.matchedLocation == '/login') {
        print('Router redirect - Authenticated user on login, redirecting to home');
        return '/home';
      }
      
      // If we're not authenticated and trying to access protected routes, redirect to login
      if (authState is AuthUnauthenticated && 
          (state.matchedLocation == '/home' || 
           state.matchedLocation == '/feedback' ||
           state.matchedLocation.startsWith('/task/'))) {
        print('Router redirect - Unauthenticated user on protected route, redirecting to login');
        return '/login';
      }
      
      // If we're on the root path and authenticated, redirect to home
      if (authState is AuthAuthenticated && state.matchedLocation == '/') {
        print('Router redirect - Authenticated user on root, redirecting to home');
        return '/home';
      }
      
      // If we're on the root path and not authenticated, redirect to login
      if (authState is AuthUnauthenticated && state.matchedLocation == '/') {
        print('Router redirect - Unauthenticated user on root, redirecting to login');
        return '/login';
      }
      
      // If we're not authenticated and on login page, stay there
      if (authState is AuthUnauthenticated && state.matchedLocation == '/login') {
        print('Router redirect - Unauthenticated user on login, staying');
        return null;
      }
      
      // If we're authenticated and on any route other than home, feedback, or task detail, redirect to home
      if (authState is AuthAuthenticated && 
          state.matchedLocation != '/home' && 
          state.matchedLocation != '/feedback' &&
          !state.matchedLocation.startsWith('/task/')) {
        print('Router redirect - Authenticated user on non-home route, redirecting to home');
        return '/home';
      }
      
      // If we're not authenticated and not on login, go to login
      if (authState is AuthUnauthenticated && state.matchedLocation != '/login') {
        print('Router redirect - Unauthenticated user on non-login route, redirecting to login');
        return '/login';
      }
      
      print('Router redirect - No redirect needed');
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        name: 'root',
        builder: (context, state) {
          // Show a loading screen for the root route
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  const Text('Loading...'),
                ],
              ),
            ),
          );
        },
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreenBloc(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: '/feedback',
        name: 'feedback',
        builder: (context, state) => const FeedbackScreen(),
      ),
      GoRoute(
        path: '/task/:id',
        name: 'task-detail',
        builder: (context, state) {
          final taskId = state.pathParameters['id']!;
          return TaskDetailScreen(taskId: taskId);
        },
      ),
    ],
    errorBuilder: (context, state) {
      print('Router error - Location: ${state.matchedLocation}');
      print('Router error - Error: ${state.error}');
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                'Page not found',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'The page you are looking for does not exist.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.go('/home'),
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      );
    },
  );
} 