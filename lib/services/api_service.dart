import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import '../core/constants/app_constants.dart';
import '../core/services/network_service.dart';
import '../core/services/logger_service.dart';
import '../core/services/retry_interceptor.dart';
import '../models/task.dart';
import 'secure_storage_service.dart';

/// Comprehensive API service that handles both mock and real API calls
class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final NetworkService _networkService = NetworkService();
  final SecureStorageService _secureStorage = SecureStorageService();
  final Random _random = Random();

  // Mock data storage
  final Map<String, Task> _mockTasks = {};
  final Map<String, Map<String, dynamic>> _mockCategories = {};
  final List<Map<String, dynamic>> _mockFeedback = [];

  /// Initialize the API service
  Future<void> initialize() async {
    await _networkService.initialize();
    _initializeMockData();
    logger.info('ApiService initialized - Mock mode: ${AppConstants.useMockApi}');
  }

  /// Initialize mock data
  void _initializeMockData() {
    // Initialize mock categories
    _mockCategories['cat_1'] = {
      'id': 'cat_1',
      'name': 'Work',
      'color': '#FF5722',
      'createdAt': DateTime.now().toIso8601String(),
    };
    _mockCategories['cat_2'] = {
      'id': 'cat_2',
      'name': 'Personal',
      'color': '#4CAF50',
      'createdAt': DateTime.now().toIso8601String(),
    };

    // Initialize some mock tasks
    final task1 = Task(
      id: 'task_1',
      title: 'Complete project documentation',
      description: 'Write comprehensive documentation for the project',
      priority: TaskPriority.high,
      category: 'Work',
      dueDate: DateTime.now().add(const Duration(days: 7)),
      isCompleted: false,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    );

    final task2 = Task(
      id: 'task_2',
      title: 'Buy groceries',
      description: 'Get vegetables, fruits, and household items',
      priority: TaskPriority.medium,
      category: 'Personal',
      dueDate: DateTime.now().add(const Duration(days: 1)),
      isCompleted: false,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    );

    _mockTasks[task1.id] = task1;
    _mockTasks[task2.id] = task2;
  }

  /// Check if should use mock API
  bool get _useMockApi => AppConstants.useMockApi;

  /// Simulate network failure for mock API
  bool get _shouldFail => _random.nextDouble() < AppConstants.mockApiFailureRate;

  /// Get authentication token
  Future<String?> _getAuthToken() async {
    return await _secureStorage.getAuthToken();
  }

  /// Set authentication token
  Future<void> _setAuthToken(String token) async {
    await _secureStorage.saveAuthToken(token);
    _networkService.setAuthToken(token);
  }

  /// Clear authentication token
  Future<void> _clearAuthToken() async {
    await _secureStorage.clearAuthToken();
    _networkService.clearAuthToken();
  }

  // ==================== AUTHENTICATION APIs ====================
  
  /// Send OTP to phone number
  Future<Map<String, dynamic>> sendOTP(String phoneNumber) async {
    if (_useMockApi) {
      return _mockSendOTP(phoneNumber);
    } else {
      return _realSendOTP(phoneNumber);
    }
  }

  /// Mock implementation for sending OTP
  Future<Map<String, dynamic>> _mockSendOTP(String phoneNumber) async {
    await Future.delayed(AppConstants.mockApiDelay);
    
    if (_shouldFail) {
      throw Exception('Mock API failure: Failed to send OTP');
    }

    return {
      'success': true,
      'message': 'OTP sent successfully',
      'data': {
        'otp': '123456',
        'phoneNumber': phoneNumber,
        'expiresAt': DateTime.now().add(const Duration(minutes: 5)).toIso8601String(),
      },
    };
  }

  /// Real implementation for sending OTP with retry
  Future<Map<String, dynamic>> _realSendOTP(String phoneNumber) async {
    try {
      final response = await _networkService.post<Map<String, dynamic>>(
        '/auth/send-otp',
        data: {'phoneNumber': phoneNumber},
        retryConfig: RetryPolicy.auth,
      );

      return response.data ?? {};
    } catch (e) {
      logger.error('Failed to send OTP', e);
      rethrow;
    }
  }

  /// Verify OTP
  Future<Map<String, dynamic>> verifyOTP(String phoneNumber, String otp) async {
    if (_useMockApi) {
      return _mockVerifyOTP(phoneNumber, otp);
    } else {
      return _realVerifyOTP(phoneNumber, otp);
    }
  }

  /// Mock implementation for verifying OTP
  Future<Map<String, dynamic>> _mockVerifyOTP(String phoneNumber, String otp) async {
    await Future.delayed(AppConstants.mockApiDelay);
    
    if (_shouldFail) {
      throw Exception('Mock API failure: Invalid OTP');
    }

    if (otp != '123456') {
      return {
        'success': false,
        'message': 'Invalid OTP',
        'error': 'AUTH_ERROR',
      };
    }

    return {
      'success': true,
      'message': 'OTP verified successfully',
      'data': {
        'user': {
          'id': 'user_${DateTime.now().millisecondsSinceEpoch}',
          'phoneNumber': phoneNumber,
          'email': null,
          'name': 'User',
          'createdAt': DateTime.now().toIso8601String(),
        },
        'token': 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
        'refreshToken': 'mock_refresh_token_${DateTime.now().millisecondsSinceEpoch}',
      },
    };
  }

  /// Real implementation for verifying OTP with retry
  Future<Map<String, dynamic>> _realVerifyOTP(String phoneNumber, String otp) async {
    try {
      final response = await _networkService.post<Map<String, dynamic>>(
        '/auth/verify-otp',
        data: {
          'phoneNumber': phoneNumber,
          'otp': otp,
        },
        retryConfig: RetryPolicy.auth,
      );

      final data = response.data ?? {};
      
      // Save tokens if authentication successful
      if (data['success'] == true && data['data'] != null) {
        final token = data['data']['token'];
        final refreshToken = data['data']['refreshToken'];
        
        if (token != null) {
          await _setAuthToken(token);
        }
        if (refreshToken != null) {
          await _secureStorage.saveRefreshToken(refreshToken);
        }
      }

      return data;
    } catch (e) {
      logger.error('Failed to verify OTP', e);
      rethrow;
    }
  }

  /// Logout user
  Future<Map<String, dynamic>> logout() async {
    if (_useMockApi) {
      return _mockLogout();
    } else {
      return _realLogout();
    }
  }

  /// Mock implementation for logout
  Future<Map<String, dynamic>> _mockLogout() async {
    await Future.delayed(AppConstants.mockApiDelay);
    
    if (_shouldFail) {
      throw Exception('Mock API failure: Logout failed');
    }

    return {
      'success': true,
      'message': 'Logged out successfully',
    };
  }

  /// Real implementation for logout with retry
  Future<Map<String, dynamic>> _realLogout() async {
    try {
      final response = await _networkService.post<Map<String, dynamic>>(
        '/auth/logout',
        retryConfig: RetryPolicy.auth,
      );

      // Clear tokens regardless of response
      await _clearAuthToken();

      return response.data ?? {};
    } catch (e) {
      logger.error('Failed to logout', e);
      // Clear tokens even if logout fails
      await _clearAuthToken();
      rethrow;
    }
  }

  // ==================== TASKS APIs ====================

  /// Get all tasks with optional filters
  Future<Map<String, dynamic>> getTasks({
    int page = 1,
    int limit = 20,
    String? priority,
    bool? completed,
    String? search,
    String? sortBy,
    String? sortOrder,
  }) async {
    if (_useMockApi) {
      return await _mockGetTasks(
        page: page,
        limit: limit,
        priority: priority,
        completed: completed,
        search: search,
        sortBy: sortBy,
        sortOrder: sortOrder,
      );
    } else {
      return await _realGetTasks(
        page: page,
        limit: limit,
        priority: priority,
        completed: completed,
        search: search,
        sortBy: sortBy,
        sortOrder: sortOrder,
      );
    }
  }

  Future<Map<String, dynamic>> _mockGetTasks({
    int page = 1,
    int limit = 20,
    String? priority,
    bool? completed,
    String? search,
    String? sortBy,
    String? sortOrder,
  }) async {
    await Future.delayed(AppConstants.mockApiDelay);
    
    if (_shouldFail) {
      throw Exception('Network error: Failed to fetch tasks');
    }

    var tasks = _mockTasks.values.toList();

    // Apply filters
    if (priority != null) {
      final priorityEnum = _stringToTaskPriority(priority);
      tasks = tasks.where((task) => task.priority == priorityEnum).toList();
    }

    if (completed != null) {
      tasks = tasks.where((task) => task.isCompleted == completed).toList();
    }

    if (search != null && search.isNotEmpty) {
      tasks = tasks.where((task) =>
          task.title.toLowerCase().contains(search.toLowerCase()) ||
          task.description.toLowerCase().contains(search.toLowerCase())).toList();
    }

    // Apply sorting
    if (sortBy != null) {
      switch (sortBy) {
        case 'title':
          tasks.sort((a, b) => a.title.compareTo(b.title));
          break;
        case 'priority':
          tasks.sort((a, b) => a.priority.index.compareTo(b.priority.index));
          break;
        case 'dueDate':
          tasks.sort((a, b) => (a.dueDate ?? DateTime.now()).compareTo(b.dueDate ?? DateTime.now()));
          break;
        case 'createdAt':
          tasks.sort((a, b) => a.createdAt.compareTo(b.createdAt));
          break;
      }

      if (sortOrder == 'desc') {
        tasks = tasks.reversed.toList();
      }
    }

    // Apply pagination
    final startIndex = (page - 1) * limit;
    final endIndex = startIndex + limit;
    final paginatedTasks = tasks.skip(startIndex).take(limit).toList();

    return {
      'success': true,
      'data': {
        'tasks': paginatedTasks.map((task) => task.toJson()).toList(),
        'pagination': {
          'page': page,
          'limit': limit,
          'total': tasks.length,
          'totalPages': (tasks.length / limit).ceil(),
        },
      },
    };
  }

  /// Real implementation for getting tasks with retry
  Future<Map<String, dynamic>> _realGetTasks({
    int page = 1,
    int limit = 20,
    String? priority,
    bool? completed,
    String? search,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
      };

      if (priority != null) queryParams['priority'] = priority;
      if (completed != null) queryParams['completed'] = completed;
      if (search != null) queryParams['search'] = search;
      if (sortBy != null) queryParams['sortBy'] = sortBy;
      if (sortOrder != null) queryParams['sortOrder'] = sortOrder;

      final response = await _networkService.get<Map<String, dynamic>>(
        '/tasks',
        queryParameters: queryParams,
        retryConfig: RetryPolicy.dataFetch,
      );

      return response.data ?? {};
    } catch (e) {
      logger.error('Failed to get tasks', e);
      rethrow;
    }
  }

  /// Create new task
  Future<Map<String, dynamic>> createTask(Map<String, dynamic> taskData) async {
    if (_useMockApi) {
      return _mockCreateTask(taskData);
    } else {
      return _realCreateTask(taskData);
    }
  }

  /// Mock implementation for creating task
  Future<Map<String, dynamic>> _mockCreateTask(Map<String, dynamic> taskData) async {
    await Future.delayed(AppConstants.mockApiDelay);
    
    if (_shouldFail) {
      throw Exception('Mock API failure: Failed to create task');
    }

    final taskId = 'task_${DateTime.now().millisecondsSinceEpoch}';
    final task = Task(
      id: taskId,
      title: taskData['title'] ?? '',
      description: taskData['description'] ?? '',
      priority: _stringToTaskPriority(taskData['priority'] ?? 'medium'),
      category: taskData['categoryId'] ?? 'General',
      dueDate: taskData['dueDate'] != null ? DateTime.parse(taskData['dueDate']) : null,
      isCompleted: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    _mockTasks[taskId] = task;

    return {
      'success': true,
      'message': 'Task created successfully',
      'data': task.toJson(),
    };
  }

  /// Real implementation for creating task with retry
  Future<Map<String, dynamic>> _realCreateTask(Map<String, dynamic> taskData) async {
    try {
      final response = await _networkService.post<Map<String, dynamic>>(
        '/tasks',
        data: taskData,
        retryConfig: RetryPolicy.dataModify,
      );

      return response.data ?? {};
    } catch (e) {
      logger.error('Failed to create task', e);
      rethrow;
    }
  }

  /// Get specific task
  Future<Map<String, dynamic>> getTask(String taskId) async {
    if (_useMockApi) {
      return _mockGetTask(taskId);
    } else {
      return _realGetTask(taskId);
    }
  }

  /// Mock implementation for getting task
  Future<Map<String, dynamic>> _mockGetTask(String taskId) async {
    await Future.delayed(AppConstants.mockApiDelay);
    
    if (_shouldFail) {
      throw Exception('Mock API failure: Failed to get task');
    }

    final task = _mockTasks[taskId];
    if (task == null) {
      return {
        'success': false,
        'message': 'Task not found',
        'error': 'NOT_FOUND',
      };
    }

    return {
      'success': true,
      'data': task.toJson(),
    };
  }

  /// Real implementation for getting task with retry
  Future<Map<String, dynamic>> _realGetTask(String taskId) async {
    try {
      final response = await _networkService.get<Map<String, dynamic>>(
        '/tasks/$taskId',
        retryConfig: RetryPolicy.dataFetch,
      );

      return response.data ?? {};
    } catch (e) {
      logger.error('Failed to get task', e);
      rethrow;
    }
  }

  /// Update task
  Future<Map<String, dynamic>> updateTask(String taskId, Map<String, dynamic> taskData) async {
    if (_useMockApi) {
      return _mockUpdateTask(taskId, taskData);
    } else {
      return _realUpdateTask(taskId, taskData);
    }
  }

  /// Mock implementation for updating task
  Future<Map<String, dynamic>> _mockUpdateTask(String taskId, Map<String, dynamic> taskData) async {
    await Future.delayed(AppConstants.mockApiDelay);
    
    if (_shouldFail) {
      throw Exception('Mock API failure: Failed to update task');
    }

    final existingTask = _mockTasks[taskId];
    if (existingTask == null) {
      return {
        'success': false,
        'message': 'Task not found',
        'error': 'NOT_FOUND',
      };
    }

    final updatedTask = existingTask.copyWith(
      title: taskData['title'] ?? existingTask.title,
      description: taskData['description'] ?? existingTask.description,
      priority: taskData['priority'] != null ? _stringToTaskPriority(taskData['priority']) : existingTask.priority,
      category: taskData['categoryId'] ?? existingTask.category,
      dueDate: taskData['dueDate'] != null ? DateTime.parse(taskData['dueDate']) : existingTask.dueDate,
      isCompleted: taskData['completed'] ?? existingTask.isCompleted,
      updatedAt: DateTime.now(),
    );

    _mockTasks[taskId] = updatedTask;

    return {
      'success': true,
      'message': 'Task updated successfully',
      'data': updatedTask.toJson(),
    };
  }

  /// Real implementation for updating task with retry
  Future<Map<String, dynamic>> _realUpdateTask(String taskId, Map<String, dynamic> taskData) async {
    try {
      final response = await _networkService.put<Map<String, dynamic>>(
        '/tasks/$taskId',
        data: taskData,
        retryConfig: RetryPolicy.dataModify,
      );

      return response.data ?? {};
    } catch (e) {
      logger.error('Failed to update task', e);
      rethrow;
    }
  }

  /// Delete task
  Future<Map<String, dynamic>> deleteTask(String taskId) async {
    if (_useMockApi) {
      return _mockDeleteTask(taskId);
    } else {
      return _realDeleteTask(taskId);
    }
  }

  /// Mock implementation for deleting task
  Future<Map<String, dynamic>> _mockDeleteTask(String taskId) async {
    await Future.delayed(AppConstants.mockApiDelay);
    
    if (_shouldFail) {
      throw Exception('Mock API failure: Failed to delete task');
    }

    final task = _mockTasks[taskId];
    if (task == null) {
      return {
        'success': false,
        'message': 'Task not found',
        'error': 'NOT_FOUND',
      };
    }

    _mockTasks.remove(taskId);

    return {
      'success': true,
      'message': 'Task deleted successfully',
    };
  }

  /// Real implementation for deleting task with retry
  Future<Map<String, dynamic>> _realDeleteTask(String taskId) async {
    try {
      final response = await _networkService.delete<Map<String, dynamic>>(
        '/tasks/$taskId',
        retryConfig: RetryPolicy.dataModify,
      );

      return response.data ?? {};
    } catch (e) {
      logger.error('Failed to delete task', e);
      rethrow;
    }
  }

  /// Mark task as completed
  Future<Map<String, dynamic>> completeTask(String taskId) async {
    if (_useMockApi) {
      return _mockCompleteTask(taskId);
    } else {
      return _realCompleteTask(taskId);
    }
  }

  Future<Map<String, dynamic>> _mockCompleteTask(String taskId) async {
    await Future.delayed(AppConstants.mockApiDelay);
    
    if (_shouldFail) {
      throw Exception('Network error: Failed to complete task');
    }

    final task = _mockTasks[taskId];
    if (task == null) {
      throw Exception('Task not found');
    }

    final updatedTask = Task(
      id: taskId,
      title: task.title,
      description: task.description,
      priority: task.priority,
      category: task.category,
      dueDate: task.dueDate,
      isCompleted: true,
      createdAt: task.createdAt,
      updatedAt: DateTime.now(),
    );

    _mockTasks[taskId] = updatedTask;

    return {
      'success': true,
      'data': updatedTask.toJson(),
    };
  }

  Future<Map<String, dynamic>> _realCompleteTask(String taskId) async {
    final response = await _networkService.patch('/tasks/$taskId/complete');
    return response.data;
  }

  // ==================== CATEGORIES APIs ====================

  /// Get all categories
  Future<Map<String, dynamic>> getCategories() async {
    if (_useMockApi) {
      return await _mockGetCategories();
    } else {
      return await _realGetCategories();
    }
  }

  Future<Map<String, dynamic>> _mockGetCategories() async {
    await Future.delayed(AppConstants.mockApiDelay);
    
    if (_shouldFail) {
      throw Exception('Network error: Failed to fetch categories');
    }

    return {
      'success': true,
      'data': _mockCategories.values.toList(),
    };
  }

  Future<Map<String, dynamic>> _realGetCategories() async {
    final response = await _networkService.get('/categories');
    return response.data;
  }

  /// Create new category
  Future<Map<String, dynamic>> createCategory(Map<String, dynamic> categoryData) async {
    if (_useMockApi) {
      return await _mockCreateCategory(categoryData);
    } else {
      return await _realCreateCategory(categoryData);
    }
  }

  Future<Map<String, dynamic>> _mockCreateCategory(Map<String, dynamic> categoryData) async {
    await Future.delayed(AppConstants.mockApiDelay);
    
    if (_shouldFail) {
      throw Exception('Network error: Failed to create category');
    }

    final categoryId = 'cat_${DateTime.now().millisecondsSinceEpoch}';
    final now = DateTime.now();

    final category = {
      'id': categoryId,
      'name': categoryData['name'],
      'color': categoryData['color'],
      'createdAt': now.toIso8601String(),
    };

    _mockCategories[categoryId] = category;

    return {
      'success': true,
      'data': category,
    };
  }

  Future<Map<String, dynamic>> _realCreateCategory(Map<String, dynamic> categoryData) async {
    final response = await _networkService.post('/categories', data: categoryData);
    return response.data;
  }

  // ==================== BULK OPERATIONS APIs ====================

  /// Bulk operations on tasks
  Future<Map<String, dynamic>> bulkTaskOperation(String operation, List<String> taskIds) async {
    if (_useMockApi) {
      return await _mockBulkTaskOperation(operation, taskIds);
    } else {
      return await _realBulkTaskOperation(operation, taskIds);
    }
  }

  Future<Map<String, dynamic>> _mockBulkTaskOperation(String operation, List<String> taskIds) async {
    await Future.delayed(AppConstants.mockApiDelay);
    
    if (_shouldFail) {
      throw Exception('Network error: Failed to perform bulk operation');
    }

    int updatedCount = 0;

    switch (operation) {
      case 'complete':
        for (final taskId in taskIds) {
          if (_mockTasks.containsKey(taskId)) {
            final task = _mockTasks[taskId]!;
            _mockTasks[taskId] = Task(
              id: task.id,
              title: task.title,
              description: task.description,
              priority: task.priority,
              category: task.category,
              dueDate: task.dueDate,
              isCompleted: true,
              createdAt: task.createdAt,
              updatedAt: DateTime.now(),
            );
            updatedCount++;
          }
        }
        break;
      case 'delete':
        for (final taskId in taskIds) {
          if (_mockTasks.containsKey(taskId)) {
            _mockTasks.remove(taskId);
            updatedCount++;
          }
        }
        break;
    }

    return {
      'success': true,
      'data': {
        'updatedCount': updatedCount,
        'message': 'Successfully $operation $updatedCount tasks',
      },
    };
  }

  Future<Map<String, dynamic>> _realBulkTaskOperation(String operation, List<String> taskIds) async {
    final response = await _networkService.post('/tasks/bulk', data: {
      'operation': operation,
      'taskIds': taskIds,
    });
    return response.data;
  }

  // ==================== SEARCH APIs ====================

  /// Search tasks
  Future<Map<String, dynamic>> searchTasks(String query, {String? fields, bool? fuzzy}) async {
    if (_useMockApi) {
      return await _mockSearchTasks(query, fields: fields, fuzzy: fuzzy);
    } else {
      return await _realSearchTasks(query, fields: fields, fuzzy: fuzzy);
    }
  }

  Future<Map<String, dynamic>> _mockSearchTasks(String query, {String? fields, bool? fuzzy}) async {
    await Future.delayed(AppConstants.mockApiDelay);
    
    if (_shouldFail) {
      throw Exception('Network error: Failed to search tasks');
    }

    var tasks = _mockTasks.values.toList();

    if (fields == 'title') {
      tasks = tasks.where((task) => task.title.toLowerCase().contains(query.toLowerCase())).toList();
    } else if (fields == 'description') {
      tasks = tasks.where((task) => task.description.toLowerCase().contains(query.toLowerCase())).toList();
    } else {
      tasks = tasks.where((task) =>
          task.title.toLowerCase().contains(query.toLowerCase()) ||
          task.description.toLowerCase().contains(query.toLowerCase())).toList();
    }

    return {
      'success': true,
      'data': {
        'tasks': tasks.map((task) => task.toJson()).toList(),
        'total': tasks.length,
      },
    };
  }

  Future<Map<String, dynamic>> _realSearchTasks(String query, {String? fields, bool? fuzzy}) async {
    final queryParams = <String, dynamic>{
      'q': query,
    };

    if (fields != null) queryParams['fields'] = fields;
    if (fuzzy != null) queryParams['fuzzy'] = fuzzy;

    final response = await _networkService.get('/tasks/search', queryParameters: queryParams);
    return response.data;
  }

  // ==================== ANALYTICS APIs ====================

  /// Get task analytics
  Future<Map<String, dynamic>> getTaskAnalytics() async {
    if (_useMockApi) {
      return await _mockGetTaskAnalytics();
    } else {
      return await _realGetTaskAnalytics();
    }
  }

  Future<Map<String, dynamic>> _mockGetTaskAnalytics() async {
    await Future.delayed(AppConstants.mockApiDelay);
    
    if (_shouldFail) {
      throw Exception('Network error: Failed to fetch analytics');
    }

    final tasks = _mockTasks.values.toList();
    final total = tasks.length;
    final completed = tasks.where((task) => task.isCompleted).length;
    final pending = total - completed;
    final overdue = tasks.where((task) => 
        !task.isCompleted && task.dueDate != null && task.dueDate!.isBefore(DateTime.now())).length;

    final byPriority = <String, int>{};
    for (final task in tasks) {
      final priorityName = _taskPriorityToString(task.priority);
      byPriority[priorityName] = (byPriority[priorityName] ?? 0) + 1;
    }

    final byCategory = <Map<String, dynamic>>[];
    final categoryCount = <String, int>{};
    for (final task in tasks) {
      categoryCount[task.category] = (categoryCount[task.category] ?? 0) + 1;
    }
    categoryCount.forEach((category, count) {
      byCategory.add({'category': category, 'count': count});
    });

    final completionRate = total > 0 ? (completed / total) * 100 : 0.0;

    return {
      'success': true,
      'data': {
        'total': total,
        'completed': completed,
        'pending': pending,
        'overdue': overdue,
        'byPriority': byPriority,
        'byCategory': byCategory,
        'completionRate': completionRate,
      },
    };
  }

  Future<Map<String, dynamic>> _realGetTaskAnalytics() async {
    final response = await _networkService.get('/tasks/analytics');
    return response.data;
  }

  // ==================== FEEDBACK APIs ====================

  /// Submit feedback
  Future<Map<String, dynamic>> submitFeedback(Map<String, dynamic> feedbackData) async {
    if (_useMockApi) {
      return await _mockSubmitFeedback(feedbackData);
    } else {
      return await _realSubmitFeedback(feedbackData);
    }
  }

  Future<Map<String, dynamic>> _mockSubmitFeedback(Map<String, dynamic> feedbackData) async {
    await Future.delayed(AppConstants.mockApiDelay);
    
    if (_shouldFail) {
      throw Exception('Network error: Failed to submit feedback');
    }

    final feedbackId = 'feedback_${DateTime.now().millisecondsSinceEpoch}';
    final now = DateTime.now();

    final feedback = {
      'id': feedbackId,
      'rating': feedbackData['rating'],
      'comment': feedbackData['comment'],
      'category': feedbackData['category'] ?? 'general',
      'createdAt': now.toIso8601String(),
    };

    _mockFeedback.add(feedback);

    return {
      'success': true,
      'data': feedback,
    };
  }

  Future<Map<String, dynamic>> _realSubmitFeedback(Map<String, dynamic> feedbackData) async {
    final response = await _networkService.post('/feedback', data: feedbackData);
    return response.data;
  }

  /// Get feedback history
  Future<Map<String, dynamic>> getFeedbackHistory() async {
    if (_useMockApi) {
      return await _mockGetFeedbackHistory();
    } else {
      return await _realGetFeedbackHistory();
    }
  }

  Future<Map<String, dynamic>> _mockGetFeedbackHistory() async {
    await Future.delayed(AppConstants.mockApiDelay);
    
    if (_shouldFail) {
      throw Exception('Network error: Failed to fetch feedback history');
    }

    return {
      'success': true,
      'data': _mockFeedback,
    };
  }

  Future<Map<String, dynamic>> _realGetFeedbackHistory() async {
    final response = await _networkService.get('/feedback');
    return response.data;
  }

  // ==================== UTILITY METHODS ====================

  /// Convert string to TaskPriority enum
  TaskPriority _stringToTaskPriority(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return TaskPriority.high;
      case 'low':
        return TaskPriority.low;
      case 'medium':
      default:
        return TaskPriority.medium;
    }
  }

  /// Convert TaskPriority enum to string
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

  /// Clear all mock data (for testing)
  void clearMockData() {
    _mockTasks.clear();
    _mockCategories.clear();
    _mockFeedback.clear();
    _initializeMockData();
  }

  /// Get mock data statistics
  Map<String, int> getMockDataStats() {
    return {
      'tasks': _mockTasks.length,
      'categories': _mockCategories.length,
      'feedback': _mockFeedback.length,
    };
  }

  /// Dispose resources
  void dispose() {
    _networkService.dispose();
  }
} 