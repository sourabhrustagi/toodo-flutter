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
            
            // Notification Settings
            _buildSectionHeader(context, 'Notifications'),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.notifications),
                    title: const Text('Task Reminders'),
                    subtitle: const Text('Get notified about due tasks'),
                    trailing: Switch(
                      value: true, // TODO: Implement notification settings
                      onChanged: (value) {
                        // TODO: Implement notification toggle
                      },
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.schedule),
                    title: const Text('Due Date Alerts'),
                    subtitle: const Text('Remind me before tasks are due'),
                    trailing: Switch(
                      value: true, // TODO: Implement notification settings
                      onChanged: (value) {
                        // TODO: Implement notification toggle
                      },
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.warning),
                    title: const Text('Overdue Notifications'),
                    subtitle: const Text('Alert me about overdue tasks'),
                    trailing: Switch(
                      value: true, // TODO: Implement notification settings
                      onChanged: (value) {
                        // TODO: Implement notification toggle
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Data Management
            _buildSectionHeader(context, 'Data Management'),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.backup),
                    title: const Text('Backup Data'),
                    subtitle: const Text('Export your tasks'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // TODO: Implement data backup
                      _showSnackBar(context, 'Backup feature coming soon!');
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.restore),
                    title: const Text('Restore Data'),
                    subtitle: const Text('Import your tasks'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // TODO: Implement data restore
                      _showSnackBar(context, 'Restore feature coming soon!');
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.delete_forever),
                    title: const Text('Clear All Data'),
                    subtitle: const Text('Delete all tasks and settings'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () => _showClearDataDialog(context),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Privacy & Security
            _buildSectionHeader(context, 'Privacy & Security'),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.security),
                    title: const Text('Privacy Policy'),
                    subtitle: const Text('Read our privacy policy'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // TODO: Open privacy policy
                      _showSnackBar(context, 'Privacy policy coming soon!');
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.description),
                    title: const Text('Terms of Service'),
                    subtitle: const Text('Read our terms of service'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // TODO: Open terms of service
                      _showSnackBar(context, 'Terms of service coming soon!');
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
                    leading: const Icon(Icons.bug_report),
                    title: const Text('Report Bug'),
                    subtitle: const Text('Help us improve the app'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () => context.go('/feedback'),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.star),
                    title: const Text('Rate App'),
                    subtitle: const Text('Rate us on the app store'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // TODO: Open app store rating
                      _showSnackBar(context, 'Rating feature coming soon!');
                    },
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
                    onTap: () {
                      context.read<AuthBloc>().add(AuthLogout());
                    },
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

  void _showClearDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Data'),
        content: const Text(
          'This will permanently delete all your tasks and settings. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<AuthBloc>().add(AuthClearData());
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Clear All Data'),
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
} 