import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/task/task_bloc.dart';
import '../core/widgets/responsive_widgets.dart';
import '../core/utils/responsive_utils.dart';
import '../widgets/task_list_widget.dart';
import '../models/task.dart';

/// Responsive home screen that adapts to different screen sizes
class ResponsiveHomeScreen extends StatelessWidget {
  const ResponsiveHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveAppBar(
        title: 'Todo App',
        actions: [
          ResponsiveIconButton(
            icon: Icons.search,
            onPressed: () => _showSearchDialog(context),
            tooltip: 'Search tasks',
          ),
          ResponsiveIconButton(
            icon: Icons.filter_list,
            onPressed: () => _showFilterDialog(context),
            tooltip: 'Filter tasks',
          ),
          ResponsiveIconButton(
            icon: Icons.sort,
            onPressed: () => _showSortDialog(context),
            tooltip: 'Sort tasks',
          ),
        ],
      ),
      body: ResponsiveContainer(
        child: Column(
          children: [
            _buildStatisticsSection(context),
            ResponsiveSpacing(),
            _buildFilterSection(context),
            ResponsiveSpacing(),
            Expanded(
              child: _buildTaskSection(context),
            ),
          ],
        ),
      ),
      floatingActionButton: ResponsiveFloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        tooltip: 'Add new task',
        child: const Icon(Icons.add),
      ),
    );
  }

  /// Build statistics section that adapts to screen size
  Widget _buildStatisticsSection(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const SizedBox.shrink(),
          loaded: (tasks, filteredTasks, currentFilter, currentSort, selectedPriority, 
                   selectedCategory, selectedDueDateFilter, searchQuery, categories, statistics) {
            if (ResponsiveUtils.isMobile(context)) {
              return _buildMobileStatistics(context, statistics);
            } else {
              return _buildDesktopStatistics(context, statistics);
            }
          },
          error: (message) => const SizedBox.shrink(),
        );
      },
    );
  }

  /// Mobile statistics layout
  Widget _buildMobileStatistics(BuildContext context, Map<String, int> statistics) {
    return ResponsiveCard(
      child: Column(
        children: [
          ResponsiveText(
            'Task Statistics',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          ResponsiveSpacing(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(context, 'Total', statistics['total'] ?? 0, Icons.list),
              _buildStatItem(context, 'Completed', statistics['completed'] ?? 0, Icons.check_circle),
              _buildStatItem(context, 'Pending', statistics['pending'] ?? 0, Icons.schedule),
            ],
          ),
        ],
      ),
    );
  }

  /// Desktop statistics layout
  Widget _buildDesktopStatistics(BuildContext context, Map<String, int> statistics) {
    return ResponsiveGrid(
      children: [
        _buildStatCard(context, 'Total Tasks', statistics['total'] ?? 0, Icons.list, Colors.blue),
        _buildStatCard(context, 'Completed', statistics['completed'] ?? 0, Icons.check_circle, Colors.green),
        _buildStatCard(context, 'Pending', statistics['pending'] ?? 0, Icons.schedule, Colors.orange),
        _buildStatCard(context, 'Overdue', statistics['overdue'] ?? 0, Icons.warning, Colors.red),
      ],
    );
  }

  /// Build individual stat item for mobile
  Widget _buildStatItem(BuildContext context, String label, int value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).primaryColor),
        ResponsiveSpacing(multiplier: 0.5),
        ResponsiveText(
          value.toString(),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        ResponsiveText(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  /// Build stat card for desktop
  Widget _buildStatCard(BuildContext context, String label, int value, IconData icon, Color color) {
    return ResponsiveCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: ResponsiveUtils.getResponsiveIconSize(context)),
          ResponsiveSpacing(),
          ResponsiveText(
            value.toString(),
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          ResponsiveText(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  /// Build filter section
  Widget _buildFilterSection(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const SizedBox.shrink(),
          loaded: (tasks, filteredTasks, currentFilter, currentSort, selectedPriority, 
                   selectedCategory, selectedDueDateFilter, searchQuery, categories, statistics) {
            if (ResponsiveUtils.isMobile(context)) {
              return _buildMobileFilters(context, currentFilter, selectedPriority, selectedCategory);
            } else {
              return _buildDesktopFilters(context, currentFilter, selectedPriority, selectedCategory);
            }
          },
          error: (message) => const SizedBox.shrink(),
        );
      },
    );
  }

  /// Mobile filters layout
  Widget _buildMobileFilters(BuildContext context, TaskFilter currentFilter, 
                           TaskPriority? selectedPriority, String? selectedCategory) {
    return ResponsiveCard(
      child: Column(
        children: [
          ResponsiveText(
            'Filters',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          ResponsiveSpacing(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(context, 'All', currentFilter == TaskFilter.all, () {
                  context.read<TaskBloc>().add(TaskEvent.filterChanged(TaskFilter.all));
                }),
                _buildFilterChip(context, 'Active', currentFilter == TaskFilter.active, () {
                  context.read<TaskBloc>().add(TaskEvent.filterChanged(TaskFilter.active));
                }),
                _buildFilterChip(context, 'Completed', currentFilter == TaskFilter.completed, () {
                  context.read<TaskBloc>().add(TaskEvent.filterChanged(TaskFilter.completed));
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Desktop filters layout
  Widget _buildDesktopFilters(BuildContext context, TaskFilter currentFilter, 
                             TaskPriority? selectedPriority, String? selectedCategory) {
    return ResponsiveCard(
      child: Column(
        children: [
          ResponsiveText(
            'Filters & Sorting',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          ResponsiveSpacing(),
          Row(
            children: [
              Expanded(
                child: _buildFilterDropdown(context, currentFilter),
              ),
              ResponsiveSpacing(isVertical: false),
              Expanded(
                child: _buildPriorityDropdown(context, selectedPriority),
              ),
              ResponsiveSpacing(isVertical: false),
              Expanded(
                child: _buildCategoryDropdown(context, selectedCategory),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build filter chip
  Widget _buildFilterChip(BuildContext context, String label, bool isSelected, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.only(right: ResponsiveUtils.getResponsiveSpacing(context)),
      child: FilterChip(
        label: ResponsiveText(label),
        selected: isSelected,
        onSelected: (_) => onTap(),
      ),
    );
  }

  /// Build filter dropdown
  Widget _buildFilterDropdown(BuildContext context, TaskFilter currentFilter) {
    return DropdownButtonFormField<TaskFilter>(
      value: currentFilter,
      decoration: const InputDecoration(
        labelText: 'Filter',
        border: OutlineInputBorder(),
      ),
      items: TaskFilter.values.map((filter) {
        return DropdownMenuItem(
          value: filter,
          child: Text(filter.name.toUpperCase()),
        );
      }).toList(),
      onChanged: (filter) {
        if (filter != null) {
          context.read<TaskBloc>().add(TaskEvent.filterChanged(filter));
        }
      },
    );
  }

  /// Build priority dropdown
  Widget _buildPriorityDropdown(BuildContext context, TaskPriority? selectedPriority) {
    return DropdownButtonFormField<TaskPriority?>(
      value: selectedPriority,
      decoration: const InputDecoration(
        labelText: 'Priority',
        border: OutlineInputBorder(),
      ),
      items: [
        const DropdownMenuItem(
          value: null,
          child: Text('All Priorities'),
        ),
        ...TaskPriority.values.map((priority) {
          return DropdownMenuItem(
            value: priority,
            child: Text(priority.name.toUpperCase()),
          );
        }),
      ],
      onChanged: (priority) {
        context.read<TaskBloc>().add(TaskEvent.priorityFilterChanged(priority));
      },
    );
  }

  /// Build category dropdown
  Widget _buildCategoryDropdown(BuildContext context, String? selectedCategory) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const SizedBox.shrink(),
          loaded: (tasks, filteredTasks, currentFilter, currentSort, selectedPriority, 
                   selectedCategory, selectedDueDateFilter, searchQuery, categories, statistics) {
            return DropdownButtonFormField<String?>(
              value: selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              items: [
                const DropdownMenuItem(
                  value: null,
                  child: Text('All Categories'),
                ),
                ...categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }),
              ],
              onChanged: (category) {
                context.read<TaskBloc>().add(TaskEvent.categoryFilterChanged(category));
              },
            );
          },
          error: (message) => const SizedBox.shrink(),
        );
      },
    );
  }

  /// Build task section
  Widget _buildTaskSection(BuildContext context) {
    return ResponsiveContainer(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ResponsiveText(
                'Tasks',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              ResponsiveButton(
                text: 'Refresh',
                onPressed: () => context.read<TaskBloc>().add(const TaskEvent.refresh()),
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
          ResponsiveSpacing(),
          Expanded(
            child: const TaskListWidget(),
          ),
        ],
      ),
    );
  }

  /// Show search dialog
  void _showSearchDialog(BuildContext context) {
    final searchController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ResponsiveText('Search Tasks'),
        content: TextField(
          controller: searchController,
          decoration: const InputDecoration(
            labelText: 'Search',
            hintText: 'Enter search term',
            prefixIcon: Icon(Icons.search),
          ),
          onSubmitted: (query) {
            context.read<TaskBloc>().add(TaskEvent.searched(query));
            Navigator.of(context).pop();
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ResponsiveButton(
            text: 'Search',
            onPressed: () {
              context.read<TaskBloc>().add(TaskEvent.searched(searchController.text));
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  /// Show filter dialog
  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ResponsiveText('Filter Tasks'),
        content: const ResponsiveText('Filter options will be implemented here'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  /// Show sort dialog
  void _showSortDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ResponsiveText('Sort Tasks'),
        content: const ResponsiveText('Sort options will be implemented here'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  /// Show add task dialog
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