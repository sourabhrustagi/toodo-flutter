# Freezed Usage Guide

This document explains how to use Freezed in this Flutter project for better code generation, immutability, and type safety.

## Table of Contents

1. [What is Freezed?](#what-is-freezed)
2. [Benefits of Using Freezed](#benefits-of-using-freezed)
3. [Setup and Dependencies](#setup-and-dependencies)
4. [Model Classes](#model-classes)
5. [BLoC Events and States](#bloc-events-and-states)
6. [JSON Serialization](#json-serialization)
7. [Best Practices](#best-practices)
8. [Code Generation](#code-generation)
9. [Examples](#examples)

## What is Freezed?

Freezed is a code generation package for Dart that helps you write immutable classes with minimal boilerplate. It's particularly useful for:

- **Data classes**: Models, DTOs, and value objects
- **Union types**: Sealed classes for different states or events
- **Immutable objects**: Objects that can't be modified after creation
- **JSON serialization**: Automatic JSON encoding/decoding

## Benefits of Using Freezed

1. **Less Boilerplate**: Automatic generation of `copyWith`, `toString`, `==`, and `hashCode`
2. **Type Safety**: Compile-time safety with union types
3. **Immutability**: Prevents accidental modifications
4. **JSON Support**: Built-in JSON serialization
5. **Pattern Matching**: Easy handling of different cases
6. **IDE Support**: Better autocomplete and refactoring

## Setup and Dependencies

### pubspec.yaml
```yaml
dependencies:
  freezed_annotation: ^2.4.4
  json_annotation: ^4.9.0

dev_dependencies:
  build_runner: ^2.4.8
  freezed: ^2.5.7
  json_serializable: ^6.8.0
```

### Build Runner
Run the following command to generate code:
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

## Model Classes

### Basic Model
```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
class Task with _$Task {
  const factory Task({
    required String id,
    required String title,
    required String description,
    @Default(false) bool isCompleted,
    @Default(TaskPriority.medium) TaskPriority priority,
    DateTime? dueDate,
    @Default('General') String category,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
```

### Key Features:
- `@freezed`: Marks the class for code generation
- `with _$Task`: Mixin for generated code
- `const factory`: Factory constructor for the class
- `@Default()`: Provides default values
- `factory Task.fromJson()`: JSON deserialization

### Generated Methods:
- `copyWith()`: Create a copy with some fields changed
- `toString()`: Human-readable string representation
- `==` and `hashCode`: Value equality
- `toJson()`: JSON serialization (if using json_annotation)

## BLoC Events and States

### Events
```dart
@freezed
class TaskEvent with _$TaskEvent {
  const factory TaskEvent.initialized() = TaskInitialized;
  
  const factory TaskEvent.added({
    required String title,
    required String description,
    @Default(TaskPriority.medium) TaskPriority priority,
    DateTime? dueDate,
    @Default('General') String category,
  }) = TaskAdded;
  
  const factory TaskEvent.updated(Task task) = TaskUpdated;
  
  const factory TaskEvent.deleted(String taskId) = TaskDeleted;
  
  const factory TaskEvent.toggled(String taskId) = TaskToggled;
  
  const factory TaskEvent.searched(String query) = TaskSearched;
  
  const factory TaskEvent.refresh() = TaskRefresh;
}
```

### States
```dart
@freezed
class TaskState with _$TaskState {
  const factory TaskState.initial() = TaskInitial;
  
  const factory TaskState.loading() = TaskLoading;
  
  const factory TaskState.loaded({
    required List<Task> tasks,
    required List<Task> filteredTasks,
    @Default(TaskFilter.all) TaskFilter currentFilter,
    @Default(TaskSortOption.creationDate) TaskSortOption currentSort,
    TaskPriority? selectedPriority,
    String? selectedCategory,
    DateTime? selectedDueDateFilter,
    @Default('') String searchQuery,
    @Default([]) List<String> categories,
    @Default({}) Map<String, int> statistics,
  }) = TaskLoaded;
  
  const factory TaskState.error(String message) = TaskError;
}
```

### BLoC Implementation
```dart
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository _taskRepository;

  TaskBloc({required TaskRepository taskRepository})
      : _taskRepository = taskRepository,
        super(const TaskState.initial()) {
    on<TaskEvent>(_onEvent);
  }

  Future<void> _onEvent(TaskEvent event, Emitter<TaskState> emit) async {
    await event.when(
      initialized: () => _onTaskInitialized(emit),
      added: (title, description, priority, dueDate, category) => 
        _onTaskAdded(title, description, priority, dueDate, category, emit),
      updated: (task) => _onTaskUpdated(task, emit),
      deleted: (taskId) => _onTaskDeleted(taskId, emit),
      toggled: (taskId) => _onTaskToggled(taskId, emit),
      searched: (query) => _onTaskSearched(query, emit),
      refresh: () => _onTaskRefresh(emit),
    );
  }
}
```

## JSON Serialization

### Basic JSON
```dart
@freezed
class Task with _$Task {
  const factory Task({
    required String id,
    required String title,
    // ... other fields
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
```

### Custom JSON for Database
```dart
extension TaskX on Task {
  /// Convert to database JSON format
  Map<String, dynamic> toDatabaseJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0,
      'priority': priority.index,
      'dueDate': dueDate?.millisecondsSinceEpoch,
      'category': category,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  /// Create from database JSON format
  factory Task.fromDatabaseJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      isCompleted: json['isCompleted'] == 1,
      priority: TaskPriority.values[json['priority'] as int],
      dueDate: json['dueDate'] != null 
        ? DateTime.fromMillisecondsSinceEpoch(json['dueDate'] as int)
        : null,
      category: json['category'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(json['updatedAt'] as int),
    );
  }
}
```

## Best Practices

### 1. Use Extensions for Helper Methods
```dart
extension TaskX on Task {
  bool get isOverdue {
    if (dueDate == null || isCompleted) return false;
    return DateTime.now().isAfter(dueDate!);
  }

  bool get isDueToday {
    if (dueDate == null) return false;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dueDay = DateTime(dueDate!.year, dueDate!.month, dueDate!.day);
    return today.isAtSameMomentAs(dueDay);
  }

  static Map<TaskPriority, int> get priorityColors => {
    TaskPriority.low: 0xFF4CAF50,
    TaskPriority.medium: 0xFFFF9800,
    TaskPriority.high: 0xFFF44336,
  };
}
```

### 2. Pattern Matching in Widgets
```dart
BlocBuilder<TaskBloc, TaskState>(
  builder: (context, state) {
    return state.when(
      initial: () => const SizedBox.shrink(),
      loading: () => CircularProgressIndicator(),
      loaded: (tasks, filteredTasks, ...) => TaskList(tasks: filteredTasks),
      error: (message) => ErrorWidget(message: message),
    );
  },
)
```

### 3. Event Handling
```dart
// Using when() for pattern matching
await event.when(
  initialized: () => _onTaskInitialized(emit),
  added: (title, description, priority, dueDate, category) => 
    _onTaskAdded(title, description, priority, dueDate, category, emit),
  updated: (task) => _onTaskUpdated(task, emit),
  // ... other cases
);

// Using map() for different handling
event.map(
  initialized: (e) => _onTaskInitialized(emit),
  added: (e) => _onTaskAdded(e.title, e.description, e.priority, e.dueDate, e.category, emit),
  // ... other cases
);
```

### 4. Immutable Updates
```dart
// Instead of modifying objects, create new ones
final updatedTask = task.copyWith(
  isCompleted: !task.isCompleted,
  updatedAt: DateTime.now(),
);

// For lists, create new lists
final updatedTasks = currentState.tasks.map((t) {
  return t.id == taskId ? updatedTask : t;
}).toList();
```

## Code Generation

### Running Build Runner
```bash
# Generate all files
flutter packages pub run build_runner build --delete-conflicting-outputs

# Watch for changes (development)
flutter packages pub run build_runner watch

# Clean and rebuild
flutter packages pub run build_runner clean
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### Generated Files
- `*.freezed.dart`: Main generated code
- `*.g.dart`: JSON serialization code (if using json_annotation)

### Common Issues
1. **Missing part directive**: Always include `part 'file.freezed.dart';`
2. **Build runner not running**: Run `flutter packages pub run build_runner build`
3. **Import errors**: Make sure generated files are imported correctly

## Examples

### Complete Task Model
```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.freezed.dart';
part 'task.g.dart';

enum TaskPriority { low, medium, high }

@freezed
class Task with _$Task {
  const factory Task({
    required String id,
    required String title,
    required String description,
    @Default(false) bool isCompleted,
    @Default(TaskPriority.medium) TaskPriority priority,
    DateTime? dueDate,
    @Default('General') String category,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}

extension TaskX on Task {
  bool get isOverdue {
    if (dueDate == null || isCompleted) return false;
    return DateTime.now().isAfter(dueDate!);
  }

  bool get isDueToday {
    if (dueDate == null) return false;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dueDay = DateTime(dueDate!.year, dueDate!.month, dueDate!.day);
    return today.isAtSameMomentAs(dueDay);
  }

  static Map<TaskPriority, int> get priorityColors => {
    TaskPriority.low: 0xFF4CAF50,
    TaskPriority.medium: 0xFFFF9800,
    TaskPriority.high: 0xFFF44336,
  };
}
```

### Usage in Widgets
```dart
class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(task.description),
        trailing: Checkbox(
          value: task.isCompleted,
          onChanged: (value) {
            // Use copyWith to create new instance
            final updatedTask = task.copyWith(
              isCompleted: value ?? false,
              updatedAt: DateTime.now(),
            );
            // Update in BLoC
            context.read<TaskBloc>().add(TaskEvent.updated(updatedTask));
          },
        ),
      ),
    );
  }
}
```

## Migration from Equatable

### Before (with Equatable)
```dart
class Task extends Equatable {
  final String id;
  final String title;
  // ... other fields

  const Task({required this.id, required this.title, ...});

  Task copyWith({String? id, String? title, ...}) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      // ... other fields
    );
  }

  @override
  List<Object?> get props => [id, title, ...];
}
```

### After (with Freezed)
```dart
@freezed
class Task with _$Task {
  const factory Task({
    required String id,
    required String title,
    // ... other fields
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
```

## Performance Benefits

1. **Compile-time Safety**: Errors caught at compile time
2. **Reduced Runtime Errors**: Immutable objects prevent bugs
3. **Better Performance**: Generated code is optimized
4. **Memory Efficiency**: Immutable objects can be shared safely

## Conclusion

Freezed provides a powerful way to write immutable, type-safe code with minimal boilerplate. It's particularly useful for:

- **Data models**: Clean, immutable data classes
- **State management**: Union types for different states
- **Event handling**: Type-safe event processing
- **JSON serialization**: Automatic JSON handling

By following these patterns, you can write more maintainable, safer, and more efficient Flutter code. 