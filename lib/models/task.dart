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

extension TaskX on Task {
  /// Helper methods for task status
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

  bool get isDueThisWeek {
    if (dueDate == null) return false;
    final now = DateTime.now();
    final weekFromNow = now.add(const Duration(days: 7));
    return dueDate!.isBefore(weekFromNow) && !isCompleted;
  }

  /// Priority color mapping
  static Map<TaskPriority, int> get priorityColors => {
    TaskPriority.low: 0xFF4CAF50, // Green
    TaskPriority.medium: 0xFFFF9800, // Orange
    TaskPriority.high: 0xFFF44336, // Red
  };

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
} 