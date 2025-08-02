import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/task/task_bloc.dart';
import '../models/task.dart';
import '../widgets/add_task_dialog.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () => context.go('/settings'),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoaded) {
            return _buildProfileContent(context, state);
          }
          
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, TaskLoaded state) {
    final theme = Theme.of(context);
    final stats = state.statistics;
    final totalTasks = stats['total'] ?? 0;
    final completedTasks = stats['completed'] ?? 0;
    final pendingTasks = stats['pending'] ?? 0;
    final overdueTasks = stats['overdue'] ?? 0;
    final completionRate = totalTasks > 0 ? (completedTasks / totalTasks * 100) : 0.0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: theme.colorScheme.primary,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, authState) {
                      if (authState is AuthAuthenticated) {
                        return Column(
                          children: [
                            Text(
                              'User',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              authState.phoneNumber,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface.withOpacity(0.7),
                              ),
                            ),
                          ],
                        );
                      }
                      return const Text('User');
                    },
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Statistics Section
          Text(
            'Task Statistics',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          // Statistics Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.8,
            children: [
              _buildStatCard(
                context,
                'Total Tasks',
                totalTasks.toString(),
                Icons.list,
                theme.colorScheme.primary,
              ),
              _buildStatCard(
                context,
                'Completed',
                completedTasks.toString(),
                Icons.check_circle,
                Colors.green,
              ),
              _buildStatCard(
                context,
                'Pending',
                pendingTasks.toString(),
                Icons.pending,
                Colors.orange,
              ),
              _buildStatCard(
                context,
                'Overdue',
                overdueTasks.toString(),
                Icons.warning,
                Colors.red,
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Completion Rate
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Completion Rate',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: completionRate / 100,
                    backgroundColor: theme.colorScheme.surfaceVariant,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _getCompletionRateColor(completionRate),
                    ),
                    minHeight: 8,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${completionRate.toStringAsFixed(1)}%',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: _getCompletionRateColor(completionRate),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Achievements Section
          Text(
            'Achievements',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildAchievementsSection(context, state),
          
          const SizedBox(height: 24),
          
          // Recent Activity
          Text(
            'Recent Activity',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildRecentActivitySection(context, state),
          
          const SizedBox(height: 24),
          
          // Quick Actions
          Text(
            'Quick Actions',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildQuickActionsSection(context),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon, Color color) {
    final theme = Theme.of(context);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: color,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2),
            Text(
              title,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementsSection(BuildContext context, TaskLoaded state) {
    final theme = Theme.of(context);
    final stats = state.statistics;
    final completedTasks = stats['completed'] ?? 0;
    
    final achievements = [
      {
        'title': 'First Task',
        'description': 'Complete your first task',
        'icon': Icons.star,
        'color': Colors.amber,
        'unlocked': completedTasks >= 1,
      },
      {
        'title': 'Task Master',
        'description': 'Complete 10 tasks',
        'icon': Icons.workspace_premium,
        'color': Colors.blue,
        'unlocked': completedTasks >= 10,
      },
      {
        'title': 'Productivity Pro',
        'description': 'Complete 50 tasks',
        'icon': Icons.emoji_events,
        'color': Colors.purple,
        'unlocked': completedTasks >= 50,
      },
      {
        'title': 'Task Champion',
        'description': 'Complete 100 tasks',
        'icon': Icons.military_tech,
        'color': Colors.red,
        'unlocked': completedTasks >= 100,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.4,
      ),
      itemCount: achievements.length,
      itemBuilder: (context, index) {
        final achievement = achievements[index];
        return Card(
          color: achievement['unlocked'] as bool 
              ? achievement['color'] as Color
              : theme.colorScheme.surfaceVariant,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  achievement['icon'] as IconData,
                  size: 24,
                  color: achievement['unlocked'] as bool 
                      ? Colors.white
                      : theme.colorScheme.onSurface.withOpacity(0.5),
                ),
                const SizedBox(height: 4),
                Text(
                  achievement['title'] as String,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: achievement['unlocked'] as bool 
                        ? Colors.white
                        : theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  achievement['description'] as String,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: achievement['unlocked'] as bool 
                        ? Colors.white.withOpacity(0.8)
                        : theme.colorScheme.onSurface.withOpacity(0.5),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRecentActivitySection(BuildContext context, TaskLoaded state) {
    final theme = Theme.of(context);
    final recentTasks = state.tasks.take(5).toList();

    if (recentTasks.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(
                Icons.history,
                size: 48,
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
              const SizedBox(height: 16),
              Text(
                'No recent activity',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: recentTasks.length,
        itemBuilder: (context, index) {
          final task = recentTasks[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: task.isCompleted 
                  ? Colors.green 
                  : Color(Task.priorityColors[task.priority]!),
              child: Icon(
                task.isCompleted ? Icons.check : Icons.task_alt,
                color: Colors.white,
                size: 20,
              ),
            ),
            title: Text(
              task.title,
              style: TextStyle(
                decoration: task.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Text(
              task.isCompleted ? 'Completed' : 'Created',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            trailing: Text(
              _formatRelativeTime(task.updatedAt),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildQuickActionsSection(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Add New Task'),
            onTap: () {
              Navigator.of(context).pop();
              showDialog(
                context: context,
                builder: (context) => const AddTaskDialog(),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => context.go('/settings'),
          ),
          ListTile(
            leading: const Icon(Icons.feedback),
            title: const Text('Feedback'),
            onTap: () => context.go('/feedback'),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              context.read<AuthBloc>().add(AuthLogout());
            },
          ),
        ],
      ),
    );
  }

  Color _getCompletionRateColor(double rate) {
    if (rate >= 80) return Colors.green;
    if (rate >= 60) return Colors.orange;
    if (rate >= 40) return Colors.yellow;
    return Colors.red;
  }

  String _formatRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
} 