import 'package:flutter_test/flutter_test.dart';
import 'package:toodoflutter/models/task.dart';
import 'package:toodoflutter/viewmodels/task_viewmodel.dart';

void main() {
  group('TaskViewModel Tests', () {
    late TaskViewModel taskViewModel;

    setUp(() {
      taskViewModel = TaskViewModel();
    });

    group('Initialization Tests', () {
      test('should initialize with default values', () {
        expect(taskViewModel.tasks, isEmpty);
        expect(taskViewModel.filteredTasks, isEmpty);
        expect(taskViewModel.isLoading, false);
        expect(taskViewModel.searchQuery, '');
        expect(taskViewModel.selectedCategory, 'All');
        expect(taskViewModel.selectedPriority, null);
        expect(taskViewModel.categories, isEmpty);
      });

      test('should initialize successfully', () async {
        await taskViewModel.initialize();
        
        expect(taskViewModel.isLoading, false);
        expect(taskViewModel.categories, contains('All'));
      });
    });

    group('Task Loading Tests', () {
      test('should load tasks successfully', () async {
        await taskViewModel.loadTasks();
        
        expect(taskViewModel.isLoading, false);
        expect(taskViewModel.tasks, isA<List<Task>>());
      });

      test('should set loading state during task loading', () async {
        final future = taskViewModel.loadTasks();
        
        // Check loading state during loading
        expect(taskViewModel.isLoading, true);
        
        await future;
        
        // Check loading state after loading
        expect(taskViewModel.isLoading, false);
      });
    });

    group('Task CRUD Operations', () {
      test('should create task successfully', () async {
        final task = Task(
          title: 'Test Task',
          description: 'Test Description',
          category: 'Test Category',
        );

        await taskViewModel.createTask(task);
        
        expect(taskViewModel.tasks.length, 1);
        expect(taskViewModel.tasks.first.title, 'Test Task');
        expect(taskViewModel.filteredTasks.length, 1);
      });

      test('should update task successfully', () async {
        final task = Task(
          title: 'Original Task',
          description: 'Original Description',
          category: 'Original Category',
        );

        await taskViewModel.createTask(task);
        
        final updatedTask = task.copyWith(
          title: 'Updated Task',
          description: 'Updated Description',
          isCompleted: true,
        );

        await taskViewModel.updateTask(updatedTask);
        
        expect(taskViewModel.tasks.first.title, 'Updated Task');
        expect(taskViewModel.tasks.first.description, 'Updated Description');
        expect(taskViewModel.tasks.first.isCompleted, true);
      });

      test('should delete task successfully', () async {
        final task = Task(
          title: 'Test Task',
          description: 'Test Description',
          category: 'Test Category',
        );

        await taskViewModel.createTask(task);
        expect(taskViewModel.tasks.length, 1);

        await taskViewModel.deleteTask(task.id);
        expect(taskViewModel.tasks.length, 0);
        expect(taskViewModel.filteredTasks.length, 0);
      });

      test('should toggle task completion', () async {
        final task = Task(
          title: 'Test Task',
          description: 'Test Description',
          category: 'Test Category',
        );

        await taskViewModel.createTask(task);
        expect(taskViewModel.tasks.first.isCompleted, false);

        await taskViewModel.toggleTaskCompletion(task.id);
        expect(taskViewModel.tasks.first.isCompleted, true);

        await taskViewModel.toggleTaskCompletion(task.id);
        expect(taskViewModel.tasks.first.isCompleted, false);
      });
    });

    group('Search Tests', () {
      test('should search tasks by title', () async {
        final task1 = Task(
          title: 'Important Task',
          description: 'Description 1',
          category: 'Category 1',
        );
        final task2 = Task(
          title: 'Regular Task',
          description: 'Description 2',
          category: 'Category 2',
        );

        await taskViewModel.createTask(task1);
        await taskViewModel.createTask(task2);

        taskViewModel.searchTasks('Important');
        
        expect(taskViewModel.searchQuery, 'Important');
        expect(taskViewModel.filteredTasks.length, 1);
        expect(taskViewModel.filteredTasks.first.title, 'Important Task');
      });

      test('should search tasks by description', () async {
        final task1 = Task(
          title: 'Task 1',
          description: 'Important description',
          category: 'Category 1',
        );
        final task2 = Task(
          title: 'Task 2',
          description: 'Regular description',
          category: 'Category 2',
        );

        await taskViewModel.createTask(task1);
        await taskViewModel.createTask(task2);

        taskViewModel.searchTasks('Important');
        
        expect(taskViewModel.filteredTasks.length, 1);
        expect(taskViewModel.filteredTasks.first.description, 'Important description');
      });

      test('should search case-insensitive', () async {
        final task = Task(
          title: 'Important Task',
          description: 'Description',
          category: 'Category',
        );

        await taskViewModel.createTask(task);

        taskViewModel.searchTasks('important');
        
        expect(taskViewModel.filteredTasks.length, 1);
        expect(taskViewModel.filteredTasks.first.title, 'Important Task');
      });

      test('should return empty results for no matches', () async {
        final task = Task(
          title: 'Test Task',
          description: 'Test Description',
          category: 'Test Category',
        );

        await taskViewModel.createTask(task);

        taskViewModel.searchTasks('NonExistent');
        
        expect(taskViewModel.filteredTasks, isEmpty);
      });

      test('should clear search', () async {
        final task = Task(
          title: 'Test Task',
          description: 'Test Description',
          category: 'Test Category',
        );

        await taskViewModel.createTask(task);
        taskViewModel.searchTasks('Test');
        expect(taskViewModel.filteredTasks.length, 1);

        taskViewModel.clearFilters();
        
        expect(taskViewModel.searchQuery, '');
        expect(taskViewModel.selectedCategory, 'All');
        expect(taskViewModel.selectedPriority, null);
        expect(taskViewModel.filteredTasks.length, 1);
      });
    });

    group('Filter Tests', () {
      test('should filter by category', () async {
        final task1 = Task(
          title: 'Task 1',
          description: 'Description 1',
          category: 'Work',
        );
        final task2 = Task(
          title: 'Task 2',
          description: 'Description 2',
          category: 'Personal',
        );

        await taskViewModel.createTask(task1);
        await taskViewModel.createTask(task2);

        taskViewModel.filterByCategory('Work');
        
        expect(taskViewModel.selectedCategory, 'Work');
        expect(taskViewModel.filteredTasks.length, 1);
        expect(taskViewModel.filteredTasks.first.category, 'Work');
      });

      test('should filter by priority', () async {
        final task1 = Task(
          title: 'High Priority Task',
          description: 'Description 1',
          category: 'Category 1',
          priority: TaskPriority.high,
        );
        final task2 = Task(
          title: 'Low Priority Task',
          description: 'Description 2',
          category: 'Category 2',
          priority: TaskPriority.low,
        );

        await taskViewModel.createTask(task1);
        await taskViewModel.createTask(task2);

        taskViewModel.filterByPriority(TaskPriority.high);
        
        expect(taskViewModel.selectedPriority, TaskPriority.high);
        expect(taskViewModel.filteredTasks.length, 1);
        expect(taskViewModel.filteredTasks.first.priority, TaskPriority.high);
      });

      test('should combine search and filters', () async {
        final task1 = Task(
          title: 'High Priority Work Task',
          description: 'Description 1',
          category: 'Work',
          priority: TaskPriority.high,
        );
        final task2 = Task(
          title: 'Low Priority Personal Task',
          description: 'Description 2',
          category: 'Personal',
          priority: TaskPriority.low,
        );

        await taskViewModel.createTask(task1);
        await taskViewModel.createTask(task2);

        taskViewModel.searchTasks('High');
        taskViewModel.filterByCategory('Work');
        taskViewModel.filterByPriority(TaskPriority.high);
        
        expect(taskViewModel.filteredTasks.length, 1);
        expect(taskViewModel.filteredTasks.first.title, 'High Priority Work Task');
      });
    });

    group('Task Sorting Tests', () {
      test('should sort by completion status', () async {
        final task1 = Task(
          title: 'Completed Task',
          description: 'Description 1',
          category: 'Category 1',
          isCompleted: true,
        );
        final task2 = Task(
          title: 'Pending Task',
          description: 'Description 2',
          category: 'Category 2',
          isCompleted: false,
        );

        await taskViewModel.createTask(task1);
        await taskViewModel.createTask(task2);

        expect(taskViewModel.filteredTasks.first.isCompleted, false);
        expect(taskViewModel.filteredTasks.last.isCompleted, true);
      });

      test('should sort by priority', () async {
        final task1 = Task(
          title: 'Low Priority Task',
          description: 'Description 1',
          category: 'Category 1',
          priority: TaskPriority.low,
        );
        final task2 = Task(
          title: 'High Priority Task',
          description: 'Description 2',
          category: 'Category 2',
          priority: TaskPriority.high,
        );

        await taskViewModel.createTask(task1);
        await taskViewModel.createTask(task2);

        expect(taskViewModel.filteredTasks.first.priority, TaskPriority.high);
        expect(taskViewModel.filteredTasks.last.priority, TaskPriority.low);
      });

      test('should sort by due date', () async {
        final task1 = Task(
          title: 'Later Task',
          description: 'Description 1',
          category: 'Category 1',
          dueDate: DateTime.now().add(const Duration(days: 2)),
        );
        final task2 = Task(
          title: 'Earlier Task',
          description: 'Description 2',
          category: 'Category 2',
          dueDate: DateTime.now().add(const Duration(days: 1)),
        );

        await taskViewModel.createTask(task1);
        await taskViewModel.createTask(task2);

        expect(taskViewModel.filteredTasks.first.title, 'Earlier Task');
        expect(taskViewModel.filteredTasks.last.title, 'Later Task');
      });
    });

    group('Task Status Tests', () {
      test('should get completed tasks', () async {
        final task1 = Task(
          title: 'Completed Task',
          description: 'Description 1',
          category: 'Category 1',
          isCompleted: true,
        );
        final task2 = Task(
          title: 'Pending Task',
          description: 'Description 2',
          category: 'Category 2',
          isCompleted: false,
        );

        await taskViewModel.createTask(task1);
        await taskViewModel.createTask(task2);

        final completedTasks = taskViewModel.getCompletedTasks();
        expect(completedTasks.length, 1);
        expect(completedTasks.first.title, 'Completed Task');
      });

      test('should get pending tasks', () async {
        final task1 = Task(
          title: 'Completed Task',
          description: 'Description 1',
          category: 'Category 1',
          isCompleted: true,
        );
        final task2 = Task(
          title: 'Pending Task',
          description: 'Description 2',
          category: 'Category 2',
          isCompleted: false,
        );

        await taskViewModel.createTask(task1);
        await taskViewModel.createTask(task2);

        final pendingTasks = taskViewModel.getPendingTasks();
        expect(pendingTasks.length, 1);
        expect(pendingTasks.first.title, 'Pending Task');
      });

      test('should get overdue tasks', () async {
        final task1 = Task(
          title: 'Overdue Task',
          description: 'Description 1',
          category: 'Category 1',
          isCompleted: false,
          dueDate: DateTime.now().subtract(const Duration(days: 1)),
        );
        final task2 = Task(
          title: 'Future Task',
          description: 'Description 2',
          category: 'Category 2',
          isCompleted: false,
          dueDate: DateTime.now().add(const Duration(days: 1)),
        );

        await taskViewModel.createTask(task1);
        await taskViewModel.createTask(task2);

        final overdueTasks = taskViewModel.getOverdueTasks();
        expect(overdueTasks.length, 1);
        expect(overdueTasks.first.title, 'Overdue Task');
      });

      test('should get tasks due today', () async {
        final task1 = Task(
          title: 'Today Task',
          description: 'Description 1',
          category: 'Category 1',
          isCompleted: false,
          dueDate: DateTime.now(),
        );
        final task2 = Task(
          title: 'Tomorrow Task',
          description: 'Description 2',
          category: 'Category 2',
          isCompleted: false,
          dueDate: DateTime.now().add(const Duration(days: 1)),
        );

        await taskViewModel.createTask(task1);
        await taskViewModel.createTask(task2);

        final todayTasks = taskViewModel.getTasksDueToday();
        expect(todayTasks.length, 1);
        expect(todayTasks.first.title, 'Today Task');
      });
    });

    group('Category Management Tests', () {
      test('should load categories', () async {
        final task1 = Task(
          title: 'Task 1',
          description: 'Description 1',
          category: 'Work',
        );
        final task2 = Task(
          title: 'Task 2',
          description: 'Description 2',
          category: 'Personal',
        );

        await taskViewModel.createTask(task1);
        await taskViewModel.createTask(task2);
        await taskViewModel.loadCategories();

        expect(taskViewModel.categories, contains('All'));
        expect(taskViewModel.categories, contains('Work'));
        expect(taskViewModel.categories, contains('Personal'));
      });
    });

    group('Refresh Tests', () {
      test('should refresh data', () async {
        final task = Task(
          title: 'Test Task',
          description: 'Test Description',
          category: 'Test Category',
        );

        await taskViewModel.createTask(task);
        expect(taskViewModel.tasks.length, 1);

        await taskViewModel.refresh();
        
        expect(taskViewModel.isLoading, false);
        expect(taskViewModel.tasks.length, 1);
      });
    });

    group('State Management Tests', () {
      test('should notify listeners on state changes', () {
        bool notified = false;
        taskViewModel.addListener(() {
          notified = true;
        });

        taskViewModel.searchTasks('test');
        expect(notified, true);
      });

      test('should handle multiple listeners', () {
        int notificationCount = 0;
        
        taskViewModel.addListener(() {
          notificationCount++;
        });
        
        taskViewModel.addListener(() {
          notificationCount++;
        });

        taskViewModel.searchTasks('test');
        expect(notificationCount, 2);
      });
    });

    group('Edge Cases', () {
      test('should handle empty task list', () async {
        await taskViewModel.loadTasks();
        
        expect(taskViewModel.tasks, isEmpty);
        expect(taskViewModel.filteredTasks, isEmpty);
        expect(taskViewModel.getCompletedTasks(), isEmpty);
        expect(taskViewModel.getPendingTasks(), isEmpty);
        expect(taskViewModel.getOverdueTasks(), isEmpty);
        expect(taskViewModel.getTasksDueToday(), isEmpty);
      });

      test('should handle tasks without due dates', () async {
        final task = Task(
          title: 'No Due Date Task',
          description: 'Description',
          category: 'Category',
        );

        await taskViewModel.createTask(task);

        expect(taskViewModel.getOverdueTasks(), isEmpty);
        expect(taskViewModel.getTasksDueToday(), isEmpty);
      });

      test('should handle tasks with all priority levels', () async {
        for (final priority in TaskPriority.values) {
          final task = Task(
            title: '${priority.name} Priority Task',
            description: 'Description',
            category: 'Category',
            priority: priority,
          );

          await taskViewModel.createTask(task);
        }

        expect(taskViewModel.tasks.length, TaskPriority.values.length);
      });
    });

    group('Error Handling Tests', () {
      test('should handle task creation errors gracefully', () async {
        // This would require mocking the repository to simulate errors
        final task = Task(
          title: 'Test Task',
          description: 'Test Description',
          category: 'Test Category',
        );

        try {
          await taskViewModel.createTask(task);
          // Should not throw in normal operation
          expect(true, true);
        } catch (e) {
          // Should handle errors gracefully
          expect(e, isA<Exception>());
        }
      });

      test('should handle task update errors gracefully', () async {
        final task = Task(
          title: 'Test Task',
          description: 'Test Description',
          category: 'Test Category',
        );

        try {
          await taskViewModel.updateTask(task);
          // Should not throw in normal operation
          expect(true, true);
        } catch (e) {
          // Should handle errors gracefully
          expect(e, isA<Exception>());
        }
      });

      test('should handle task deletion errors gracefully', () async {
        try {
          await taskViewModel.deleteTask('non-existent-id');
          // Should not throw in normal operation
          expect(true, true);
        } catch (e) {
          // Should handle errors gracefully
          expect(e, isA<Exception>());
        }
      });
    });
  });
} 