import 'dart:async';
import 'dart:math';
import '../models/task.dart';

class MockApiService {
  // Simulate network delay
  static const Duration _networkDelay = Duration(milliseconds: 500);
  
  // Mock data storage
  final Map<String, Task> _mockTasks = {};
  final Random _random = Random();

  // Simulate network failure occasionally
  bool get _shouldFail => _random.nextDouble() < 0.1; // 10% failure rate

  Future<List<Task>> getAllTasks() async {
    await Future.delayed(_networkDelay);
    
    if (_shouldFail) {
      throw Exception('Network error: Failed to fetch tasks');
    }
    
    return _mockTasks.values.toList();
  }

  Future<Task?> getTask(String id) async {
    await Future.delayed(_networkDelay);
    
    if (_shouldFail) {
      throw Exception('Network error: Failed to fetch task');
    }
    
    return _mockTasks[id];
  }

  Future<void> createTask(Task task) async {
    await Future.delayed(_networkDelay);
    
    if (_shouldFail) {
      throw Exception('Network error: Failed to create task');
    }
    
    _mockTasks[task.id] = task;
  }

  Future<void> updateTask(Task task) async {
    await Future.delayed(_networkDelay);
    
    if (_shouldFail) {
      throw Exception('Network error: Failed to update task');
    }
    
    if (_mockTasks.containsKey(task.id)) {
      _mockTasks[task.id] = task;
    } else {
      throw Exception('Task not found');
    }
  }

  Future<void> deleteTask(String id) async {
    await Future.delayed(_networkDelay);
    
    if (_shouldFail) {
      throw Exception('Network error: Failed to delete task');
    }
    
    if (_mockTasks.containsKey(id)) {
      _mockTasks.remove(id);
    } else {
      throw Exception('Task not found');
    }
  }

  Future<List<Task>> searchTasks(String query) async {
    await Future.delayed(_networkDelay);
    
    if (_shouldFail) {
      throw Exception('Network error: Failed to search tasks');
    }
    
    return _mockTasks.values
        .where((task) =>
            task.title.toLowerCase().contains(query.toLowerCase()) ||
            task.description.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<List<Task>> getTasksByCategory(String category) async {
    await Future.delayed(_networkDelay);
    
    if (_shouldFail) {
      throw Exception('Network error: Failed to get tasks by category');
    }
    
    return _mockTasks.values
        .where((task) => task.category == category)
        .toList();
  }

  // Simulate user feedback submission
  Future<void> submitFeedback({
    required String userId,
    required int rating,
    required String feedback,
  }) async {
    await Future.delayed(_networkDelay);
    
    if (_shouldFail) {
      throw Exception('Network error: Failed to submit feedback');
    }
    
    // Mock feedback storage
    print('Feedback submitted: User: $userId, Rating: $rating, Feedback: $feedback');
  }

  // Simulate app rating submission
  Future<void> submitRating({
    required String userId,
    required int rating,
  }) async {
    await Future.delayed(_networkDelay);
    
    if (_shouldFail) {
      throw Exception('Network error: Failed to submit rating');
    }
    
    // Mock rating storage
    print('Rating submitted: User: $userId, Rating: $rating');
  }

  // Clear mock data (for testing)
  void clearMockData() {
    _mockTasks.clear();
  }

  // Get mock data count (for testing)
  int get mockDataCount => _mockTasks.length;
} 