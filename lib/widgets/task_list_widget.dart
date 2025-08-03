import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/task/task_bloc.dart';
import '../models/task.dart';
import '../core/widgets/common_widgets.dart';
import '../core/widgets/responsive_widgets.dart';
import '../core/utils/responsive_utils.dart';

/// Example widget demonstrating Freezed usage with BLoC
class TaskListWidget extends StatelessWidget {
  const TaskListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => CommonWidgets.loadingIndicator(message: 'Loading tasks...'),
          loaded: (tasks, filteredTasks, currentFilter, currentSort, selectedPriority, 
                   selectedCategory, selectedDueDateFilter, searchQuery, categories, statistics) {
            if (filteredTasks.isEmpty) {
              return CommonWidgets.emptyState(
                message: 'No tasks found',
                subtitle: 'Create your first task to get started',
                actionText: 'Add Task',
                onAction: () => _showAddTaskDialog(context),
              );
            }
            
            // Use responsive grid for larger screens, list for mobile
            if (ResponsiveUtils.isMobile(context)) {
              return ResponsiveListView(
                children: filteredTasks.map((task) => _TaskCard(task: task)).toList(),
              );
            } else {
              return ResponsiveGrid(
                children: filteredTasks.map((task) => _TaskCard(task: task)).toList(),
                childAspectRatio: 1.5,
              );
            }
          },
          error: (message) => CommonWidgets.errorWidget(
            message: message,
            retryText: 'Retry',
            onRetry: () => context.read<TaskBloc>().add(const TaskEvent.refresh()),
          ),
        );
      },
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ResponsiveText('Add New Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                hintText: 'Enter task title',
              ),
            ),
            ResponsiveSpacing(),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Enter task description',
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ResponsiveButton(
            text: 'Add',
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                context.read<TaskBloc>().add(TaskEvent.added(
                  title: titleController.text,
                  description: descriptionController.text,
                ));
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}

/// Task card widget using Freezed Task model and responsive design
class _TaskCard extends StatelessWidget {
  final Task task;

  const _TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return ResponsiveCard(
      onTap: () => _showTaskDetails(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: ResponsiveText(
                  task.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Checkbox(
                value: task.isCompleted,
                onChanged: (value) {
                  context.read<TaskBloc>().add(TaskEvent.toggled(task.id));
                },
              ),
            ],
          ),
          if (task.description.isNotEmpty) ...[
            ResponsiveSpacing(),
            ResponsiveText(
              task.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                decoration: task.isCompleted ? TextDecoration.lineThrough : null,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          ResponsiveSpacing(),
          Wrap(
            spacing: ResponsiveUtils.getResponsiveSpacing(context),
            children: [
              _PriorityChip(priority: task.priority),
              _CategoryChip(category: task.category),
              if (task.dueDate != null) _DueDateChip(dueDate: task.dueDate!),
            ],
          ),
          ResponsiveSpacing(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ResponsiveText(
                'Created: ${_formatDate(task.createdAt)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Row(
                children: [
                  ResponsiveIconButton(
                    icon: Icons.edit,
                    onPressed: () => _editTask(context),
                    tooltip: 'Edit task',
                  ),
                  ResponsiveIconButton(
                    icon: Icons.delete,
                    onPressed: () => _deleteTask(context),
                    tooltip: 'Delete task',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showTaskDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ResponsiveText(task.title),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ResponsiveText(
                task.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              ResponsiveSpacing(),
              ResponsiveText(
                'Priority: ${task.priority.name.toUpperCase()}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              ResponsiveText(
                'Category: ${task.category}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              if (task.dueDate != null) ...[
                ResponsiveText(
                  'Due Date: ${_formatDate(task.dueDate!)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
              ResponsiveText(
                'Created: ${_formatDate(task.createdAt)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              ResponsiveText(
                'Updated: ${_formatDate(task.updatedAt)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
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

  void _editTask(BuildContext context) {
    // Implementation for editing task
    CommonWidgets.showInfoSnackBar(
      context: context,
      message: 'Edit task: ${task.title}',
    );
  }

  void _deleteTask(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: ResponsiveText('Are you sure you want to delete "${task.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ResponsiveButton(
            text: 'Delete',
            onPressed: () {
              context.read<TaskBloc>().add(TaskEvent.deleted(task.id));
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

/// Priority chip widget
class _PriorityChip extends StatelessWidget {
  final TaskPriority priority;

  const _PriorityChip({required this.priority});

  @override
  Widget build(BuildContext context) {
    final color = TaskX.priorityColors[priority] ?? 0xFF2196F3;
    
    return Chip(
      label: ResponsiveText(
        priority.name.toUpperCase(),
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Color(color),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }
}

/// Category chip widget
class _CategoryChip extends StatelessWidget {
  final String category;

  const _CategoryChip({required this.category});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: ResponsiveText(category),
      backgroundColor: Colors.grey[200],
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }
}

/// Due date chip widget
class _DueDateChip extends StatelessWidget {
  final DateTime dueDate;

  const _DueDateChip({required this.dueDate});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isOverdue = dueDate.isBefore(now);
    final isDueToday = dueDate.day == now.day && 
                      dueDate.month == now.month && 
                      dueDate.year == now.year;
    
    Color backgroundColor;
    String text;
    
    if (isOverdue) {
      backgroundColor = Colors.red;
      text = 'OVERDUE';
    } else if (isDueToday) {
      backgroundColor = Colors.orange;
      text = 'TODAY';
    } else {
      backgroundColor = Colors.green;
      text = '${dueDate.day}/${dueDate.month}';
    }
    
    return Chip(
      label: ResponsiveText(
        text,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      backgroundColor: backgroundColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }
} 