import 'package:flutter/foundation.dart';
import '../models/task.dart';
import '../repositories/task_repository.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskRepository _repository = TaskRepository();
  
  List<Task> _tasks = [];
  List<Task> _filteredTasks = [];
  bool _isLoading = false;
  String _searchQuery = '';
  String _selectedCategory = 'All';
  TaskPriority? _selectedPriority;
  List<String> _categories = [];

  // Getters
  List<Task> get tasks => _tasks;
  List<Task> get filteredTasks => _filteredTasks;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;
  TaskPriority? get selectedPriority => _selectedPriority;
  List<String> get categories => _categories;

  // Initialize
  Future<void> initialize() async {
    await loadTasks();
    await loadCategories();
  }

  // Load tasks
  Future<void> loadTasks() async {
    _setLoading(true);
    try {
      _tasks = await _repository.getAllTasks();
      _applyFilters();
    } catch (e) {
      // Handle error
      print('Error loading tasks: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Load categories
  Future<void> loadCategories() async {
    try {
      _categories = await _repository.getAllCategories();
      _categories.insert(0, 'All');
    } catch (e) {
      print('Error loading categories: $e');
    }
  }

  // Create task
  Future<void> createTask(Task task) async {
    try {
      await _repository.createTask(task);
      await loadTasks();
    } catch (e) {
      print('Error creating task: $e');
      rethrow;
    }
  }

  // Update task
  Future<void> updateTask(Task task) async {
    try {
      await _repository.updateTask(task);
      await loadTasks();
    } catch (e) {
      print('Error updating task: $e');
      rethrow;
    }
  }

  // Delete task
  Future<void> deleteTask(String id) async {
    try {
      await _repository.deleteTask(id);
      await loadTasks();
    } catch (e) {
      print('Error deleting task: $e');
      rethrow;
    }
  }

  // Toggle task completion
  Future<void> toggleTaskCompletion(String id) async {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      final task = _tasks[taskIndex];
      final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
      await updateTask(updatedTask);
    }
  }

  // Search tasks
  void searchTasks(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  // Filter by category
  void filterByCategory(String category) {
    _selectedCategory = category;
    _applyFilters();
  }

  // Filter by priority
  void filterByPriority(TaskPriority? priority) {
    _selectedPriority = priority;
    _applyFilters();
  }

  // Clear filters
  void clearFilters() {
    _searchQuery = '';
    _selectedCategory = 'All';
    _selectedPriority = null;
    _applyFilters();
  }

  // Apply filters
  void _applyFilters() {
    _filteredTasks = _tasks.where((task) {
      // Search filter
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        if (!task.title.toLowerCase().contains(query) &&
            !task.description.toLowerCase().contains(query)) {
          return false;
        }
      }

      // Category filter
      if (_selectedCategory != 'All' && task.category != _selectedCategory) {
        return false;
      }

      // Priority filter
      if (_selectedPriority != null && task.priority != _selectedPriority) {
        return false;
      }

      return true;
    }).toList();

    // Sort by priority and due date
    _filteredTasks.sort((a, b) {
      // First sort by completion status
      if (a.isCompleted != b.isCompleted) {
        return a.isCompleted ? 1 : -1;
      }
      
      // Then sort by priority (high to low)
      if (a.priority != b.priority) {
        return b.priority.index.compareTo(a.priority.index);
      }
      
      // Then sort by due date (earliest first)
      if (a.dueDate != null && b.dueDate != null) {
        return a.dueDate!.compareTo(b.dueDate!);
      } else if (a.dueDate != null) {
        return -1;
      } else if (b.dueDate != null) {
        return 1;
      }
      
      // Finally sort by creation date (newest first)
      return b.createdAt.compareTo(a.createdAt);
    });

    notifyListeners();
  }

  // Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Get tasks by completion status
  List<Task> getCompletedTasks() {
    return _filteredTasks.where((task) => task.isCompleted).toList();
  }

  List<Task> getPendingTasks() {
    return _filteredTasks.where((task) => !task.isCompleted).toList();
  }

  // Get overdue tasks
  List<Task> getOverdueTasks() {
    final now = DateTime.now();
    return _filteredTasks.where((task) {
      return !task.isCompleted && 
             task.dueDate != null && 
             task.dueDate!.isBefore(now);
    }).toList();
  }

  // Get tasks due today
  List<Task> getTasksDueToday() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return _filteredTasks.where((task) {
      return !task.isCompleted && 
             task.dueDate != null && 
             task.dueDate!.isAtSameMomentAs(today);
    }).toList();
  }

  // Refresh data
  Future<void> refresh() async {
    await loadTasks();
    await loadCategories();
  }
} 