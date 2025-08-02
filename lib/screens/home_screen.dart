import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/task/task_bloc.dart';
import '../models/task.dart';
import '../repositories/task_repository.dart';
import '../widgets/task_card.dart';
import '../widgets/add_task_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RefreshController _refreshController = RefreshController();
  final TextEditingController _searchController = TextEditingController();
  
  List<String> _selectedTaskIds = [];
  bool _isSelectionMode = false;

  @override
  void dispose() {
    _refreshController.dispose();
    _searchController.dispose();
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
            // Search button
            IconButton(
              onPressed: () => _showSearchDialog(context),
              icon: const Icon(Icons.search),
            ),
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
            // Feedback button
            IconButton(
              onPressed: () => context.go('/feedback'),
              icon: const Icon(Icons.feedback),
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
          // Search bar
          if (!_isSelectionMode) ...[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search tasks...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      context.read<TaskBloc>().add(const TaskSearched(''));
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  context.read<TaskBloc>().add(TaskSearched(value));
                },
              ),
            ),
          ],
          
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
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is TaskLoaded) {
                  final tasks = state.filteredTasks;
                  
                  if (tasks.isEmpty) {
                    return _buildEmptyState(context, state);
                  }

                  return SmartRefresher(
                    controller: _refreshController,
                    onRefresh: () async {
                      context.read<TaskBloc>().add(TaskRefresh());
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
                            context.read<TaskBloc>().add(TaskInitialized());
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                return const Center(child: CircularProgressIndicator());
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
            color: Color(Task.priorityColors[task.priority]!).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            task.priority.name.toUpperCase(),
            style: TextStyle(
              color: Color(Task.priorityColors[task.priority]!),
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

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Tasks'),
        content: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Enter search terms...',
            prefixIcon: Icon(Icons.search),
          ),
          autofocus: true,
          onChanged: (value) {
            context.read<TaskBloc>().add(TaskSearched(value));
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Search'),
          ),
        ],
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
                context.read<TaskBloc>().add(const TaskFilterChanged(TaskFilter.all));
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Active Tasks'),
              leading: const Icon(Icons.pending),
              onTap: () {
                context.read<TaskBloc>().add(const TaskFilterChanged(TaskFilter.active));
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Completed Tasks'),
              leading: const Icon(Icons.check_circle),
              onTap: () {
                context.read<TaskBloc>().add(const TaskFilterChanged(TaskFilter.completed));
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
                context.read<TaskBloc>().add(const TaskSortChanged(TaskSortOption.priority));
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Due Date'),
              leading: const Icon(Icons.schedule),
              onTap: () {
                context.read<TaskBloc>().add(const TaskSortChanged(TaskSortOption.dueDate));
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Creation Date'),
              leading: const Icon(Icons.create),
              onTap: () {
                context.read<TaskBloc>().add(const TaskSortChanged(TaskSortOption.creationDate));
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Alphabetical'),
              leading: const Icon(Icons.sort_by_alpha),
              onTap: () {
                context.read<TaskBloc>().add(const TaskSortChanged(TaskSortOption.alphabetical));
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
              context.read<TaskBloc>().add(TaskDeleted(task.id));
              Navigator.of(context).pop();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _toggleTask(String taskId) {
    context.read<TaskBloc>().add(TaskToggled(taskId));
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
      context.read<TaskBloc>().add(TaskBulkToggle(
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
                context.read<TaskBloc>().add(TaskBulkDelete(_selectedTaskIds));
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
      context.read<TaskBloc>().add(TaskBulkUpdatePriority(
        taskIds: _selectedTaskIds,
        priority: priority,
      ));
      _clearSelection();
    }
  }
} 