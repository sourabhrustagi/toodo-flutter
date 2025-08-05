import '../models/task.dart';
import '../data/database_helper.dart';
import '../services/api_service.dart';
import '../core/constants/app_constants.dart';

class TaskRepository {
  static final TaskRepository _instance = TaskRepository._internal();
  factory TaskRepository() => _instance;
  TaskRepository._internal();

  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final ApiService _apiService = ApiService();

  /// Initialize the repository
  Future<void> initialize() async {
    await _apiService.initialize();
  }

  /// Create a new task
  Future<Task> createTask(Task task) async {
    // Add 1 second delay to simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    if (AppConstants.useMockApi) {
      // Use ApiService for mock API
      final taskData = {
        'title': task.title,
        'description': task.description,
        'priority': _taskPriorityToString(task.priority),
        'categoryId': task.category,
        'dueDate': task.dueDate?.toIso8601String(),
      };
      
      final response = await _apiService.createTask(taskData);
      if (response['success'] == true) {
        return Task.fromJson(response['data']);
      } else {
        throw Exception('Failed to create task');
      }
    } else {
      // Use local database
      final id = await _databaseHelper.insertTask(task);
      return task.copyWith(id: id.toString());
    }
  }

  /// Get all tasks
  Future<List<Task>> getAllTasks() async {
    // Add 1 second delay to simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    if (AppConstants.useMockApi) {
      // Use ApiService for mock API
      final response = await _apiService.getTasks();
      if (response['success'] == true) {
        final tasksData = response['data']['tasks'] as List;
        return tasksData.map((taskData) => Task.fromJson(taskData)).toList();
      } else {
        throw Exception('Failed to fetch tasks');
      }
    } else {
      // Use local database
      return await _databaseHelper.getAllTasks();
    }
  }

  /// Get a specific task by ID
  Future<Task?> getTask(String id) async {
    // Add 1 second delay to simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    if (AppConstants.useMockApi) {
      // Use ApiService for mock API
      final response = await _apiService.getTask(id);
      if (response['success'] == true) {
        return Task.fromJson(response['data']);
      } else {
        return null;
      }
    } else {
      // Use local database
      return await _databaseHelper.getTask(id);
    }
  }

  /// Update a task
  Future<Task> updateTask(Task task) async {
    // Add 1 second delay to simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    if (AppConstants.useMockApi) {
      // Use ApiService for mock API
      final taskData = {
        'title': task.title,
        'description': task.description,
        'priority': _taskPriorityToString(task.priority),
        'categoryId': task.category,
        'dueDate': task.dueDate?.toIso8601String(),
        'completed': task.isCompleted,
      };
      
      final response = await _apiService.updateTask(task.id, taskData);
      if (response['success'] == true) {
        return Task.fromJson(response['data']);
      } else {
        throw Exception('Failed to update task');
      }
    } else {
      // Use local database
      await _databaseHelper.updateTask(task);
      return task;
    }
  }

  /// Delete a task
  Future<void> deleteTask(String id) async {
    // Add 1 second delay to simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    if (AppConstants.useMockApi) {
      // Use ApiService for mock API
      final response = await _apiService.deleteTask(id);
      if (response['success'] != true) {
        throw Exception('Failed to delete task');
      }
    } else {
      // Use local database
      await _databaseHelper.deleteTask(id);
    }
  }

  /// Toggle task completion status
  Future<Task> toggleTask(String id) async {
    final task = await getTask(id);
    if (task == null) {
      throw Exception('Task not found');
    }

    final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
    return await updateTask(updatedTask);
  }

  /// Get all categories
  Future<List<String>> getAllCategories() async {
    if (AppConstants.useMockApi) {
      // Use ApiService for mock API
      final response = await _apiService.getCategories();
      if (response['success'] == true) {
        final categoriesData = response['data'] as List;
        return categoriesData.map((cat) => cat['name'] as String).toList();
      } else {
        return AppConstants.defaultCategories;
      }
    } else {
      // Use local database
      return await _databaseHelper.getAllCategories();
    }
  }

  /// Get task statistics
  Future<Map<String, dynamic>> getTaskStatistics() async {
    if (AppConstants.useMockApi) {
      // Use ApiService for mock API
      final response = await _apiService.getTaskAnalytics();
      if (response['success'] == true) {
        return response['data'];
      } else {
        return {
          'total': 0,
          'completed': 0,
          'pending': 0,
          'overdue': 0,
          'completionRate': 0.0,
        };
      }
    } else {
      // Use local database
      final tasks = await getAllTasks();
      final total = tasks.length;
      final completed = tasks.where((task) => task.isCompleted).length;
      final pending = total - completed;
      final overdue = tasks.where((task) => task.isOverdue).length;
      final completionRate = total > 0 ? (completed / total) * 100 : 0.0;

      return {
        'total': total,
        'completed': completed,
        'pending': pending,
        'overdue': overdue,
        'completionRate': completionRate,
      };
    }
  }

  /// Toggle multiple tasks
  Future<void> toggleMultipleTasks(List<String> taskIds) async {
    if (AppConstants.useMockApi) {
      // Use ApiService for mock API
      final response = await _apiService.bulkTaskOperation('complete', taskIds);
      if (response['success'] != true) {
        throw Exception('Failed to toggle tasks');
      }
    } else {
      // Use local database
      for (final id in taskIds) {
        await toggleTask(id);
      }
    }
  }

  /// Delete multiple tasks
  Future<void> deleteMultipleTasks(List<String> taskIds) async {
    if (AppConstants.useMockApi) {
      // Use ApiService for mock API
      final response = await _apiService.bulkTaskOperation('delete', taskIds);
      if (response['success'] != true) {
        throw Exception('Failed to delete tasks');
      }
    } else {
      // Use local database
      for (final id in taskIds) {
        await deleteTask(id);
      }
    }
  }

  /// Update multiple task priorities
  Future<void> updateMultipleTaskPriorities(List<String> taskIds, TaskPriority priority) async {
    if (AppConstants.useMockApi) {
      // Use ApiService for mock API - this would need to be implemented
      throw Exception('Bulk priority update not implemented in mock API');
    } else {
      // Use local database
      for (final id in taskIds) {
        final task = await getTask(id);
        if (task != null) {
          final updatedTask = task.copyWith(priority: priority);
          await updateTask(updatedTask);
        }
      }
    }
  }

  /// Update multiple task categories
  Future<void> updateMultipleTaskCategories(List<String> taskIds, String category) async {
    if (AppConstants.useMockApi) {
      // Use ApiService for mock API - this would need to be implemented
      throw Exception('Bulk category update not implemented in mock API');
    } else {
      // Use local database
      for (final id in taskIds) {
        final task = await getTask(id);
        if (task != null) {
          final updatedTask = task.copyWith(category: category);
          await updateTask(updatedTask);
        }
      }
    }
  }

  /// Search tasks
  Future<List<Task>> searchTasks(String query) async {
    if (AppConstants.useMockApi) {
      // Use ApiService for mock API
      final response = await _apiService.searchTasks(query);
      if (response['success'] == true) {
        final tasksData = response['data']['tasks'] as List;
        return tasksData.map((taskData) => Task.fromJson(taskData)).toList();
      } else {
        return [];
      }
    } else {
      // Use local database
      return await _databaseHelper.searchTasks(query);
    }
  }

  /// Get tasks by category
  Future<List<Task>> getTasksByCategory(String category) async {
    if (AppConstants.useMockApi) {
      // Use ApiService for mock API
      final response = await _apiService.getTasks(priority: null, completed: null, search: null, sortBy: null, sortOrder: null);
      if (response['success'] == true) {
        final tasksData = response['data']['tasks'] as List;
        final allTasks = tasksData.map((taskData) => Task.fromJson(taskData)).toList();
        return allTasks.where((task) => task.category == category).toList();
      } else {
        return [];
      }
    } else {
      // Use local database
      return await _databaseHelper.getTasksByCategory(category);
    }
  }

  /// Submit feedback
  Future<void> submitFeedback({
    required String userId,
    required int rating,
    required String feedback,
  }) async {
    if (AppConstants.useMockApi) {
      // Use ApiService for mock API
      final feedbackData = {
        'rating': rating,
        'comment': feedback,
        'category': 'general',
      };
      
      final response = await _apiService.submitFeedback(feedbackData);
      if (response['success'] != true) {
        throw Exception('Failed to submit feedback');
      }
    } else {
      // For now, just print the feedback
      print('Feedback submitted: User: $userId, Rating: $rating, Feedback: $feedback');
    }
  }

  /// Submit app rating
  Future<void> submitRating({
    required String userId,
    required int rating,
  }) async {
    if (AppConstants.useMockApi) {
      // Use ApiService for mock API
      final feedbackData = {
        'rating': rating,
        'comment': 'App rating',
        'category': 'rating',
      };
      
      final response = await _apiService.submitFeedback(feedbackData);
      if (response['success'] != true) {
        throw Exception('Failed to submit rating');
      }
    } else {
      // For now, just print the rating
      print('Rating submitted: User: $userId, Rating: $rating');
    }
  }

  /// Convert TaskPriority to string
  String _taskPriorityToString(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return 'high';
      case TaskPriority.low:
        return 'low';
      case TaskPriority.medium:
        return 'medium';
    }
  }

  /// Dispose resources
  void dispose() {
    _apiService.dispose();
  }
} 