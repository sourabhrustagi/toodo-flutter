import 'package:flutter_test/flutter_test.dart';
import 'package:toodoflutter/data/database_helper.dart';
import 'package:toodoflutter/models/task.dart';

void main() {
  group('DatabaseHelper Tests', () {
    late DatabaseHelper databaseHelper;

    setUp(() {
      databaseHelper = DatabaseHelper();
    });

    group('Database Initialization', () {
      test('should initialize database successfully', () async {
        expect(database, isNotNull);
        expect(database.isOpen, true);
      });

      test('should create tasks table', () async {
        final tables = await database.query('sqlite_master', 
          where: 'type = ? AND name = ?', 
          whereArgs: ['table', 'tasks']);
        
        expect(tables.length, 1);
        expect(tables.first['name'], 'tasks');
      });

      test('should have correct table schema', () async {
        final result = await database.rawQuery('PRAGMA table_info(tasks)');
        
        final columns = result.map((row) => row['name'] as String).toList();
        
        expect(columns, contains('id'));
        expect(columns, contains('title'));
        expect(columns, contains('description'));
        expect(columns, contains('isCompleted'));
        expect(columns, contains('priority'));
        expect(columns, contains('dueDate'));
        expect(columns, contains('category'));
        expect(columns, contains('createdAt'));
        expect(columns, contains('updatedAt'));
      });
    });

    group('Task CRUD Operations', () {
      test('should insert task successfully', () async {
        final task = Task(
          title: 'Test Task',
          description: 'Test Description',
          category: 'Test Category',
        );

        final id = await databaseHelper.insertTask(task);
        expect(id, isNotNull);
        expect(id, isA<int>());
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

        await databaseHelper.insertTask(task1);
        await databaseHelper.insertTask(task2);

        final tasks = await databaseHelper.getAllTasks();
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

        final id = await databaseHelper.insertTask(task);
        final retrievedTask = await databaseHelper.getTask(id);

        expect(retrievedTask, isNotNull);
        expect(retrievedTask!.title, 'Test Task');
        expect(retrievedTask.description, 'Test Description');
        expect(retrievedTask.category, 'Test Category');
      });

      test('should return null for non-existent task', () async {
        final task = await databaseHelper.getTask(999);
        expect(task, null);
      });

      test('should update task successfully', () async {
        final task = Task(
          title: 'Original Task',
          description: 'Original Description',
          category: 'Original Category',
        );

        final id = await databaseHelper.insertTask(task);

        final updatedTask = task.copyWith(
          id: id.toString(),
          title: 'Updated Task',
          description: 'Updated Description',
          isCompleted: true,
        );

        final updateResult = await databaseHelper.updateTask(updatedTask);
        expect(updateResult, 1);

        final retrievedTask = await databaseHelper.getTask(id);
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

        final id = await databaseHelper.insertTask(task);
        expect(await databaseHelper.getAllTasks(), hasLength(1));

        final deleteResult = await databaseHelper.deleteTask(id);
        expect(deleteResult, 1);
        expect(await databaseHelper.getAllTasks(), hasLength(0));
      });

      test('should return 0 when deleting non-existent task', () async {
        final result = await databaseHelper.deleteTask(999);
        expect(result, 0);
      });
    });

    group('Task Queries', () {
      test('should get tasks by category', () async {
        final task1 = Task(
          title: 'Work Task 1',
          description: 'Description 1',
          category: 'Work',
        );
        final task2 = Task(
          title: 'Personal Task 1',
          description: 'Description 2',
          category: 'Personal',
        );
        final task3 = Task(
          title: 'Work Task 2',
          description: 'Description 3',
          category: 'Work',
        );

        await databaseHelper.insertTask(task1);
        await databaseHelper.insertTask(task2);
        await databaseHelper.insertTask(task3);

        final workTasks = await databaseHelper.getTasksByCategory('Work');
        expect(workTasks.length, 2);
        expect(workTasks.every((t) => t.category == 'Work'), true);

        final personalTasks = await databaseHelper.getTasksByCategory('Personal');
        expect(personalTasks.length, 1);
        expect(personalTasks.first.category, 'Personal');
      });

      test('should search tasks', () async {
        final task1 = Task(
          title: 'Important Task',
          description: 'Important description',
          category: 'Category 1',
        );
        final task2 = Task(
          title: 'Regular Task',
          description: 'Regular description',
          category: 'Category 2',
        );

        await databaseHelper.insertTask(task1);
        await databaseHelper.insertTask(task2);

        final importantTasks = await databaseHelper.searchTasks('Important');
        expect(importantTasks.length, 1);
        expect(importantTasks.first.title, 'Important Task');

        final descriptionTasks = await databaseHelper.searchTasks('description');
        expect(descriptionTasks.length, 2);
      });

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

        await databaseHelper.insertTask(task1);
        await databaseHelper.insertTask(task2);
        await databaseHelper.insertTask(task3);

        final categories = await databaseHelper.getAllCategories();
        expect(categories.length, 2);
        expect(categories, contains('Work'));
        expect(categories, contains('Personal'));
      });
    });

    group('Data Types and Conversions', () {
      test('should handle boolean conversion correctly', () async {
        final completedTask = Task(
          title: 'Completed Task',
          description: 'Description',
          category: 'Category',
          isCompleted: true,
        );
        final pendingTask = Task(
          title: 'Pending Task',
          description: 'Description',
          category: 'Category',
          isCompleted: false,
        );

        final completedId = await databaseHelper.insertTask(completedTask);
        final pendingId = await databaseHelper.insertTask(pendingTask);

        final retrievedCompleted = await databaseHelper.getTask(completedId);
        final retrievedPending = await databaseHelper.getTask(pendingId);

        expect(retrievedCompleted!.isCompleted, true);
        expect(retrievedPending!.isCompleted, false);
      });

      test('should handle priority enum correctly', () async {
        for (final priority in TaskPriority.values) {
          final task = Task(
            title: '${priority.name} Priority Task',
            description: 'Description',
            category: 'Category',
            priority: priority,
          );

          final id = await databaseHelper.insertTask(task);
          final retrievedTask = await databaseHelper.getTask(id);

          expect(retrievedTask!.priority, priority);
        }
      });

      test('should handle due date correctly', () async {
        final dueDate = DateTime(2023, 12, 25);
        final task = Task(
          title: 'Task with Due Date',
          description: 'Description',
          category: 'Category',
          dueDate: dueDate,
        );

        final id = await databaseHelper.insertTask(task);
        final retrievedTask = await databaseHelper.getTask(id);

        expect(retrievedTask!.dueDate, dueDate);
      });

      test('should handle null due date correctly', () async {
        final task = Task(
          title: 'Task without Due Date',
          description: 'Description',
          category: 'Category',
        );

        final id = await databaseHelper.insertTask(task);
        final retrievedTask = await databaseHelper.getTask(id);

        expect(retrievedTask!.dueDate, null);
      });
    });

    group('Edge Cases', () {
      test('should handle empty task list', () async {
        final tasks = await databaseHelper.getAllTasks();
        expect(tasks, isEmpty);
      });

      test('should handle very long text fields', () async {
        final longTitle = 'A' * 1000;
        final longDescription = 'B' * 2000;
        final longCategory = 'C' * 500;

        final task = Task(
          title: longTitle,
          description: longDescription,
          category: longCategory,
        );

        final id = await databaseHelper.insertTask(task);
        final retrievedTask = await databaseHelper.getTask(id);

        expect(retrievedTask!.title, longTitle);
        expect(retrievedTask.description, longDescription);
        expect(retrievedTask.category, longCategory);
      });

      test('should handle special characters in text', () async {
        final task = Task(
          title: 'Task with special chars: !@#\$%^&*()',
          description: 'Description with "quotes" and \'apostrophes\'',
          category: 'Category with spaces and symbols!',
        );

        final id = await databaseHelper.insertTask(task);
        final retrievedTask = await databaseHelper.getTask(id);

        expect(retrievedTask!.title, 'Task with special chars: !@#\$%^&*()');
        expect(retrievedTask.description, 'Description with "quotes" and \'apostrophes\'');
        expect(retrievedTask.category, 'Category with spaces and symbols!');
      });
    });

    group('Concurrent Operations', () {
      test('should handle concurrent insertions', () async {
        final tasks = List.generate(10, (index) => Task(
          title: 'Task $index',
          description: 'Description $index',
          category: 'Category $index',
        ));

        final futures = tasks.map((task) => databaseHelper.insertTask(task));
        final results = await Future.wait(futures);

        expect(results.length, 10);
        expect(results.every((id) => id is int), true);

        final allTasks = await databaseHelper.getAllTasks();
        expect(allTasks.length, 10);
      });

      test('should handle concurrent reads', () async {
        final task = Task(
          title: 'Test Task',
          description: 'Test Description',
          category: 'Test Category',
        );

        final id = await databaseHelper.insertTask(task);

        final futures = List.generate(10, (_) => databaseHelper.getTask(id));
        final results = await Future.wait(futures);

        expect(results.length, 10);
        expect(results.every((t) => t != null), true);
        expect(results.every((t) => t!.title == 'Test Task'), true);
      });
    });

    group('Error Handling', () {
      test('should handle database errors gracefully', () async {
        // Close the database to simulate an error
        await database.close();

        try {
          await databaseHelper.getAllTasks();
          fail('Should have thrown an exception');
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });
    });
  });
} 