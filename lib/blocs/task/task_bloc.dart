import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/task.dart';
import '../../repositories/task_repository.dart';

part 'task_bloc.freezed.dart';

// Events
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
  
  const factory TaskEvent.filterChanged(TaskFilter filter) = TaskFilterChanged;
  
  const factory TaskEvent.sortChanged(TaskSortOption sortOption) = TaskSortChanged;
  
  const factory TaskEvent.priorityFilterChanged(TaskPriority? priority) = TaskPriorityFilterChanged;
  
  const factory TaskEvent.categoryFilterChanged(String? category) = TaskCategoryFilterChanged;
  
  const factory TaskEvent.dueDateFilterChanged(DateTime? dueDateFilter) = TaskDueDateFilterChanged;
  
  const factory TaskEvent.bulkToggle({
    required List<String> taskIds,
    required bool isCompleted,
  }) = TaskBulkToggle;
  
  const factory TaskEvent.bulkDelete(List<String> taskIds) = TaskBulkDelete;
  
  const factory TaskEvent.bulkUpdatePriority({
    required List<String> taskIds,
    required TaskPriority priority,
  }) = TaskBulkUpdatePriority;
  
  const factory TaskEvent.bulkUpdateCategory({
    required List<String> taskIds,
    required String category,
  }) = TaskBulkUpdateCategory;
  
  const factory TaskEvent.refresh() = TaskRefresh;
}

// States
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

enum TaskFilter { all, active, completed }
enum TaskSortOption { creationDate, dueDate, priority, title }

// BLoC
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
      filterChanged: (filter) => _onTaskFilterChanged(filter, emit),
      sortChanged: (sortOption) => _onTaskSortChanged(sortOption, emit),
      priorityFilterChanged: (priority) => _onTaskPriorityFilterChanged(priority, emit),
      categoryFilterChanged: (category) => _onTaskCategoryFilterChanged(category, emit),
      dueDateFilterChanged: (dueDateFilter) => _onTaskDueDateFilterChanged(dueDateFilter, emit),
      bulkToggle: (taskIds, isCompleted) => _onTaskBulkToggle(taskIds, isCompleted, emit),
      bulkDelete: (taskIds) => _onTaskBulkDelete(taskIds, emit),
      bulkUpdatePriority: (taskIds, priority) => _onTaskBulkUpdatePriority(taskIds, priority, emit),
      bulkUpdateCategory: (taskIds, category) => _onTaskBulkUpdateCategory(taskIds, category, emit),
      refresh: () => _onTaskRefresh(emit),
    );
  }

  Future<void> _onTaskInitialized(Emitter<TaskState> emit) async {
    emit(const TaskState.loading());
    
    try {
      final tasks = await _taskRepository.getAllTasks();
      final categories = await _taskRepository.getAllCategories();
      final statistics = await _taskRepository.getTaskStatistics();
      
      emit(TaskState.loaded(
        tasks: tasks,
        filteredTasks: tasks,
        categories: categories,
        statistics: statistics,
      ));
    } catch (e) {
      emit(TaskState.error(e.toString()));
    }
  }

  Future<void> _onTaskAdded(
    String title,
    String description,
    TaskPriority priority,
    DateTime? dueDate,
    String category,
    Emitter<TaskState> emit,
  ) async {
    try {
      final task = Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        description: description,
        isCompleted: false,
        priority: priority,
        dueDate: dueDate,
        category: category,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _taskRepository.createTask(task);
      
      final currentState = state;
      if (currentState is TaskLoaded) {
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
      emit(TaskState.error(e.toString()));
    }
  }

  Future<void> _onTaskUpdated(Task task, Emitter<TaskState> emit) async {
    try {
      await _taskRepository.updateTask(task);
      
      final currentState = state;
      if (currentState is TaskLoaded) {
        final updatedTasks = currentState.tasks.map((t) {
          return t.id == task.id ? task : t;
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
      emit(TaskState.error(e.toString()));
    }
  }

  Future<void> _onTaskDeleted(String taskId, Emitter<TaskState> emit) async {
    try {
      await _taskRepository.deleteTask(taskId);
      
      final currentState = state;
      if (currentState is TaskLoaded) {
        final updatedTasks = currentState.tasks.where((task) => task.id != taskId).toList();
        final filteredTasks = await _applyFiltersAndSort(updatedTasks, currentState);
        final statistics = await _taskRepository.getTaskStatistics();
        
        emit(currentState.copyWith(
          tasks: updatedTasks,
          filteredTasks: filteredTasks,
          statistics: statistics,
        ));
      }
    } catch (e) {
      emit(TaskState.error(e.toString()));
    }
  }

  Future<void> _onTaskToggled(String taskId, Emitter<TaskState> emit) async {
    try {
      final currentState = state;
      if (currentState is TaskLoaded) {
        final task = currentState.tasks.firstWhere((task) => task.id == taskId);
        final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
        
        await _taskRepository.updateTask(updatedTask);
        
        final updatedTasks = currentState.tasks.map((t) {
          return t.id == taskId ? updatedTask : t;
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
      emit(TaskState.error(e.toString()));
    }
  }

  Future<void> _onTaskSearched(String query, Emitter<TaskState> emit) async {
    final currentState = state;
    if (currentState is TaskLoaded) {
      final filteredTasks = await _applyFiltersAndSort(
        currentState.tasks, 
        currentState.copyWith(searchQuery: query)
      );
      
      emit(currentState.copyWith(
        filteredTasks: filteredTasks,
        searchQuery: query,
      ));
    }
  }

  Future<void> _onTaskFilterChanged(TaskFilter filter, Emitter<TaskState> emit) async {
    final currentState = state;
    if (currentState is TaskLoaded) {
      final filteredTasks = await _applyFiltersAndSort(
        currentState.tasks, 
        currentState.copyWith(currentFilter: filter)
      );
      
      emit(currentState.copyWith(
        filteredTasks: filteredTasks,
        currentFilter: filter,
      ));
    }
  }

  Future<void> _onTaskSortChanged(TaskSortOption sortOption, Emitter<TaskState> emit) async {
    final currentState = state;
    if (currentState is TaskLoaded) {
      final filteredTasks = await _applyFiltersAndSort(
        currentState.tasks, 
        currentState.copyWith(currentSort: sortOption)
      );
      
      emit(currentState.copyWith(
        filteredTasks: filteredTasks,
        currentSort: sortOption,
      ));
    }
  }

  Future<void> _onTaskPriorityFilterChanged(TaskPriority? priority, Emitter<TaskState> emit) async {
    final currentState = state;
    if (currentState is TaskLoaded) {
      final filteredTasks = await _applyFiltersAndSort(
        currentState.tasks, 
        currentState.copyWith(selectedPriority: priority)
      );
      
      emit(currentState.copyWith(
        filteredTasks: filteredTasks,
        selectedPriority: priority,
      ));
    }
  }

  Future<void> _onTaskCategoryFilterChanged(String? category, Emitter<TaskState> emit) async {
    final currentState = state;
    if (currentState is TaskLoaded) {
      final filteredTasks = await _applyFiltersAndSort(
        currentState.tasks, 
        currentState.copyWith(selectedCategory: category)
      );
      
      emit(currentState.copyWith(
        filteredTasks: filteredTasks,
        selectedCategory: category,
      ));
    }
  }

  Future<void> _onTaskDueDateFilterChanged(DateTime? dueDateFilter, Emitter<TaskState> emit) async {
    final currentState = state;
    if (currentState is TaskLoaded) {
      final filteredTasks = await _applyFiltersAndSort(
        currentState.tasks, 
        currentState.copyWith(selectedDueDateFilter: dueDateFilter)
      );
      
      emit(currentState.copyWith(
        filteredTasks: filteredTasks,
        selectedDueDateFilter: dueDateFilter,
      ));
    }
  }

  Future<void> _onTaskBulkToggle(List<String> taskIds, bool isCompleted, Emitter<TaskState> emit) async {
    try {
      await _taskRepository.toggleMultipleTasks(taskIds);
      
      final currentState = state;
      if (currentState is TaskLoaded) {
        final updatedTasks = currentState.tasks.map((task) {
          if (taskIds.contains(task.id)) {
            return task.copyWith(isCompleted: isCompleted);
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
      emit(TaskState.error(e.toString()));
    }
  }

  Future<void> _onTaskBulkDelete(List<String> taskIds, Emitter<TaskState> emit) async {
    try {
      await _taskRepository.deleteMultipleTasks(taskIds);
      
      final currentState = state;
      if (currentState is TaskLoaded) {
        final updatedTasks = currentState.tasks.where((task) => !taskIds.contains(task.id)).toList();
        final filteredTasks = await _applyFiltersAndSort(updatedTasks, currentState);
        final statistics = await _taskRepository.getTaskStatistics();
        
        emit(currentState.copyWith(
          tasks: updatedTasks,
          filteredTasks: filteredTasks,
          statistics: statistics,
        ));
      }
    } catch (e) {
      emit(TaskState.error(e.toString()));
    }
  }

  Future<void> _onTaskBulkUpdatePriority(List<String> taskIds, TaskPriority priority, Emitter<TaskState> emit) async {
    try {
      await _taskRepository.updateMultipleTaskPriorities(taskIds, priority);
      
      final currentState = state;
      if (currentState is TaskLoaded) {
        final updatedTasks = currentState.tasks.map((task) {
          if (taskIds.contains(task.id)) {
            return task.copyWith(priority: priority);
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
      emit(TaskState.error(e.toString()));
    }
  }

  Future<void> _onTaskBulkUpdateCategory(List<String> taskIds, String category, Emitter<TaskState> emit) async {
    try {
      await _taskRepository.updateMultipleTaskCategories(taskIds, category);
      
      final currentState = state;
      if (currentState is TaskLoaded) {
        final updatedTasks = currentState.tasks.map((task) {
          if (taskIds.contains(task.id)) {
            return task.copyWith(category: category);
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
      emit(TaskState.error(e.toString()));
    }
  }

  Future<void> _onTaskRefresh(Emitter<TaskState> emit) async {
    try {
      final tasks = await _taskRepository.getAllTasks();
      final categories = await _taskRepository.getAllCategories();
      final statistics = await _taskRepository.getTaskStatistics();
      
      final currentState = state;
      if (currentState is TaskLoaded) {
        final filteredTasks = await _applyFiltersAndSort(tasks, currentState);
        
        emit(currentState.copyWith(
          tasks: tasks,
          filteredTasks: filteredTasks,
          categories: categories,
          statistics: statistics,
        ));
      }
    } catch (e) {
      emit(TaskState.error(e.toString()));
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