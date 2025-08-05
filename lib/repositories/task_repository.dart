import '../data/database_helper.dart';
import '../models/task.dart';
import '../blocs/task/task_bloc.dart';

class TaskRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  // Basic CRUD operations
  Future<void> createTask(Task task) async {
    // Simulate API call with 1 second delay
    await Future.delayed(const Duration(seconds: 1));
    await _databaseHelper.insertTask(task);
  }

  Future<List<Task>> getAllTasks() async {
    // Simulate API call with 1 second delay
    await Future.delayed(const Duration(seconds: 1));
    return await _databaseHelper.getAllTasks();
  }

  Future<Task?> getTask(String id) async {
    // Simulate API call with 1 second delay
    await Future.delayed(const Duration(seconds: 1));
    return await _databaseHelper.getTask(id);
  }

  Future<void> updateTask(Task task) async {
    // Simulate API call with 1 second delay
    await Future.delayed(const Duration(seconds: 1));
    await _databaseHelper.updateTask(task);
  }

  Future<void> deleteTask(String id) async {
    // Simulate API call with 1 second delay
    await Future.delayed(const Duration(seconds: 1));
    await _databaseHelper.deleteTask(id);
  }

  Future<void> deleteAllTasks() async {
    await _databaseHelper.deleteAllTasks();
  }

  // Category management
  Future<List<String>> getAllCategories() async {
    return await _databaseHelper.getAllCategories();
  }

  // Statistics
  Future<Map<String, int>> getTaskStatistics() async {
    return await _databaseHelper.getTaskStatistics();
  }

  // Bulk operations
  Future<void> toggleMultipleTasks(List<String> taskIds, bool isCompleted) async {
    for (final taskId in taskIds) {
      final task = await getTask(taskId);
      if (task != null) {
        final updatedTask = task.copyWith(isCompleted: isCompleted);
        await updateTask(updatedTask);
      }
    }
  }

  Future<void> deleteMultipleTasks(List<String> taskIds) async {
    for (final taskId in taskIds) {
      await deleteTask(taskId);
    }
  }

  Future<void> updateMultipleTaskPriorities(List<String> taskIds, TaskPriority priority) async {
    for (final taskId in taskIds) {
      final task = await getTask(taskId);
      if (task != null) {
        final updatedTask = task.copyWith(priority: priority);
        await updateTask(updatedTask);
      }
    }
  }

  Future<void> updateMultipleTaskCategories(List<String> taskIds, String category) async {
    for (final taskId in taskIds) {
      final task = await getTask(taskId);
      if (task != null) {
        final updatedTask = task.copyWith(category: category);
        await updateTask(updatedTask);
      }
    }
  }

  // Advanced filtering with multiple criteria
  Future<List<Task>> getFilteredTasks({
    String? searchQuery,
    TaskPriority? priority,
    String? category,
    bool? isCompleted,
    DateTime? dueDateFilter,
  }) async {
    List<Task> tasks = await getAllTasks();

    // Apply search filter
    if (searchQuery != null && searchQuery.isNotEmpty) {
      tasks = tasks.where((task) {
        return task.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
               task.description.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    // Apply priority filter
    if (priority != null) {
      tasks = tasks.where((task) => task.priority == priority).toList();
    }

    // Apply category filter
    if (category != null && category.isNotEmpty) {
      tasks = tasks.where((task) => task.category == category).toList();
    }

    // Apply completion status filter
    if (isCompleted != null) {
      tasks = tasks.where((task) => task.isCompleted == isCompleted).toList();
    }

    // Apply due date filter
    if (dueDateFilter != null) {
      final now = DateTime.now();
      
      if (dueDateFilter.day == 0) { // Today
        tasks = tasks.where((task) => task.isDueToday).toList();
      } else if (dueDateFilter.day == 7) { // This week
        tasks = tasks.where((task) => task.isDueThisWeek).toList();
      } else if (dueDateFilter.day == -1) { // Overdue
        tasks = tasks.where((task) => task.isOverdue).toList();
      }
    }

    return tasks;
  }

  // Sorting operations
  Future<List<Task>> getSortedTasks(List<Task> tasks, TaskSortOption sortOption) async {
    switch (sortOption) {
      case TaskSortOption.priority:
        tasks.sort((a, b) => b.priority.index.compareTo(a.priority.index));
        break;
      case TaskSortOption.dueDate:
        tasks.sort((a, b) {
          if (a.dueDate == null && b.dueDate == null) return 0;
          if (a.dueDate == null) return 1;
          if (b.dueDate == null) return -1;
          return a.dueDate!.compareTo(b.dueDate!);
        });
        break;
      case TaskSortOption.creationDate:
        tasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case TaskSortOption.title:
        tasks.sort((a, b) => a.title.compareTo(b.title));
        break;
    }
    return tasks;
  }


}

// TaskSortOption enum is defined in task_bloc.dart 