import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:lottie/lottie.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/task/task_bloc.dart';
import '../models/task.dart';
import '../repositories/task_repository.dart';
import '../widgets/task_card.dart';
import '../widgets/add_task_dialog.dart';
import '../widgets/shimmer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RefreshController _refreshController = RefreshController();
  
  List<String> _selectedTaskIds = [];
  bool _isSelectionMode = false;

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: _isSelectionMode 
            ? Text('${_selectedTaskIds.length} selected')
            : const Text('My Tasks'),
        actions: [
          if (!_isSelectionMode) ...[
            // Filter button
            IconButton(
              onPressed: () => _showFilterDialog(context),
              icon: const Icon(Icons.filter_list),
            ),
            // Sort button
            IconButton(
              onPressed: () => _showSortDialog(context),
              icon: const Icon(Icons.sort),
            ),
            // Message button
            IconButton(
              onPressed: () => _showMessageDialog(context),
              icon: const Icon(Icons.message),
            ),
            // Exclamation button
            IconButton(
              onPressed: () => _showExclamationDialog(context),
              icon: const Icon(Icons.error_outline),
            ),
          ] else ...[
            // Selection mode actions
            IconButton(
              onPressed: _selectAllTasks,
              icon: const Icon(Icons.select_all),
            ),
            IconButton(
              onPressed: _clearSelection,
              icon: const Icon(Icons.clear),
            ),
          ],
        ],
      ),
      body: Column(
        children: [

          
          // Bulk actions bar
          if (_isSelectionMode) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: theme.colorScheme.primaryContainer,
              child: Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildBulkActionButton(
                            'Complete',
                            Icons.check,
                            theme.colorScheme.primary,
                            () => _bulkToggleTasks(true),
                          ),
                          const SizedBox(width: 8),
                          _buildBulkActionButton(
                            'Delete',
                            Icons.delete,
                            Colors.red,
                            _bulkDeleteTasks,
                          ),
                          const SizedBox(width: 8),
                          _buildBulkActionButton(
                            'High Priority',
                            Icons.priority_high,
                            Colors.red,
                            () => _bulkUpdatePriority(TaskPriority.high),
                          ),
                          const SizedBox(width: 8),
                          _buildBulkActionButton(
                            'Medium Priority',
                            Icons.remove,
                            Colors.orange,
                            () => _bulkUpdatePriority(TaskPriority.medium),
                          ),
                          const SizedBox(width: 8),
                          _buildBulkActionButton(
                            'Low Priority',
                            Icons.keyboard_arrow_down,
                            Colors.green,
                            () => _bulkUpdatePriority(TaskPriority.low),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Task list
          Expanded(
            child: BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state is TaskLoading) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 16),
                        Text(
                          'Loading tasks...',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                if (state is TaskLoaded) {
                  final tasks = state.filteredTasks;
                  
                  if (tasks.isEmpty) {
                    return _buildEmptyState(context, state);
                  }

                  return SmartRefresher(
                    controller: _refreshController,
                    onRefresh: () async {
                      context.read<TaskBloc>().add(const TaskEvent.refresh());
                      _refreshController.refreshCompleted();
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        final isSelected = _selectedTaskIds.contains(task.id);
                        
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: _isSelectionMode
                              ? _buildSelectableTaskCard(task, isSelected)
                              : TaskCard(
                                  task: task,
                                  onToggle: () => _toggleTask(task.id),
                                  onEdit: () => _showEditTaskDialog(context, task),
                                  onDelete: () => _showDeleteConfirmation(context, task),
                                ),
                        );
                      },
                    ),
                  );
                }

                if (state is TaskError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error loading tasks',
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(state.message),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<TaskBloc>().add(const TaskEvent.initialized());
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                return const TaskListShimmer(itemCount: 8);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: _isSelectionMode ? null : FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, TaskLoaded state) {
    final theme = Theme.of(context);
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.task_alt,
            size: 64,
            color: theme.colorScheme.onSurface.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No tasks found',
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            state.searchQuery.isNotEmpty 
                ? 'Try adjusting your search terms'
                : 'Add a new task to get started',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _showAddTaskDialog(context),
            child: const Text('Add Task'),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectableTaskCard(Task task, bool isSelected) {
    return Card(
      child: ListTile(
        leading: Checkbox(
          value: isSelected,
          onChanged: (value) {
            setState(() {
              if (value == true) {
                _selectedTaskIds.add(task.id);
              } else {
                _selectedTaskIds.remove(task.id);
              }
            });
          },
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(task.description),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Color(TaskX.priorityColors[task.priority]!).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            task.priority.name.toUpperCase(),
            style: TextStyle(
              color: Color(TaskX.priorityColors[task.priority]!),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBulkActionButton(String label, IconData icon, Color color, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }



  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Tasks'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('All Tasks'),
              leading: const Icon(Icons.list),
              onTap: () {
                context.read<TaskBloc>().add(const TaskEvent.filterChanged(TaskFilter.all));
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Active Tasks'),
              leading: const Icon(Icons.pending),
              onTap: () {
                context.read<TaskBloc>().add(const TaskEvent.filterChanged(TaskFilter.active));
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Completed Tasks'),
              leading: const Icon(Icons.check_circle),
              onTap: () {
                context.read<TaskBloc>().add(const TaskEvent.filterChanged(TaskFilter.completed));
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

  void _showSortDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sort Tasks'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Priority'),
              leading: const Icon(Icons.priority_high),
              onTap: () {
                context.read<TaskBloc>().add(TaskEvent.sortChanged(TaskSortOption.priority));
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Due Date'),
              leading: const Icon(Icons.schedule),
              onTap: () {
                context.read<TaskBloc>().add(TaskEvent.sortChanged(TaskSortOption.dueDate));
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Creation Date'),
              leading: const Icon(Icons.create),
              onTap: () {
                context.read<TaskBloc>().add(TaskEvent.sortChanged(TaskSortOption.creationDate));
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Alphabetical'),
              leading: const Icon(Icons.sort_by_alpha),
              onTap: () {
                context.read<TaskBloc>().add(TaskEvent.sortChanged(TaskSortOption.title));
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

  void _showMessageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Messages'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('No new messages'),
              leading: Icon(Icons.message),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showExclamationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notifications'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('No urgent notifications'),
              leading: Icon(Icons.error_outline),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AddTaskDialog(),
    );
  }

  void _showEditTaskDialog(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (context) => AddTaskDialog(task: task),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: Text('Are you sure you want to delete "${task.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<TaskBloc>().add(TaskEvent.deleted(task.id));
              Navigator.of(context).pop();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _toggleTask(String taskId) {
    context.read<TaskBloc>().add(TaskEvent.toggled(taskId));
  }

  void _selectAllTasks() {
    final state = context.read<TaskBloc>().state;
    if (state is TaskLoaded) {
      setState(() {
        _selectedTaskIds = state.filteredTasks.map((task) => task.id).toList();
      });
    }
  }

  void _clearSelection() {
    setState(() {
      _selectedTaskIds.clear();
      _isSelectionMode = false;
    });
  }

  void _bulkToggleTasks(bool isCompleted) {
    if (_selectedTaskIds.isNotEmpty) {
      context.read<TaskBloc>().add(TaskEvent.bulkToggle(
        taskIds: _selectedTaskIds,
        isCompleted: isCompleted,
      ));
      _clearSelection();
    }
  }

  void _bulkDeleteTasks() {
    if (_selectedTaskIds.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete Tasks'),
          content: Text('Are you sure you want to delete ${_selectedTaskIds.length} tasks?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<TaskBloc>().add(TaskEvent.bulkDelete(_selectedTaskIds));
                Navigator.of(context).pop();
                _clearSelection();
              },
              child: const Text('Delete'),
            ),
          ],
        ),
      );
    }
  }

  void _bulkUpdatePriority(TaskPriority priority) {
    if (_selectedTaskIds.isNotEmpty) {
      context.read<TaskBloc>().add(TaskEvent.bulkUpdatePriority(
        taskIds: _selectedTaskIds,
        priority: priority,
      ));
      _clearSelection();
    }
  }
} 