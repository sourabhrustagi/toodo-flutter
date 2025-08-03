import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/theme/theme_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Theme Settings
            _buildSectionHeader(context, 'Appearance'),
            Card(
              child: Column(
                children: [
                  BlocBuilder<ThemeBloc, ThemeState>(
                    builder: (context, state) {
                      if (state is ThemeLoaded) {
                        return Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.palette),
                              title: const Text('Theme Mode'),
                              subtitle: Text(_getThemeModeText(state.themeMode)),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () => _showThemeDialog(context),
                            ),
                            const Divider(),
                            ListTile(
                              leading: const Icon(Icons.brightness_6),
                              title: const Text('Auto Theme'),
                              subtitle: const Text('Follow system theme'),
                              trailing: Switch(
                                value: state.themeMode == ThemeMode.system,
                                onChanged: (value) {
                                  if (value) {
                                    context.read<ThemeBloc>().add(
                                      const ThemeChanged(ThemeMode.system),
                                    );
                                  } else {
                                    context.read<ThemeBloc>().add(
                                      const ThemeChanged(ThemeMode.light),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        );
                      }
                      return const ListTile(
                        leading: Icon(Icons.palette),
                        title: Text('Theme Mode'),
                        subtitle: Text('Loading...'),
                      );
                    },
                  ),
                ],
              ),
            ),
            

            
            const SizedBox(height: 24),
            
            // About Section
            _buildSectionHeader(context, 'About'),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text('App Version'),
                    subtitle: const Text('1.0.0'),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.feedback),
                    title: const Text('Feedback'),
                    subtitle: const Text('Share your thoughts with us'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () => context.go('/feedback'),
                  ),


                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Account Actions
            _buildSectionHeader(context, 'Account'),
            Card(
              child: Column(
                children: [
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthAuthenticated) {
                        return ListTile(
                          leading: const Icon(Icons.person),
                          title: const Text('Phone Number'),
                          subtitle: Text(state.phoneNumber),
                        );
                      }
                      return const ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Not logged in'),
                        subtitle: Text('Please log in to view account details'),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    subtitle: const Text('Sign out of your account'),
                    onTap: () => _showLogoutBottomSheet(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }

  String _getThemeModeText(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.wb_sunny),
              title: const Text('Light'),
              onTap: () {
                context.read<ThemeBloc>().add(const ThemeChanged(ThemeMode.light));
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.nightlight),
              title: const Text('Dark'),
              onTap: () {
                context.read<ThemeBloc>().add(const ThemeChanged(ThemeMode.dark));
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_system_daydream),
              title: const Text('System'),
              onTap: () {
                context.read<ThemeBloc>().add(const ThemeChanged(ThemeMode.system));
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }



  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showLogoutBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              
              // Icon
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.logout,
                  color: Colors.red,
                  size: 30,
                ),
              ),
              const SizedBox(height: 16),
              
              // Title
              Text(
                'Logout',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              
              // Message
              Text(
                'Are you sure you want to logout?',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              
              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(AuthLogout());
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Logout'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
} 