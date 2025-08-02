import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/task.dart';
import '../../repositories/task_repository.dart';

// Events
abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class TaskInitialized extends TaskEvent {}

class TaskAdded extends TaskEvent {
  final String title;
  final String description;
  final TaskPriority priority;
  final DateTime? dueDate;
  final String category;

  const TaskAdded({
    required this.title,
    required this.description,
    this.priority = TaskPriority.medium,
    this.dueDate,
    this.category = 'General',
  });

  @override
  List<Object?> get props => [title, description, priority, dueDate, category];
}

class TaskUpdated extends TaskEvent {
  final Task task;

  const TaskUpdated(this.task);

  @override
  List<Object?> get props => [task];
}

class TaskDeleted extends TaskEvent {
  final String taskId;

  const TaskDeleted(this.taskId);

  @override
  List<Object?> get props => [taskId];
}

class TaskToggled extends TaskEvent {
  final String taskId;

  const TaskToggled(this.taskId);

  @override
  List<Object?> get props => [taskId];
}

class TaskSearched extends TaskEvent {
  final String query;

  const TaskSearched(this.query);

  @override
  List<Object?> get props => [query];
}

class TaskFilterChanged extends TaskEvent {
  final TaskFilter filter;

  const TaskFilterChanged(this.filter);

  @override
  List<Object?> get props => [filter];
}

class TaskSortChanged extends TaskEvent {
  final TaskSortOption sortOption;

  const TaskSortChanged(this.sortOption);

  @override
  List<Object?> get props => [sortOption];
}

class TaskPriorityFilterChanged extends TaskEvent {
  final TaskPriority? priority;

  const TaskPriorityFilterChanged(this.priority);

  @override
  List<Object?> get props => [priority];
}

class TaskCategoryFilterChanged extends TaskEvent {
  final String? category;

  const TaskCategoryFilterChanged(this.category);

  @override
  List<Object?> get props => [category];
}

class TaskDueDateFilterChanged extends TaskEvent {
  final DateTime? dueDateFilter;

  const TaskDueDateFilterChanged(this.dueDateFilter);

  @override
  List<Object?> get props => [dueDateFilter];
}

class TaskBulkToggle extends TaskEvent {
  final List<String> taskIds;
  final bool isCompleted;

  const TaskBulkToggle({
    required this.taskIds,
    required this.isCompleted,
  });

  @override
  List<Object?> get props => [taskIds, isCompleted];
}

class TaskBulkDelete extends TaskEvent {
  final List<String> taskIds;

  const TaskBulkDelete(this.taskIds);

  @override
  List<Object?> get props => [taskIds];
}

class TaskBulkUpdatePriority extends TaskEvent {
  final List<String> taskIds;
  final TaskPriority priority;

  const TaskBulkUpdatePriority({
    required this.taskIds,
    required this.priority,
  });

  @override
  List<Object?> get props => [taskIds, priority];
}

class TaskBulkUpdateCategory extends TaskEvent {
  final List<String> taskIds;
  final String category;

  const TaskBulkUpdateCategory({
    required this.taskIds,
    required this.category,
  });

  @override
  List<Object?> get props => [taskIds, category];
}

class TaskRefresh extends TaskEvent {}

// States
abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;
  final List<Task> filteredTasks;
  final TaskFilter currentFilter;
  final TaskSortOption currentSort;
  final TaskPriority? selectedPriority;
  final String? selectedCategory;
  final DateTime? selectedDueDateFilter;
  final String searchQuery;
  final List<String> categories;
  final Map<String, int> statistics;

  const TaskLoaded({
    required this.tasks,
    required this.filteredTasks,
    this.currentFilter = TaskFilter.all,
    this.currentSort = TaskSortOption.creationDate,
    this.selectedPriority,
    this.selectedCategory,
    this.selectedDueDateFilter,
    this.searchQuery = '',
    this.categories = const [],
    this.statistics = const {},
  });

  @override
  List<Object?> get props => [
    tasks,
    filteredTasks,
    currentFilter,
    currentSort,
    selectedPriority,
    selectedCategory,
    selectedDueDateFilter,
    searchQuery,
    categories,
    statistics,
  ];

  TaskLoaded copyWith({
    List<Task>? tasks,
    List<Task>? filteredTasks,
    TaskFilter? currentFilter,
    TaskSortOption? currentSort,
    TaskPriority? selectedPriority,
    String? selectedCategory,
    DateTime? selectedDueDateFilter,
    String? searchQuery,
    List<String>? categories,
    Map<String, int>? statistics,
  }) {
    return TaskLoaded(
      tasks: tasks ?? this.tasks,
      filteredTasks: filteredTasks ?? this.filteredTasks,
      currentFilter: currentFilter ?? this.currentFilter,
      currentSort: currentSort ?? this.currentSort,
      selectedPriority: selectedPriority ?? this.selectedPriority,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedDueDateFilter: selectedDueDateFilter ?? this.selectedDueDateFilter,
      searchQuery: searchQuery ?? this.searchQuery,
      categories: categories ?? this.categories,
      statistics: statistics ?? this.statistics,
    );
  }
}

class TaskError extends TaskState {
  final String message;

  const TaskError(this.message);

  @override
  List<Object?> get props => [message];
}

enum TaskFilter { all, active, completed }

// BLoC
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository _taskRepository;

  TaskBloc({required TaskRepository taskRepository})
      : _taskRepository = taskRepository,
        super(TaskInitial()) {
    on<TaskInitialized>(_onTaskInitialized);
    on<TaskAdded>(_onTaskAdded);
    on<TaskUpdated>(_onTaskUpdated);
    on<TaskDeleted>(_onTaskDeleted);
    on<TaskToggled>(_onTaskToggled);
    on<TaskSearched>(_onTaskSearched);
    on<TaskFilterChanged>(_onTaskFilterChanged);
    on<TaskSortChanged>(_onTaskSortChanged);
    on<TaskPriorityFilterChanged>(_onTaskPriorityFilterChanged);
    on<TaskCategoryFilterChanged>(_onTaskCategoryFilterChanged);
    on<TaskDueDateFilterChanged>(_onTaskDueDateFilterChanged);
    on<TaskBulkToggle>(_onTaskBulkToggle);
    on<TaskBulkDelete>(_onTaskBulkDelete);
    on<TaskBulkUpdatePriority>(_onTaskBulkUpdatePriority);
    on<TaskBulkUpdateCategory>(_onTaskBulkUpdateCategory);
    on<TaskRefresh>(_onTaskRefresh);
  }

  Future<void> _onTaskInitialized(
    TaskInitialized event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskLoading());
    
    try {
      final tasks = await _taskRepository.getAllTasks();
      final categories = await _taskRepository.getAllCategories();
      final statistics = await _taskRepository.getTaskStatistics();
      
      emit(TaskLoaded(
        tasks: tasks,
        filteredTasks: tasks,
        categories: categories,
        statistics: statistics,
      ));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onTaskAdded(
    TaskAdded event,
    Emitter<TaskState> emit,
  ) async {
    try {
      final task = Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: event.title,
        description: event.description,
        isCompleted: false,
        priority: event.priority,
        dueDate: event.dueDate,
        category: event.category,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _taskRepository.createTask(task);
      
      if (state is TaskLoaded) {
        final currentState = state as TaskLoaded;
        final updatedTasks = [...currentState.tasks, task];
        final filteredTasks = await _applyFiltersAndSort(updatedTasks, currentState);
        final statistics = await _taskRepository.getTaskStatistics();
        
        emit(currentState.copyWith(
          tasks: updatedTasks,
          filteredTasks: filteredTasks,
          statistics: statistics,
        ));
      }
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onTaskUpdated(
    TaskUpdated event,
    Emitter<TaskState> emit,
  ) async {
    try {
      await _taskRepository.updateTask(event.task);
      
      if (state is TaskLoaded) {
        final currentState = state as TaskLoaded;
        final updatedTasks = currentState.tasks.map((task) {
          return task.id == event.task.id ? event.task : task;
        }).toList();
        
        final filteredTasks = await _applyFiltersAndSort(updatedTasks, currentState);
        final statistics = await _taskRepository.getTaskStatistics();
        
        emit(currentState.copyWith(
          tasks: updatedTasks,
          filteredTasks: filteredTasks,
          statistics: statistics,
        ));
      }
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onTaskDeleted(
    TaskDeleted event,
    Emitter<TaskState> emit,
  ) async {
    try {
      await _taskRepository.deleteTask(event.taskId);
      
      if (state is TaskLoaded) {
        final currentState = state as TaskLoaded;
        final updatedTasks = currentState.tasks.where((task) => task.id != event.taskId).toList();
        final filteredTasks = await _applyFiltersAndSort(updatedTasks, currentState);
        final statistics = await _taskRepository.getTaskStatistics();
        
        emit(currentState.copyWith(
          tasks: updatedTasks,
          filteredTasks: filteredTasks,
          statistics: statistics,
        ));
      }
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onTaskToggled(
    TaskToggled event,
    Emitter<TaskState> emit,
  ) async {
    try {
      if (state is TaskLoaded) {
        final currentState = state as TaskLoaded;
        final task = currentState.tasks.firstWhere((task) => task.id == event.taskId);
        final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
        
        await _taskRepository.updateTask(updatedTask);
        
        final updatedTasks = currentState.tasks.map((t) {
          return t.id == event.taskId ? updatedTask : t;
        }).toList();
        
        final filteredTasks = await _applyFiltersAndSort(updatedTasks, currentState);
        final statistics = await _taskRepository.getTaskStatistics();
        
        emit(currentState.copyWith(
          tasks: updatedTasks,
          filteredTasks: filteredTasks,
          statistics: statistics,
        ));
      }
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onTaskSearched(
    TaskSearched event,
    Emitter<TaskState> emit,
  ) async {
    if (state is TaskLoaded) {
      final currentState = state as TaskLoaded;
      final filteredTasks = await _applyFiltersAndSort(currentState.tasks, currentState.copyWith(searchQuery: event.query));
      
      emit(currentState.copyWith(
        filteredTasks: filteredTasks,
        searchQuery: event.query,
      ));
    }
  }

  Future<void> _onTaskFilterChanged(
    TaskFilterChanged event,
    Emitter<TaskState> emit,
  ) async {
    if (state is TaskLoaded) {
      final currentState = state as TaskLoaded;
      final filteredTasks = await _applyFiltersAndSort(currentState.tasks, currentState.copyWith(currentFilter: event.filter));
      
      emit(currentState.copyWith(
        filteredTasks: filteredTasks,
        currentFilter: event.filter,
      ));
    }
  }

  Future<void> _onTaskSortChanged(
    TaskSortChanged event,
    Emitter<TaskState> emit,
  ) async {
    if (state is TaskLoaded) {
      final currentState = state as TaskLoaded;
      final filteredTasks = await _applyFiltersAndSort(currentState.tasks, currentState.copyWith(currentSort: event.sortOption));
      
      emit(currentState.copyWith(
        filteredTasks: filteredTasks,
        currentSort: event.sortOption,
      ));
    }
  }

  Future<void> _onTaskPriorityFilterChanged(
    TaskPriorityFilterChanged event,
    Emitter<TaskState> emit,
  ) async {
    if (state is TaskLoaded) {
      final currentState = state as TaskLoaded;
      final filteredTasks = await _applyFiltersAndSort(currentState.tasks, currentState.copyWith(selectedPriority: event.priority));
      
      emit(currentState.copyWith(
        filteredTasks: filteredTasks,
        selectedPriority: event.priority,
      ));
    }
  }

  Future<void> _onTaskCategoryFilterChanged(
    TaskCategoryFilterChanged event,
    Emitter<TaskState> emit,
  ) async {
    if (state is TaskLoaded) {
      final currentState = state as TaskLoaded;
      final filteredTasks = await _applyFiltersAndSort(currentState.tasks, currentState.copyWith(selectedCategory: event.category));
      
      emit(currentState.copyWith(
        filteredTasks: filteredTasks,
        selectedCategory: event.category,
      ));
    }
  }

  Future<void> _onTaskDueDateFilterChanged(
    TaskDueDateFilterChanged event,
    Emitter<TaskState> emit,
  ) async {
    if (state is TaskLoaded) {
      final currentState = state as TaskLoaded;
      final filteredTasks = await _applyFiltersAndSort(currentState.tasks, currentState.copyWith(selectedDueDateFilter: event.dueDateFilter));
      
      emit(currentState.copyWith(
        filteredTasks: filteredTasks,
        selectedDueDateFilter: event.dueDateFilter,
      ));
    }
  }

  Future<void> _onTaskBulkToggle(
    TaskBulkToggle event,
    Emitter<TaskState> emit,
  ) async {
    try {
      await _taskRepository.toggleMultipleTasks(event.taskIds, event.isCompleted);
      
      if (state is TaskLoaded) {
        final currentState = state as TaskLoaded;
        final updatedTasks = currentState.tasks.map((task) {
          if (event.taskIds.contains(task.id)) {
            return task.copyWith(isCompleted: event.isCompleted);
          }
          return task;
        }).toList();
        
        final filteredTasks = await _applyFiltersAndSort(updatedTasks, currentState);
        final statistics = await _taskRepository.getTaskStatistics();
        
        emit(currentState.copyWith(
          tasks: updatedTasks,
          filteredTasks: filteredTasks,
          statistics: statistics,
        ));
      }
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onTaskBulkDelete(
    TaskBulkDelete event,
    Emitter<TaskState> emit,
  ) async {
    try {
      await _taskRepository.deleteMultipleTasks(event.taskIds);
      
      if (state is TaskLoaded) {
        final currentState = state as TaskLoaded;
        final updatedTasks = currentState.tasks.where((task) => !event.taskIds.contains(task.id)).toList();
        final filteredTasks = await _applyFiltersAndSort(updatedTasks, currentState);
        final statistics = await _taskRepository.getTaskStatistics();
        
        emit(currentState.copyWith(
          tasks: updatedTasks,
          filteredTasks: filteredTasks,
          statistics: statistics,
        ));
      }
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onTaskBulkUpdatePriority(
    TaskBulkUpdatePriority event,
    Emitter<TaskState> emit,
  ) async {
    try {
      await _taskRepository.updateMultipleTaskPriorities(event.taskIds, event.priority);
      
      if (state is TaskLoaded) {
        final currentState = state as TaskLoaded;
        final updatedTasks = currentState.tasks.map((task) {
          if (event.taskIds.contains(task.id)) {
            return task.copyWith(priority: event.priority);
          }
          return task;
        }).toList();
        
        final filteredTasks = await _applyFiltersAndSort(updatedTasks, currentState);
        
        emit(currentState.copyWith(
          tasks: updatedTasks,
          filteredTasks: filteredTasks,
        ));
      }
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onTaskBulkUpdateCategory(
    TaskBulkUpdateCategory event,
    Emitter<TaskState> emit,
  ) async {
    try {
      await _taskRepository.updateMultipleTaskCategories(event.taskIds, event.category);
      
      if (state is TaskLoaded) {
        final currentState = state as TaskLoaded;
        final updatedTasks = currentState.tasks.map((task) {
          if (event.taskIds.contains(task.id)) {
            return task.copyWith(category: event.category);
          }
          return task;
        }).toList();
        
        final filteredTasks = await _applyFiltersAndSort(updatedTasks, currentState);
        
        emit(currentState.copyWith(
          tasks: updatedTasks,
          filteredTasks: filteredTasks,
        ));
      }
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onTaskRefresh(
    TaskRefresh event,
    Emitter<TaskState> emit,
  ) async {
    try {
      final tasks = await _taskRepository.getAllTasks();
      final categories = await _taskRepository.getAllCategories();
      final statistics = await _taskRepository.getTaskStatistics();
      
      if (state is TaskLoaded) {
        final currentState = state as TaskLoaded;
        final filteredTasks = await _applyFiltersAndSort(tasks, currentState);
        
        emit(currentState.copyWith(
          tasks: tasks,
          filteredTasks: filteredTasks,
          categories: categories,
          statistics: statistics,
        ));
      }
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<List<Task>> _applyFiltersAndSort(List<Task> tasks, TaskLoaded state) async {
    var filteredTasks = tasks;

    // Apply search filter
    if (state.searchQuery.isNotEmpty) {
      filteredTasks = filteredTasks.where((task) {
        return task.title.toLowerCase().contains(state.searchQuery.toLowerCase()) ||
               task.description.toLowerCase().contains(state.searchQuery.toLowerCase());
      }).toList();
    }

    // Apply status filter
    switch (state.currentFilter) {
      case TaskFilter.active:
        filteredTasks = filteredTasks.where((task) => !task.isCompleted).toList();
        break;
      case TaskFilter.completed:
        filteredTasks = filteredTasks.where((task) => task.isCompleted).toList();
        break;
      case TaskFilter.all:
        break;
    }

    // Apply priority filter
    if (state.selectedPriority != null) {
      filteredTasks = filteredTasks.where((task) => task.priority == state.selectedPriority).toList();
    }

    // Apply category filter
    if (state.selectedCategory != null) {
      filteredTasks = filteredTasks.where((task) => task.category == state.selectedCategory).toList();
    }

    // Apply due date filter
    if (state.selectedDueDateFilter != null) {
      if (state.selectedDueDateFilter!.day == 0) { // Today
        filteredTasks = filteredTasks.where((task) => task.isDueToday).toList();
      } else if (state.selectedDueDateFilter!.day == 7) { // This week
        filteredTasks = filteredTasks.where((task) => task.isDueThisWeek).toList();
      } else if (state.selectedDueDateFilter!.day == -1) { // Overdue
        filteredTasks = filteredTasks.where((task) => task.isOverdue).toList();
      }
    }

    // Apply sorting
    return await _taskRepository.getSortedTasks(filteredTasks, state.currentSort);
  }
} 