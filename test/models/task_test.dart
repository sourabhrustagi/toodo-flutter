import 'package:flutter_test/flutter_test.dart';
import 'package:toodoflutter/models/task.dart';

void main() {
  group('Task Model Tests', () {
    test('should create a task with default values', () {
      final task = Task(
        title: 'Test Task',
        description: 'Test Description',
        category: 'Test Category',
      );

      expect(task.id, isNotEmpty);
      expect(task.title, 'Test Task');
      expect(task.description, 'Test Description');
      expect(task.isCompleted, false);
      expect(task.priority, TaskPriority.medium);
      expect(task.dueDate, null);
      expect(task.category, 'Test Category');
      expect(task.createdAt, isA<DateTime>());
      expect(task.updatedAt, isA<DateTime>());
    });

    test('should create a task with custom values', () {
      final now = DateTime.now();
      final dueDate = DateTime.now().add(const Duration(days: 1));
      
      final task = Task(
        id: 'test-id',
        title: 'Custom Task',
        description: 'Custom Description',
        isCompleted: true,
        priority: TaskPriority.high,
        dueDate: dueDate,
        category: 'Custom Category',
        createdAt: now,
        updatedAt: now,
      );

      expect(task.id, 'test-id');
      expect(task.title, 'Custom Task');
      expect(task.description, 'Custom Description');
      expect(task.isCompleted, true);
      expect(task.priority, TaskPriority.high);
      expect(task.dueDate, dueDate);
      expect(task.category, 'Custom Category');
      expect(task.createdAt, now);
      expect(task.updatedAt, now);
    });

    test('should convert task to map', () {
      final dueDate = DateTime.now().add(const Duration(days: 1));
      final task = Task(
        id: 'test-id',
        title: 'Test Task',
        description: 'Test Description',
        isCompleted: true,
        priority: TaskPriority.high,
        dueDate: dueDate,
        category: 'Test Category',
        createdAt: DateTime(2023, 1, 1),
        updatedAt: DateTime(2023, 1, 2),
      );

      final map = task.toMap();

      expect(map['id'], 'test-id');
      expect(map['title'], 'Test Task');
      expect(map['description'], 'Test Description');
      expect(map['isCompleted'], 1);
      expect(map['priority'], TaskPriority.high.index);
      expect(map['dueDate'], dueDate.millisecondsSinceEpoch);
      expect(map['category'], 'Test Category');
      expect(map['createdAt'], DateTime(2023, 1, 1).millisecondsSinceEpoch);
      expect(map['updatedAt'], DateTime(2023, 1, 2).millisecondsSinceEpoch);
    });

    test('should create task from map', () {
      final dueDate = DateTime(2023, 12, 25, 10, 30, 0);
      final map = {
        'id': 'test-id',
        'title': 'Test Task',
        'description': 'Test Description',
        'isCompleted': 1,
        'priority': TaskPriority.high.index,
        'dueDate': dueDate.millisecondsSinceEpoch,
        'category': 'Test Category',
        'createdAt': DateTime(2023, 1, 1).millisecondsSinceEpoch,
        'updatedAt': DateTime(2023, 1, 2).millisecondsSinceEpoch,
      };

      final task = Task.fromMap(map);

      expect(task.id, 'test-id');
      expect(task.title, 'Test Task');
      expect(task.description, 'Test Description');
      expect(task.isCompleted, true);
      expect(task.priority, TaskPriority.high);
      expect(task.dueDate, dueDate);
      expect(task.category, 'Test Category');
      expect(task.createdAt, DateTime(2023, 1, 1));
      expect(task.updatedAt, DateTime(2023, 1, 2));
    });

    test('should create task from map with null due date', () {
      final map = {
        'id': 'test-id',
        'title': 'Test Task',
        'description': 'Test Description',
        'isCompleted': 0,
        'priority': TaskPriority.medium.index,
        'dueDate': null,
        'category': 'Test Category',
        'createdAt': DateTime(2023, 1, 1).millisecondsSinceEpoch,
        'updatedAt': DateTime(2023, 1, 2).millisecondsSinceEpoch,
      };

      final task = Task.fromMap(map);

      expect(task.id, 'test-id');
      expect(task.title, 'Test Task');
      expect(task.description, 'Test Description');
      expect(task.isCompleted, false);
      expect(task.priority, TaskPriority.medium);
      expect(task.dueDate, null);
      expect(task.category, 'Test Category');
    });

    test('should copy task with new values', () {
      final originalTask = Task(
        id: 'original-id',
        title: 'Original Task',
        description: 'Original Description',
        isCompleted: false,
        priority: TaskPriority.medium,
        category: 'Original Category',
      );

      final copiedTask = originalTask.copyWith(
        title: 'Updated Task',
        isCompleted: true,
        priority: TaskPriority.high,
      );

      expect(copiedTask.id, 'original-id');
      expect(copiedTask.title, 'Updated Task');
      expect(copiedTask.description, 'Original Description');
      expect(copiedTask.isCompleted, true);
      expect(copiedTask.priority, TaskPriority.high);
      expect(copiedTask.category, 'Original Category');
      expect(copiedTask.createdAt, originalTask.createdAt);
      expect(copiedTask.updatedAt, isNot(originalTask.updatedAt));
    });

    test('should copy task with partial values', () {
      final originalTask = Task(
        id: 'original-id',
        title: 'Original Task',
        description: 'Original Description',
        isCompleted: false,
        priority: TaskPriority.medium,
        category: 'Original Category',
      );

      final copiedTask = originalTask.copyWith(title: 'Updated Task');

      expect(copiedTask.id, 'original-id');
      expect(copiedTask.title, 'Updated Task');
      expect(copiedTask.description, 'Original Description');
      expect(copiedTask.isCompleted, false);
      expect(copiedTask.priority, TaskPriority.medium);
      expect(copiedTask.category, 'Original Category');
    });

    test('should generate unique IDs for different tasks', () {
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

      expect(task1.id, isNotEmpty);
      expect(task2.id, isNotEmpty);
      expect(task1.id, isNot(task2.id));
    });

    test('should have correct string representation', () {
      final task = Task(
        id: 'test-id',
        title: 'Test Task',
        description: 'Test Description',
        isCompleted: true,
        priority: TaskPriority.high,
        category: 'Test Category',
      );

      final string = task.toString();
      expect(string, contains('test-id'));
      expect(string, contains('Test Task'));
      expect(string, contains('true'));
      expect(string, contains('high'));
      expect(string, contains('Test Category'));
    });

    test('should have correct equality', () {
      final task1 = Task(
        id: 'same-id',
        title: 'Task 1',
        description: 'Description 1',
        category: 'Category 1',
      );

      final task2 = Task(
        id: 'same-id',
        title: 'Task 2',
        description: 'Description 2',
        category: 'Category 2',
      );

      final task3 = Task(
        id: 'different-id',
        title: 'Task 1',
        description: 'Description 1',
        category: 'Category 1',
      );

      expect(task1, equals(task2));
      expect(task1, isNot(equals(task3)));
    });

    test('should have correct hashCode', () {
      final task1 = Task(
        id: 'same-id',
        title: 'Task 1',
        description: 'Description 1',
        category: 'Category 1',
      );

      final task2 = Task(
        id: 'same-id',
        title: 'Task 2',
        description: 'Description 2',
        category: 'Category 2',
      );

      final task3 = Task(
        id: 'different-id',
        title: 'Task 1',
        description: 'Description 1',
        category: 'Category 1',
      );

      expect(task1.hashCode, equals(task2.hashCode));
      expect(task1.hashCode, isNot(equals(task3.hashCode)));
    });

    test('should handle all priority values', () {
      for (final priority in TaskPriority.values) {
        final task = Task(
          title: 'Test Task',
          description: 'Test Description',
          priority: priority,
          category: 'Test Category',
        );

        expect(task.priority, priority);
        expect(task.toMap()['priority'], priority.index);
      }
    });

    test('should handle boolean conversion in toMap', () {
      final completedTask = Task(
        title: 'Completed Task',
        description: 'Description',
        isCompleted: true,
        category: 'Category',
      );

      final pendingTask = Task(
        title: 'Pending Task',
        description: 'Description',
        isCompleted: false,
        category: 'Category',
      );

      expect(completedTask.toMap()['isCompleted'], 1);
      expect(pendingTask.toMap()['isCompleted'], 0);
    });

    test('should handle boolean conversion in fromMap', () {
      final completedMap = {
        'id': 'test-id',
        'title': 'Test Task',
        'description': 'Test Description',
        'isCompleted': 1,
        'priority': TaskPriority.medium.index,
        'category': 'Test Category',
        'createdAt': DateTime.now().millisecondsSinceEpoch,
        'updatedAt': DateTime.now().millisecondsSinceEpoch,
      };

      final pendingMap = {
        'id': 'test-id',
        'title': 'Test Task',
        'description': 'Test Description',
        'isCompleted': 0,
        'priority': TaskPriority.medium.index,
        'category': 'Test Category',
        'createdAt': DateTime.now().millisecondsSinceEpoch,
        'updatedAt': DateTime.now().millisecondsSinceEpoch,
      };

      final completedTask = Task.fromMap(completedMap);
      final pendingTask = Task.fromMap(pendingMap);

      expect(completedTask.isCompleted, true);
      expect(pendingTask.isCompleted, false);
    });
  });
} 