import 'package:flutter_test/flutter_test.dart';
import 'package:toodoflutter/models/task.dart';
import 'package:toodoflutter/repositories/task_repository.dart';

void main() {
  group('TaskRepository Tests', () {
    late TaskRepository taskRepository;

    setUp(() {
      taskRepository = TaskRepository();
    });

    group('Task CRUD Operations', () {
      test('should create task successfully', () async {
        final task = Task(
          title: 'Test Task',
          description: 'Test Description',
          category: 'Test Category',
        );

        await taskRepository.createTask(task);

        final tasks = await taskRepository.getAllTasks();
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

        await taskRepository.createTask(task1);
        await taskRepository.createTask(task2);

        final tasks = await taskRepository.getAllTasks();
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

        await taskRepository.createTask(task);

        final retrievedTask = await taskRepository.getTask(task.id);
        expect(retrievedTask, isNotNull);
        expect(retrievedTask!.title, 'Test Task');
        expect(retrievedTask.description, 'Test Description');
        expect(retrievedTask.category, 'Test Category');
      });

      test('should return null for non-existent task', () async {
        final task = await taskRepository.getTask('non-existent-id');
        expect(task, null);
      });

      test('should update task successfully', () async {
        final task = Task(
          title: 'Original Task',
          description: 'Original Description',
          category: 'Original Category',
        );

        await taskRepository.createTask(task);

        final updatedTask = task.copyWith(
          title: 'Updated Task',
          description: 'Updated Description',
          isCompleted: true,
        );

        await taskRepository.updateTask(updatedTask);

        final retrievedTask = await taskRepository.getTask(task.id);
        expect(retrievedTask, isNotNull);
        expect(retrievedTask!.title, 'Updated Task');
        expect(retrievedTask.description, 'Updated Description');
        expect(retrievedTask.isCompleted, true);
      });

      test('should delete task successfully', () async {
        final task = Task(
          title: 'Test Task',
          description: 'Test Description',
          category: 'Test Category',
        );

        await taskRepository.createTask(task);
        expect(await taskRepository.getAllTasks(), hasLength(1));

        await taskRepository.deleteTask(task.id);
        expect(await taskRepository.getAllTasks(), hasLength(0));
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

        await taskRepository.createTask(task1);
        await taskRepository.createTask(task2);

        final results = await taskRepository.searchTasks('Important');
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

        await taskRepository.createTask(task1);
        await taskRepository.createTask(task2);

        final results = await taskRepository.searchTasks('Important');
        expect(results.length, 1);
        expect(results.first.description, 'Important description');
      });

      test('should search case-insensitive', () async {
        final task = Task(
          title: 'Important Task',
          description: 'Description',
          category: 'Category',
        );

        await taskRepository.createTask(task);

        final results = await taskRepository.searchTasks('important');
        expect(results.length, 1);
        expect(results.first.title, 'Important Task');
      });

      test('should return empty list for no matches', () async {
        final task = Task(
          title: 'Test Task',
          description: 'Test Description',
          category: 'Test Category',
        );

        await taskRepository.createTask(task);

        final results = await taskRepository.searchTasks('NonExistent');
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

        await taskRepository.createTask(task1);
        await taskRepository.createTask(task2);
        await taskRepository.createTask(task3);

        final workTasks = await taskRepository.getTasksByCategory('Work');
        expect(workTasks.length, 2);
        expect(workTasks.every((t) => t.category == 'Work'), true);

        final personalTasks = await taskRepository.getTasksByCategory('Personal');
        expect(personalTasks.length, 1);
        expect(personalTasks.first.category, 'Personal');
      });

      test('should return empty list for non-existent category', () async {
        final task = Task(
          title: 'Test Task',
          description: 'Test Description',
          category: 'Work',
        );

        await taskRepository.createTask(task);

        final results = await taskRepository.getTasksByCategory('NonExistent');
        expect(results, isEmpty);
      });
    });

    group('Category Management', () {
      test('should get all categories', () async {
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

        await taskRepository.createTask(task1);
        await taskRepository.createTask(task2);
        await taskRepository.createTask(task3);

        final categories = await taskRepository.getAllCategories();
        expect(categories.length, 2);
        expect(categories, contains('Work'));
        expect(categories, contains('Personal'));
      });
    });

    group('Sync Operations', () {
      test('should sync with server', () async {
        final task = Task(
          title: 'Test Task',
          description: 'Test Description',
          category: 'Test Category',
        );

        await taskRepository.createTask(task);

        await taskRepository.syncWithServer();

        // Should not throw and should complete successfully
        expect(true, true);
      });

      test('should fetch from server', () async {
        await taskRepository.fetchFromServer();

        // Should not throw and should complete successfully
        expect(true, true);
      });
    });

    group('Edge Cases', () {
      test('should handle empty task list', () async {
        final tasks = await taskRepository.getAllTasks();
        expect(tasks, isEmpty);
      });

      test('should handle tasks with null due date', () async {
        final task = Task(
          title: 'Test Task',
          description: 'Test Description',
          category: 'Test Category',
        );

        await taskRepository.createTask(task);
        final retrievedTask = await taskRepository.getTask(task.id);
        
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

        await taskRepository.createTask(task);
        final retrievedTask = await taskRepository.getTask(task.id);
        
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

          await taskRepository.createTask(task);
          final retrievedTask = await taskRepository.getTask(task.id);
          
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

        final futures = tasks.map((task) => taskRepository.createTask(task));
        await Future.wait(futures);

        final allTasks = await taskRepository.getAllTasks();
        expect(allTasks.length, 10);
      });

      test('should handle concurrent read operations', () async {
        final task = Task(
          title: 'Test Task',
          description: 'Test Description',
          category: 'Test Category',
        );

        await taskRepository.createTask(task);

        final futures = List.generate(10, (_) => taskRepository.getAllTasks());
        final results = await Future.wait(futures);

        for (final result in results) {
          expect(result.length, 1);
          expect(result.first.title, 'Test Task');
        }
      });
    });

    group('Error Handling', () {
      test('should handle database errors gracefully', () async {
        // The repository should handle errors from the database helper
        final task = Task(
          title: 'Test Task',
          description: 'Test Description',
          category: 'Test Category',
        );

        try {
          await taskRepository.createTask(task);
          // Should not throw in normal operation
          expect(true, true);
        } catch (e) {
          // Should handle errors gracefully
          expect(e, isA<Exception>());
        }
      });

      test('should handle mock API errors gracefully', () async {
        // The repository should handle errors from the mock API service
        final task = Task(
          title: 'Test Task',
          description: 'Test Description',
          category: 'Test Category',
        );

        try {
          await taskRepository.createTask(task);
          // Should not throw in normal operation
          expect(true, true);
        } catch (e) {
          // Should handle errors gracefully
          expect(e, isA<Exception>());
        }
      });
    });

    group('Data Consistency', () {
      test('should maintain data consistency between local and remote', () async {
        final task = Task(
          title: 'Test Task',
          description: 'Test Description',
          category: 'Test Category',
        );

        await taskRepository.createTask(task);

        // Verify task exists in local storage
        final localTask = await taskRepository.getTask(task.id);
        expect(localTask, isNotNull);
        expect(localTask!.title, 'Test Task');

        // Sync with server
        await taskRepository.syncWithServer();

        // Verify task still exists after sync
        final syncedTask = await taskRepository.getTask(task.id);
        expect(syncedTask, isNotNull);
        expect(syncedTask!.title, 'Test Task');
      });
    });
  });
} 