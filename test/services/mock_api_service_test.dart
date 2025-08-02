import 'package:flutter_test/flutter_test.dart';
import 'package:toodoflutter/models/task.dart';
import 'package:toodoflutter/services/mock_api_service.dart';

void main() {
  group('MockApiService Tests', () {
    late MockApiService apiService;

    setUp(() {
      apiService = MockApiService();
    });

    tearDown(() {
      apiService.clearMockData();
    });

    group('Task CRUD Operations', () {
      test('should create task successfully', () async {
        final task = Task(
          title: 'Test Task',
          description: 'Test Description',
          category: 'Test Category',
        );

        await apiService.createTask(task);

        final tasks = await apiService.getAllTasks();
        expect(tasks.length, 1);
        expect(tasks.first.title, 'Test Task');
        expect(tasks.first.description, 'Test Description');
        expect(tasks.first.category, 'Test Category');
      });

      test('should get all tasks', () async {
        final task1 = Task(
          title: 'Task 1',
          description: 'Description 1',
          category: 'Category 1',
        );
        final task2 = Task(
          title: 'Task 2',
          description: 'Description 2',
          category: 'Category 2',
        );

        await apiService.createTask(task1);
        await apiService.createTask(task2);

        final tasks = await apiService.getAllTasks();
        expect(tasks.length, 2);
        expect(tasks.any((t) => t.title == 'Task 1'), true);
        expect(tasks.any((t) => t.title == 'Task 2'), true);
      });

      test('should get task by id', () async {
        final task = Task(
          title: 'Test Task',
          description: 'Test Description',
          category: 'Test Category',
        );

        await apiService.createTask(task);

        final retrievedTask = await apiService.getTask(task.id);
        expect(retrievedTask, isNotNull);
        expect(retrievedTask!.title, 'Test Task');
        expect(retrievedTask.description, 'Test Description');
        expect(retrievedTask.category, 'Test Category');
      });

      test('should return null for non-existent task', () async {
        final task = await apiService.getTask('non-existent-id');
        expect(task, null);
      });

      test('should update task successfully', () async {
        final task = Task(
          title: 'Original Task',
          description: 'Original Description',
          category: 'Original Category',
        );

        await apiService.createTask(task);

        final updatedTask = task.copyWith(
          title: 'Updated Task',
          description: 'Updated Description',
          isCompleted: true,
        );

        await apiService.updateTask(updatedTask);

        final retrievedTask = await apiService.getTask(task.id);
        expect(retrievedTask, isNotNull);
        expect(retrievedTask!.title, 'Updated Task');
        expect(retrievedTask.description, 'Updated Description');
        expect(retrievedTask.isCompleted, true);
      });

      test('should throw exception when updating non-existent task', () async {
        final task = Task(
          id: 'non-existent-id',
          title: 'Test Task',
          description: 'Test Description',
          category: 'Test Category',
        );

        expect(
          () => apiService.updateTask(task),
          throwsA(isA<Exception>()),
        );
      });

      test('should delete task successfully', () async {
        final task = Task(
          title: 'Test Task',
          description: 'Test Description',
          category: 'Test Category',
        );

        await apiService.createTask(task);
        expect(await apiService.getAllTasks(), hasLength(1));

        await apiService.deleteTask(task.id);
        expect(await apiService.getAllTasks(), hasLength(0));
      });

      test('should throw exception when deleting non-existent task', () async {
        expect(
          () => apiService.deleteTask('non-existent-id'),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('Search Operations', () {
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

        await apiService.createTask(task1);
        await apiService.createTask(task2);

        final results = await apiService.searchTasks('Important');
        expect(results.length, 1);
        expect(results.first.title, 'Important Task');
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

        await apiService.createTask(task1);
        await apiService.createTask(task2);

        final results = await apiService.searchTasks('Important');
        expect(results.length, 1);
        expect(results.first.description, 'Important description');
      });

      test('should search case-insensitive', () async {
        final task = Task(
          title: 'Important Task',
          description: 'Description',
          category: 'Category',
        );

        await apiService.createTask(task);

        final results = await apiService.searchTasks('important');
        expect(results.length, 1);
        expect(results.first.title, 'Important Task');
      });

      test('should return empty list for no matches', () async {
        final task = Task(
          title: 'Test Task',
          description: 'Test Description',
          category: 'Test Category',
        );

        await apiService.createTask(task);

        final results = await apiService.searchTasks('NonExistent');
        expect(results, isEmpty);
      });
    });

    group('Category Operations', () {
      test('should get tasks by category', () async {
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
        final task3 = Task(
          title: 'Task 3',
          description: 'Description 3',
          category: 'Work',
        );

        await apiService.createTask(task1);
        await apiService.createTask(task2);
        await apiService.createTask(task3);

        final workTasks = await apiService.getTasksByCategory('Work');
        expect(workTasks.length, 2);
        expect(workTasks.every((t) => t.category == 'Work'), true);

        final personalTasks = await apiService.getTasksByCategory('Personal');
        expect(personalTasks.length, 1);
        expect(personalTasks.first.category, 'Personal');
      });

      test('should return empty list for non-existent category', () async {
        final task = Task(
          title: 'Test Task',
          description: 'Test Description',
          category: 'Work',
        );

        await apiService.createTask(task);

        final results = await apiService.getTasksByCategory('NonExistent');
        expect(results, isEmpty);
      });
    });

    group('Feedback Operations', () {
      test('should submit feedback successfully', () async {
        await apiService.submitFeedback(
          userId: 'test-user',
          rating: 5,
          feedback: 'Great app!',
        );

        // Since this is a mock service, we just verify it doesn't throw
        expect(true, true);
      });

      test('should submit rating successfully', () async {
        await apiService.submitRating(
          userId: 'test-user',
          rating: 4,
        );

        // Since this is a mock service, we just verify it doesn't throw
        expect(true, true);
      });
    });

    group('Network Simulation', () {
      test('should simulate network delay', () async {
        final stopwatch = Stopwatch()..start();
        
        await apiService.getAllTasks();
        
        stopwatch.stop();
        expect(stopwatch.elapsed.inMilliseconds, greaterThan(400));
      });

      test('should occasionally fail requests', () async {
        int successCount = 0;
        int failureCount = 0;
        
        for (int i = 0; i < 100; i++) {
          try {
            await apiService.getAllTasks();
            successCount++;
          } catch (e) {
            failureCount++;
          }
        }
        
        expect(successCount, greaterThan(0));
        expect(failureCount, greaterThan(0));
        expect(successCount + failureCount, 100);
      });
    });

    group('Data Management', () {
      test('should clear mock data', () async {
        final task = Task(
          title: 'Test Task',
          description: 'Test Description',
          category: 'Test Category',
        );

        await apiService.createTask(task);
        expect(apiService.mockDataCount, 1);

        apiService.clearMockData();
        expect(apiService.mockDataCount, 0);
        expect(await apiService.getAllTasks(), isEmpty);
      });

      test('should return correct mock data count', () async {
        expect(apiService.mockDataCount, 0);

        final task1 = Task(
          title: 'Task 1',
          description: 'Description 1',
          category: 'Category 1',
        );
        final task2 = Task(
          title: 'Task 2',
          description: 'Description 2',
          category: 'Category 2',
        );

        await apiService.createTask(task1);
        expect(apiService.mockDataCount, 1);

        await apiService.createTask(task2);
        expect(apiService.mockDataCount, 2);
      });
    });

    group('Edge Cases', () {
      test('should handle empty task list', () async {
        final tasks = await apiService.getAllTasks();
        expect(tasks, isEmpty);
      });

      test('should handle tasks with null due date', () async {
        final task = Task(
          title: 'Test Task',
          description: 'Test Description',
          category: 'Test Category',
        );

        await apiService.createTask(task);
        final retrievedTask = await apiService.getTask(task.id);
        
        expect(retrievedTask!.dueDate, null);
      });

      test('should handle tasks with due date', () async {
        final dueDate = DateTime.now().add(const Duration(days: 1));
        final task = Task(
          title: 'Test Task',
          description: 'Test Description',
          category: 'Test Category',
          dueDate: dueDate,
        );

        await apiService.createTask(task);
        final retrievedTask = await apiService.getTask(task.id);
        
        expect(retrievedTask!.dueDate, dueDate);
      });

      test('should handle all priority levels', () async {
        for (final priority in TaskPriority.values) {
          final task = Task(
            title: 'Test Task',
            description: 'Test Description',
            category: 'Test Category',
            priority: priority,
          );

          await apiService.createTask(task);
          final retrievedTask = await apiService.getTask(task.id);
          
          expect(retrievedTask!.priority, priority);
        }
      });
    });

    group('Concurrent Operations', () {
      test('should handle concurrent task creation', () async {
        final tasks = List.generate(10, (index) => Task(
          title: 'Task $index',
          description: 'Description $index',
          category: 'Category $index',
        ));

        final futures = tasks.map((task) => apiService.createTask(task));
        await Future.wait(futures);

        final allTasks = await apiService.getAllTasks();
        expect(allTasks.length, 10);
      });

      test('should handle concurrent read operations', () async {
        final task = Task(
          title: 'Test Task',
          description: 'Test Description',
          category: 'Test Category',
        );

        await apiService.createTask(task);

        final futures = List.generate(10, (_) => apiService.getAllTasks());
        final results = await Future.wait(futures);

        for (final result in results) {
          expect(result.length, 1);
          expect(result.first.title, 'Test Task');
        }
      });
    });

    group('Error Handling', () {
      test('should handle network errors gracefully', () async {
        // The mock service simulates network errors randomly
        // We test that it doesn't crash the app
        for (int i = 0; i < 10; i++) {
          try {
            await apiService.getAllTasks();
          } catch (e) {
            expect(e, isA<Exception>());
            expect(e.toString(), contains('Network error'));
          }
        }
      });
    });
  });
} 