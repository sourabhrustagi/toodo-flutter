// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TaskEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialized,
    required TResult Function(String title, String description,
            TaskPriority priority, DateTime? dueDate, String category)
        added,
    required TResult Function(Task task) updated,
    required TResult Function(String taskId) deleted,
    required TResult Function(String taskId) toggled,
    required TResult Function(String query) searched,
    required TResult Function(TaskFilter filter) filterChanged,
    required TResult Function(TaskSortOption sortOption) sortChanged,
    required TResult Function(TaskPriority? priority) priorityFilterChanged,
    required TResult Function(String? category) categoryFilterChanged,
    required TResult Function(DateTime? dueDateFilter) dueDateFilterChanged,
    required TResult Function(List<String> taskIds, bool isCompleted)
        bulkToggle,
    required TResult Function(List<String> taskIds) bulkDelete,
    required TResult Function(List<String> taskIds, TaskPriority priority)
        bulkUpdatePriority,
    required TResult Function(List<String> taskIds, String category)
        bulkUpdateCategory,
    required TResult Function() refresh,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialized,
    TResult? Function(String title, String description, TaskPriority priority,
            DateTime? dueDate, String category)?
        added,
    TResult? Function(Task task)? updated,
    TResult? Function(String taskId)? deleted,
    TResult? Function(String taskId)? toggled,
    TResult? Function(String query)? searched,
    TResult? Function(TaskFilter filter)? filterChanged,
    TResult? Function(TaskSortOption sortOption)? sortChanged,
    TResult? Function(TaskPriority? priority)? priorityFilterChanged,
    TResult? Function(String? category)? categoryFilterChanged,
    TResult? Function(DateTime? dueDateFilter)? dueDateFilterChanged,
    TResult? Function(List<String> taskIds, bool isCompleted)? bulkToggle,
    TResult? Function(List<String> taskIds)? bulkDelete,
    TResult? Function(List<String> taskIds, TaskPriority priority)?
        bulkUpdatePriority,
    TResult? Function(List<String> taskIds, String category)?
        bulkUpdateCategory,
    TResult? Function()? refresh,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function(String title, String description, TaskPriority priority,
            DateTime? dueDate, String category)?
        added,
    TResult Function(Task task)? updated,
    TResult Function(String taskId)? deleted,
    TResult Function(String taskId)? toggled,
    TResult Function(String query)? searched,
    TResult Function(TaskFilter filter)? filterChanged,
    TResult Function(TaskSortOption sortOption)? sortChanged,
    TResult Function(TaskPriority? priority)? priorityFilterChanged,
    TResult Function(String? category)? categoryFilterChanged,
    TResult Function(DateTime? dueDateFilter)? dueDateFilterChanged,
    TResult Function(List<String> taskIds, bool isCompleted)? bulkToggle,
    TResult Function(List<String> taskIds)? bulkDelete,
    TResult Function(List<String> taskIds, TaskPriority priority)?
        bulkUpdatePriority,
    TResult Function(List<String> taskIds, String category)? bulkUpdateCategory,
    TResult Function()? refresh,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskInitialized value) initialized,
    required TResult Function(TaskAdded value) added,
    required TResult Function(TaskUpdated value) updated,
    required TResult Function(TaskDeleted value) deleted,
    required TResult Function(TaskToggled value) toggled,
    required TResult Function(TaskSearched value) searched,
    required TResult Function(TaskFilterChanged value) filterChanged,
    required TResult Function(TaskSortChanged value) sortChanged,
    required TResult Function(TaskPriorityFilterChanged value)
        priorityFilterChanged,
    required TResult Function(TaskCategoryFilterChanged value)
        categoryFilterChanged,
    required TResult Function(TaskDueDateFilterChanged value)
        dueDateFilterChanged,
    required TResult Function(TaskBulkToggle value) bulkToggle,
    required TResult Function(TaskBulkDelete value) bulkDelete,
    required TResult Function(TaskBulkUpdatePriority value) bulkUpdatePriority,
    required TResult Function(TaskBulkUpdateCategory value) bulkUpdateCategory,
    required TResult Function(TaskRefresh value) refresh,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaskInitialized value)? initialized,
    TResult? Function(TaskAdded value)? added,
    TResult? Function(TaskUpdated value)? updated,
    TResult? Function(TaskDeleted value)? deleted,
    TResult? Function(TaskToggled value)? toggled,
    TResult? Function(TaskSearched value)? searched,
    TResult? Function(TaskFilterChanged value)? filterChanged,
    TResult? Function(TaskSortChanged value)? sortChanged,
    TResult? Function(TaskPriorityFilterChanged value)? priorityFilterChanged,
    TResult? Function(TaskCategoryFilterChanged value)? categoryFilterChanged,
    TResult? Function(TaskDueDateFilterChanged value)? dueDateFilterChanged,
    TResult? Function(TaskBulkToggle value)? bulkToggle,
    TResult? Function(TaskBulkDelete value)? bulkDelete,
    TResult? Function(TaskBulkUpdatePriority value)? bulkUpdatePriority,
    TResult? Function(TaskBulkUpdateCategory value)? bulkUpdateCategory,
    TResult? Function(TaskRefresh value)? refresh,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskInitialized value)? initialized,
    TResult Function(TaskAdded value)? added,
    TResult Function(TaskUpdated value)? updated,
    TResult Function(TaskDeleted value)? deleted,
    TResult Function(TaskToggled value)? toggled,
    TResult Function(TaskSearched value)? searched,
    TResult Function(TaskFilterChanged value)? filterChanged,
    TResult Function(TaskSortChanged value)? sortChanged,
    TResult Function(TaskPriorityFilterChanged value)? priorityFilterChanged,
    TResult Function(TaskCategoryFilterChanged value)? categoryFilterChanged,
    TResult Function(TaskDueDateFilterChanged value)? dueDateFilterChanged,
    TResult Function(TaskBulkToggle value)? bulkToggle,
    TResult Function(TaskBulkDelete value)? bulkDelete,
    TResult Function(TaskBulkUpdatePriority value)? bulkUpdatePriority,
    TResult Function(TaskBulkUpdateCategory value)? bulkUpdateCategory,
    TResult Function(TaskRefresh value)? refresh,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskEventCopyWith<$Res> {
  factory $TaskEventCopyWith(TaskEvent value, $Res Function(TaskEvent) then) =
      _$TaskEventCopyWithImpl<$Res, TaskEvent>;
}

/// @nodoc
class _$TaskEventCopyWithImpl<$Res, $Val extends TaskEvent>
    implements $TaskEventCopyWith<$Res> {
  _$TaskEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$TaskInitializedImplCopyWith<$Res> {
  factory _$$TaskInitializedImplCopyWith(_$TaskInitializedImpl value,
          $Res Function(_$TaskInitializedImpl) then) =
      __$$TaskInitializedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TaskInitializedImplCopyWithImpl<$Res>
    extends _$TaskEventCopyWithImpl<$Res, _$TaskInitializedImpl>
    implements _$$TaskInitializedImplCopyWith<$Res> {
  __$$TaskInitializedImplCopyWithImpl(
      _$TaskInitializedImpl _value, $Res Function(_$TaskInitializedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TaskInitializedImpl implements TaskInitialized {
  const _$TaskInitializedImpl();

  @override
  String toString() {
    return 'TaskEvent.initialized()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TaskInitializedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialized,
    required TResult Function(String title, String description,
            TaskPriority priority, DateTime? dueDate, String category)
        added,
    required TResult Function(Task task) updated,
    required TResult Function(String taskId) deleted,
    required TResult Function(String taskId) toggled,
    required TResult Function(String query) searched,
    required TResult Function(TaskFilter filter) filterChanged,
    required TResult Function(TaskSortOption sortOption) sortChanged,
    required TResult Function(TaskPriority? priority) priorityFilterChanged,
    required TResult Function(String? category) categoryFilterChanged,
    required TResult Function(DateTime? dueDateFilter) dueDateFilterChanged,
    required TResult Function(List<String> taskIds, bool isCompleted)
        bulkToggle,
    required TResult Function(List<String> taskIds) bulkDelete,
    required TResult Function(List<String> taskIds, TaskPriority priority)
        bulkUpdatePriority,
    required TResult Function(List<String> taskIds, String category)
        bulkUpdateCategory,
    required TResult Function() refresh,
  }) {
    return initialized();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialized,
    TResult? Function(String title, String description, TaskPriority priority,
            DateTime? dueDate, String category)?
        added,
    TResult? Function(Task task)? updated,
    TResult? Function(String taskId)? deleted,
    TResult? Function(String taskId)? toggled,
    TResult? Function(String query)? searched,
    TResult? Function(TaskFilter filter)? filterChanged,
    TResult? Function(TaskSortOption sortOption)? sortChanged,
    TResult? Function(TaskPriority? priority)? priorityFilterChanged,
    TResult? Function(String? category)? categoryFilterChanged,
    TResult? Function(DateTime? dueDateFilter)? dueDateFilterChanged,
    TResult? Function(List<String> taskIds, bool isCompleted)? bulkToggle,
    TResult? Function(List<String> taskIds)? bulkDelete,
    TResult? Function(List<String> taskIds, TaskPriority priority)?
        bulkUpdatePriority,
    TResult? Function(List<String> taskIds, String category)?
        bulkUpdateCategory,
    TResult? Function()? refresh,
  }) {
    return initialized?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function(String title, String description, TaskPriority priority,
            DateTime? dueDate, String category)?
        added,
    TResult Function(Task task)? updated,
    TResult Function(String taskId)? deleted,
    TResult Function(String taskId)? toggled,
    TResult Function(String query)? searched,
    TResult Function(TaskFilter filter)? filterChanged,
    TResult Function(TaskSortOption sortOption)? sortChanged,
    TResult Function(TaskPriority? priority)? priorityFilterChanged,
    TResult Function(String? category)? categoryFilterChanged,
    TResult Function(DateTime? dueDateFilter)? dueDateFilterChanged,
    TResult Function(List<String> taskIds, bool isCompleted)? bulkToggle,
    TResult Function(List<String> taskIds)? bulkDelete,
    TResult Function(List<String> taskIds, TaskPriority priority)?
        bulkUpdatePriority,
    TResult Function(List<String> taskIds, String category)? bulkUpdateCategory,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (initialized != null) {
      return initialized();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskInitialized value) initialized,
    required TResult Function(TaskAdded value) added,
    required TResult Function(TaskUpdated value) updated,
    required TResult Function(TaskDeleted value) deleted,
    required TResult Function(TaskToggled value) toggled,
    required TResult Function(TaskSearched value) searched,
    required TResult Function(TaskFilterChanged value) filterChanged,
    required TResult Function(TaskSortChanged value) sortChanged,
    required TResult Function(TaskPriorityFilterChanged value)
        priorityFilterChanged,
    required TResult Function(TaskCategoryFilterChanged value)
        categoryFilterChanged,
    required TResult Function(TaskDueDateFilterChanged value)
        dueDateFilterChanged,
    required TResult Function(TaskBulkToggle value) bulkToggle,
    required TResult Function(TaskBulkDelete value) bulkDelete,
    required TResult Function(TaskBulkUpdatePriority value) bulkUpdatePriority,
    required TResult Function(TaskBulkUpdateCategory value) bulkUpdateCategory,
    required TResult Function(TaskRefresh value) refresh,
  }) {
    return initialized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaskInitialized value)? initialized,
    TResult? Function(TaskAdded value)? added,
    TResult? Function(TaskUpdated value)? updated,
    TResult? Function(TaskDeleted value)? deleted,
    TResult? Function(TaskToggled value)? toggled,
    TResult? Function(TaskSearched value)? searched,
    TResult? Function(TaskFilterChanged value)? filterChanged,
    TResult? Function(TaskSortChanged value)? sortChanged,
    TResult? Function(TaskPriorityFilterChanged value)? priorityFilterChanged,
    TResult? Function(TaskCategoryFilterChanged value)? categoryFilterChanged,
    TResult? Function(TaskDueDateFilterChanged value)? dueDateFilterChanged,
    TResult? Function(TaskBulkToggle value)? bulkToggle,
    TResult? Function(TaskBulkDelete value)? bulkDelete,
    TResult? Function(TaskBulkUpdatePriority value)? bulkUpdatePriority,
    TResult? Function(TaskBulkUpdateCategory value)? bulkUpdateCategory,
    TResult? Function(TaskRefresh value)? refresh,
  }) {
    return initialized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskInitialized value)? initialized,
    TResult Function(TaskAdded value)? added,
    TResult Function(TaskUpdated value)? updated,
    TResult Function(TaskDeleted value)? deleted,
    TResult Function(TaskToggled value)? toggled,
    TResult Function(TaskSearched value)? searched,
    TResult Function(TaskFilterChanged value)? filterChanged,
    TResult Function(TaskSortChanged value)? sortChanged,
    TResult Function(TaskPriorityFilterChanged value)? priorityFilterChanged,
    TResult Function(TaskCategoryFilterChanged value)? categoryFilterChanged,
    TResult Function(TaskDueDateFilterChanged value)? dueDateFilterChanged,
    TResult Function(TaskBulkToggle value)? bulkToggle,
    TResult Function(TaskBulkDelete value)? bulkDelete,
    TResult Function(TaskBulkUpdatePriority value)? bulkUpdatePriority,
    TResult Function(TaskBulkUpdateCategory value)? bulkUpdateCategory,
    TResult Function(TaskRefresh value)? refresh,
    required TResult orElse(),
  }) {
    if (initialized != null) {
      return initialized(this);
    }
    return orElse();
  }
}

abstract class TaskInitialized implements TaskEvent {
  const factory TaskInitialized() = _$TaskInitializedImpl;
}

/// @nodoc
abstract class _$$TaskAddedImplCopyWith<$Res> {
  factory _$$TaskAddedImplCopyWith(
          _$TaskAddedImpl value, $Res Function(_$TaskAddedImpl) then) =
      __$$TaskAddedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String title,
      String description,
      TaskPriority priority,
      DateTime? dueDate,
      String category});
}

/// @nodoc
class __$$TaskAddedImplCopyWithImpl<$Res>
    extends _$TaskEventCopyWithImpl<$Res, _$TaskAddedImpl>
    implements _$$TaskAddedImplCopyWith<$Res> {
  __$$TaskAddedImplCopyWithImpl(
      _$TaskAddedImpl _value, $Res Function(_$TaskAddedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? priority = null,
    Object? dueDate = freezed,
    Object? category = null,
  }) {
    return _then(_$TaskAddedImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as TaskPriority,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TaskAddedImpl implements TaskAdded {
  const _$TaskAddedImpl(
      {required this.title,
      required this.description,
      this.priority = TaskPriority.medium,
      this.dueDate,
      this.category = 'General'});

  @override
  final String title;
  @override
  final String description;
  @override
  @JsonKey()
  final TaskPriority priority;
  @override
  final DateTime? dueDate;
  @override
  @JsonKey()
  final String category;

  @override
  String toString() {
    return 'TaskEvent.added(title: $title, description: $description, priority: $priority, dueDate: $dueDate, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskAddedImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, title, description, priority, dueDate, category);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskAddedImplCopyWith<_$TaskAddedImpl> get copyWith =>
      __$$TaskAddedImplCopyWithImpl<_$TaskAddedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialized,
    required TResult Function(String title, String description,
            TaskPriority priority, DateTime? dueDate, String category)
        added,
    required TResult Function(Task task) updated,
    required TResult Function(String taskId) deleted,
    required TResult Function(String taskId) toggled,
    required TResult Function(String query) searched,
    required TResult Function(TaskFilter filter) filterChanged,
    required TResult Function(TaskSortOption sortOption) sortChanged,
    required TResult Function(TaskPriority? priority) priorityFilterChanged,
    required TResult Function(String? category) categoryFilterChanged,
    required TResult Function(DateTime? dueDateFilter) dueDateFilterChanged,
    required TResult Function(List<String> taskIds, bool isCompleted)
        bulkToggle,
    required TResult Function(List<String> taskIds) bulkDelete,
    required TResult Function(List<String> taskIds, TaskPriority priority)
        bulkUpdatePriority,
    required TResult Function(List<String> taskIds, String category)
        bulkUpdateCategory,
    required TResult Function() refresh,
  }) {
    return added(title, description, priority, dueDate, category);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialized,
    TResult? Function(String title, String description, TaskPriority priority,
            DateTime? dueDate, String category)?
        added,
    TResult? Function(Task task)? updated,
    TResult? Function(String taskId)? deleted,
    TResult? Function(String taskId)? toggled,
    TResult? Function(String query)? searched,
    TResult? Function(TaskFilter filter)? filterChanged,
    TResult? Function(TaskSortOption sortOption)? sortChanged,
    TResult? Function(TaskPriority? priority)? priorityFilterChanged,
    TResult? Function(String? category)? categoryFilterChanged,
    TResult? Function(DateTime? dueDateFilter)? dueDateFilterChanged,
    TResult? Function(List<String> taskIds, bool isCompleted)? bulkToggle,
    TResult? Function(List<String> taskIds)? bulkDelete,
    TResult? Function(List<String> taskIds, TaskPriority priority)?
        bulkUpdatePriority,
    TResult? Function(List<String> taskIds, String category)?
        bulkUpdateCategory,
    TResult? Function()? refresh,
  }) {
    return added?.call(title, description, priority, dueDate, category);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function(String title, String description, TaskPriority priority,
            DateTime? dueDate, String category)?
        added,
    TResult Function(Task task)? updated,
    TResult Function(String taskId)? deleted,
    TResult Function(String taskId)? toggled,
    TResult Function(String query)? searched,
    TResult Function(TaskFilter filter)? filterChanged,
    TResult Function(TaskSortOption sortOption)? sortChanged,
    TResult Function(TaskPriority? priority)? priorityFilterChanged,
    TResult Function(String? category)? categoryFilterChanged,
    TResult Function(DateTime? dueDateFilter)? dueDateFilterChanged,
    TResult Function(List<String> taskIds, bool isCompleted)? bulkToggle,
    TResult Function(List<String> taskIds)? bulkDelete,
    TResult Function(List<String> taskIds, TaskPriority priority)?
        bulkUpdatePriority,
    TResult Function(List<String> taskIds, String category)? bulkUpdateCategory,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (added != null) {
      return added(title, description, priority, dueDate, category);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskInitialized value) initialized,
    required TResult Function(TaskAdded value) added,
    required TResult Function(TaskUpdated value) updated,
    required TResult Function(TaskDeleted value) deleted,
    required TResult Function(TaskToggled value) toggled,
    required TResult Function(TaskSearched value) searched,
    required TResult Function(TaskFilterChanged value) filterChanged,
    required TResult Function(TaskSortChanged value) sortChanged,
    required TResult Function(TaskPriorityFilterChanged value)
        priorityFilterChanged,
    required TResult Function(TaskCategoryFilterChanged value)
        categoryFilterChanged,
    required TResult Function(TaskDueDateFilterChanged value)
        dueDateFilterChanged,
    required TResult Function(TaskBulkToggle value) bulkToggle,
    required TResult Function(TaskBulkDelete value) bulkDelete,
    required TResult Function(TaskBulkUpdatePriority value) bulkUpdatePriority,
    required TResult Function(TaskBulkUpdateCategory value) bulkUpdateCategory,
    required TResult Function(TaskRefresh value) refresh,
  }) {
    return added(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaskInitialized value)? initialized,
    TResult? Function(TaskAdded value)? added,
    TResult? Function(TaskUpdated value)? updated,
    TResult? Function(TaskDeleted value)? deleted,
    TResult? Function(TaskToggled value)? toggled,
    TResult? Function(TaskSearched value)? searched,
    TResult? Function(TaskFilterChanged value)? filterChanged,
    TResult? Function(TaskSortChanged value)? sortChanged,
    TResult? Function(TaskPriorityFilterChanged value)? priorityFilterChanged,
    TResult? Function(TaskCategoryFilterChanged value)? categoryFilterChanged,
    TResult? Function(TaskDueDateFilterChanged value)? dueDateFilterChanged,
    TResult? Function(TaskBulkToggle value)? bulkToggle,
    TResult? Function(TaskBulkDelete value)? bulkDelete,
    TResult? Function(TaskBulkUpdatePriority value)? bulkUpdatePriority,
    TResult? Function(TaskBulkUpdateCategory value)? bulkUpdateCategory,
    TResult? Function(TaskRefresh value)? refresh,
  }) {
    return added?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskInitialized value)? initialized,
    TResult Function(TaskAdded value)? added,
    TResult Function(TaskUpdated value)? updated,
    TResult Function(TaskDeleted value)? deleted,
    TResult Function(TaskToggled value)? toggled,
    TResult Function(TaskSearched value)? searched,
    TResult Function(TaskFilterChanged value)? filterChanged,
    TResult Function(TaskSortChanged value)? sortChanged,
    TResult Function(TaskPriorityFilterChanged value)? priorityFilterChanged,
    TResult Function(TaskCategoryFilterChanged value)? categoryFilterChanged,
    TResult Function(TaskDueDateFilterChanged value)? dueDateFilterChanged,
    TResult Function(TaskBulkToggle value)? bulkToggle,
    TResult Function(TaskBulkDelete value)? bulkDelete,
    TResult Function(TaskBulkUpdatePriority value)? bulkUpdatePriority,
    TResult Function(TaskBulkUpdateCategory value)? bulkUpdateCategory,
    TResult Function(TaskRefresh value)? refresh,
    required TResult orElse(),
  }) {
    if (added != null) {
      return added(this);
    }
    return orElse();
  }
}

abstract class TaskAdded implements TaskEvent {
  const factory TaskAdded(
      {required final String title,
      required final String description,
      final TaskPriority priority,
      final DateTime? dueDate,
      final String category}) = _$TaskAddedImpl;

  String get title;
  String get description;
  TaskPriority get priority;
  DateTime? get dueDate;
  String get category;

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskAddedImplCopyWith<_$TaskAddedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TaskUpdatedImplCopyWith<$Res> {
  factory _$$TaskUpdatedImplCopyWith(
          _$TaskUpdatedImpl value, $Res Function(_$TaskUpdatedImpl) then) =
      __$$TaskUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Task task});

  $TaskCopyWith<$Res> get task;
}

/// @nodoc
class __$$TaskUpdatedImplCopyWithImpl<$Res>
    extends _$TaskEventCopyWithImpl<$Res, _$TaskUpdatedImpl>
    implements _$$TaskUpdatedImplCopyWith<$Res> {
  __$$TaskUpdatedImplCopyWithImpl(
      _$TaskUpdatedImpl _value, $Res Function(_$TaskUpdatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? task = null,
  }) {
    return _then(_$TaskUpdatedImpl(
      null == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as Task,
    ));
  }

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TaskCopyWith<$Res> get task {
    return $TaskCopyWith<$Res>(_value.task, (value) {
      return _then(_value.copyWith(task: value));
    });
  }
}

/// @nodoc

class _$TaskUpdatedImpl implements TaskUpdated {
  const _$TaskUpdatedImpl(this.task);

  @override
  final Task task;

  @override
  String toString() {
    return 'TaskEvent.updated(task: $task)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskUpdatedImpl &&
            (identical(other.task, task) || other.task == task));
  }

  @override
  int get hashCode => Object.hash(runtimeType, task);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskUpdatedImplCopyWith<_$TaskUpdatedImpl> get copyWith =>
      __$$TaskUpdatedImplCopyWithImpl<_$TaskUpdatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialized,
    required TResult Function(String title, String description,
            TaskPriority priority, DateTime? dueDate, String category)
        added,
    required TResult Function(Task task) updated,
    required TResult Function(String taskId) deleted,
    required TResult Function(String taskId) toggled,
    required TResult Function(String query) searched,
    required TResult Function(TaskFilter filter) filterChanged,
    required TResult Function(TaskSortOption sortOption) sortChanged,
    required TResult Function(TaskPriority? priority) priorityFilterChanged,
    required TResult Function(String? category) categoryFilterChanged,
    required TResult Function(DateTime? dueDateFilter) dueDateFilterChanged,
    required TResult Function(List<String> taskIds, bool isCompleted)
        bulkToggle,
    required TResult Function(List<String> taskIds) bulkDelete,
    required TResult Function(List<String> taskIds, TaskPriority priority)
        bulkUpdatePriority,
    required TResult Function(List<String> taskIds, String category)
        bulkUpdateCategory,
    required TResult Function() refresh,
  }) {
    return updated(task);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialized,
    TResult? Function(String title, String description, TaskPriority priority,
            DateTime? dueDate, String category)?
        added,
    TResult? Function(Task task)? updated,
    TResult? Function(String taskId)? deleted,
    TResult? Function(String taskId)? toggled,
    TResult? Function(String query)? searched,
    TResult? Function(TaskFilter filter)? filterChanged,
    TResult? Function(TaskSortOption sortOption)? sortChanged,
    TResult? Function(TaskPriority? priority)? priorityFilterChanged,
    TResult? Function(String? category)? categoryFilterChanged,
    TResult? Function(DateTime? dueDateFilter)? dueDateFilterChanged,
    TResult? Function(List<String> taskIds, bool isCompleted)? bulkToggle,
    TResult? Function(List<String> taskIds)? bulkDelete,
    TResult? Function(List<String> taskIds, TaskPriority priority)?
        bulkUpdatePriority,
    TResult? Function(List<String> taskIds, String category)?
        bulkUpdateCategory,
    TResult? Function()? refresh,
  }) {
    return updated?.call(task);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function(String title, String description, TaskPriority priority,
            DateTime? dueDate, String category)?
        added,
    TResult Function(Task task)? updated,
    TResult Function(String taskId)? deleted,
    TResult Function(String taskId)? toggled,
    TResult Function(String query)? searched,
    TResult Function(TaskFilter filter)? filterChanged,
    TResult Function(TaskSortOption sortOption)? sortChanged,
    TResult Function(TaskPriority? priority)? priorityFilterChanged,
    TResult Function(String? category)? categoryFilterChanged,
    TResult Function(DateTime? dueDateFilter)? dueDateFilterChanged,
    TResult Function(List<String> taskIds, bool isCompleted)? bulkToggle,
    TResult Function(List<String> taskIds)? bulkDelete,
    TResult Function(List<String> taskIds, TaskPriority priority)?
        bulkUpdatePriority,
    TResult Function(List<String> taskIds, String category)? bulkUpdateCategory,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(task);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskInitialized value) initialized,
    required TResult Function(TaskAdded value) added,
    required TResult Function(TaskUpdated value) updated,
    required TResult Function(TaskDeleted value) deleted,
    required TResult Function(TaskToggled value) toggled,
    required TResult Function(TaskSearched value) searched,
    required TResult Function(TaskFilterChanged value) filterChanged,
    required TResult Function(TaskSortChanged value) sortChanged,
    required TResult Function(TaskPriorityFilterChanged value)
        priorityFilterChanged,
    required TResult Function(TaskCategoryFilterChanged value)
        categoryFilterChanged,
    required TResult Function(TaskDueDateFilterChanged value)
        dueDateFilterChanged,
    required TResult Function(TaskBulkToggle value) bulkToggle,
    required TResult Function(TaskBulkDelete value) bulkDelete,
    required TResult Function(TaskBulkUpdatePriority value) bulkUpdatePriority,
    required TResult Function(TaskBulkUpdateCategory value) bulkUpdateCategory,
    required TResult Function(TaskRefresh value) refresh,
  }) {
    return updated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaskInitialized value)? initialized,
    TResult? Function(TaskAdded value)? added,
    TResult? Function(TaskUpdated value)? updated,
    TResult? Function(TaskDeleted value)? deleted,
    TResult? Function(TaskToggled value)? toggled,
    TResult? Function(TaskSearched value)? searched,
    TResult? Function(TaskFilterChanged value)? filterChanged,
    TResult? Function(TaskSortChanged value)? sortChanged,
    TResult? Function(TaskPriorityFilterChanged value)? priorityFilterChanged,
    TResult? Function(TaskCategoryFilterChanged value)? categoryFilterChanged,
    TResult? Function(TaskDueDateFilterChanged value)? dueDateFilterChanged,
    TResult? Function(TaskBulkToggle value)? bulkToggle,
    TResult? Function(TaskBulkDelete value)? bulkDelete,
    TResult? Function(TaskBulkUpdatePriority value)? bulkUpdatePriority,
    TResult? Function(TaskBulkUpdateCategory value)? bulkUpdateCategory,
    TResult? Function(TaskRefresh value)? refresh,
  }) {
    return updated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskInitialized value)? initialized,
    TResult Function(TaskAdded value)? added,
    TResult Function(TaskUpdated value)? updated,
    TResult Function(TaskDeleted value)? deleted,
    TResult Function(TaskToggled value)? toggled,
    TResult Function(TaskSearched value)? searched,
    TResult Function(TaskFilterChanged value)? filterChanged,
    TResult Function(TaskSortChanged value)? sortChanged,
    TResult Function(TaskPriorityFilterChanged value)? priorityFilterChanged,
    TResult Function(TaskCategoryFilterChanged value)? categoryFilterChanged,
    TResult Function(TaskDueDateFilterChanged value)? dueDateFilterChanged,
    TResult Function(TaskBulkToggle value)? bulkToggle,
    TResult Function(TaskBulkDelete value)? bulkDelete,
    TResult Function(TaskBulkUpdatePriority value)? bulkUpdatePriority,
    TResult Function(TaskBulkUpdateCategory value)? bulkUpdateCategory,
    TResult Function(TaskRefresh value)? refresh,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(this);
    }
    return orElse();
  }
}

abstract class TaskUpdated implements TaskEvent {
  const factory TaskUpdated(final Task task) = _$TaskUpdatedImpl;

  Task get task;

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskUpdatedImplCopyWith<_$TaskUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TaskDeletedImplCopyWith<$Res> {
  factory _$$TaskDeletedImplCopyWith(
          _$TaskDeletedImpl value, $Res Function(_$TaskDeletedImpl) then) =
      __$$TaskDeletedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String taskId});
}

/// @nodoc
class __$$TaskDeletedImplCopyWithImpl<$Res>
    extends _$TaskEventCopyWithImpl<$Res, _$TaskDeletedImpl>
    implements _$$TaskDeletedImplCopyWith<$Res> {
  __$$TaskDeletedImplCopyWithImpl(
      _$TaskDeletedImpl _value, $Res Function(_$TaskDeletedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
  }) {
    return _then(_$TaskDeletedImpl(
      null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TaskDeletedImpl implements TaskDeleted {
  const _$TaskDeletedImpl(this.taskId);

  @override
  final String taskId;

  @override
  String toString() {
    return 'TaskEvent.deleted(taskId: $taskId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskDeletedImpl &&
            (identical(other.taskId, taskId) || other.taskId == taskId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, taskId);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskDeletedImplCopyWith<_$TaskDeletedImpl> get copyWith =>
      __$$TaskDeletedImplCopyWithImpl<_$TaskDeletedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialized,
    required TResult Function(String title, String description,
            TaskPriority priority, DateTime? dueDate, String category)
        added,
    required TResult Function(Task task) updated,
    required TResult Function(String taskId) deleted,
    required TResult Function(String taskId) toggled,
    required TResult Function(String query) searched,
    required TResult Function(TaskFilter filter) filterChanged,
    required TResult Function(TaskSortOption sortOption) sortChanged,
    required TResult Function(TaskPriority? priority) priorityFilterChanged,
    required TResult Function(String? category) categoryFilterChanged,
    required TResult Function(DateTime? dueDateFilter) dueDateFilterChanged,
    required TResult Function(List<String> taskIds, bool isCompleted)
        bulkToggle,
    required TResult Function(List<String> taskIds) bulkDelete,
    required TResult Function(List<String> taskIds, TaskPriority priority)
        bulkUpdatePriority,
    required TResult Function(List<String> taskIds, String category)
        bulkUpdateCategory,
    required TResult Function() refresh,
  }) {
    return deleted(taskId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialized,
    TResult? Function(String title, String description, TaskPriority priority,
            DateTime? dueDate, String category)?
        added,
    TResult? Function(Task task)? updated,
    TResult? Function(String taskId)? deleted,
    TResult? Function(String taskId)? toggled,
    TResult? Function(String query)? searched,
    TResult? Function(TaskFilter filter)? filterChanged,
    TResult? Function(TaskSortOption sortOption)? sortChanged,
    TResult? Function(TaskPriority? priority)? priorityFilterChanged,
    TResult? Function(String? category)? categoryFilterChanged,
    TResult? Function(DateTime? dueDateFilter)? dueDateFilterChanged,
    TResult? Function(List<String> taskIds, bool isCompleted)? bulkToggle,
    TResult? Function(List<String> taskIds)? bulkDelete,
    TResult? Function(List<String> taskIds, TaskPriority priority)?
        bulkUpdatePriority,
    TResult? Function(List<String> taskIds, String category)?
        bulkUpdateCategory,
    TResult? Function()? refresh,
  }) {
    return deleted?.call(taskId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function(String title, String description, TaskPriority priority,
            DateTime? dueDate, String category)?
        added,
    TResult Function(Task task)? updated,
    TResult Function(String taskId)? deleted,
    TResult Function(String taskId)? toggled,
    TResult Function(String query)? searched,
    TResult Function(TaskFilter filter)? filterChanged,
    TResult Function(TaskSortOption sortOption)? sortChanged,
    TResult Function(TaskPriority? priority)? priorityFilterChanged,
    TResult Function(String? category)? categoryFilterChanged,
    TResult Function(DateTime? dueDateFilter)? dueDateFilterChanged,
    TResult Function(List<String> taskIds, bool isCompleted)? bulkToggle,
    TResult Function(List<String> taskIds)? bulkDelete,
    TResult Function(List<String> taskIds, TaskPriority priority)?
        bulkUpdatePriority,
    TResult Function(List<String> taskIds, String category)? bulkUpdateCategory,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (deleted != null) {
      return deleted(taskId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskInitialized value) initialized,
    required TResult Function(TaskAdded value) added,
    required TResult Function(TaskUpdated value) updated,
    required TResult Function(TaskDeleted value) deleted,
    required TResult Function(TaskToggled value) toggled,
    required TResult Function(TaskSearched value) searched,
    required TResult Function(TaskFilterChanged value) filterChanged,
    required TResult Function(TaskSortChanged value) sortChanged,
    required TResult Function(TaskPriorityFilterChanged value)
        priorityFilterChanged,
    required TResult Function(TaskCategoryFilterChanged value)
        categoryFilterChanged,
    required TResult Function(TaskDueDateFilterChanged value)
        dueDateFilterChanged,
    required TResult Function(TaskBulkToggle value) bulkToggle,
    required TResult Function(TaskBulkDelete value) bulkDelete,
    required TResult Function(TaskBulkUpdatePriority value) bulkUpdatePriority,
    required TResult Function(TaskBulkUpdateCategory value) bulkUpdateCategory,
    required TResult Function(TaskRefresh value) refresh,
  }) {
    return deleted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaskInitialized value)? initialized,
    TResult? Function(TaskAdded value)? added,
    TResult? Function(TaskUpdated value)? updated,
    TResult? Function(TaskDeleted value)? deleted,
    TResult? Function(TaskToggled value)? toggled,
    TResult? Function(TaskSearched value)? searched,
    TResult? Function(TaskFilterChanged value)? filterChanged,
    TResult? Function(TaskSortChanged value)? sortChanged,
    TResult? Function(TaskPriorityFilterChanged value)? priorityFilterChanged,
    TResult? Function(TaskCategoryFilterChanged value)? categoryFilterChanged,
    TResult? Function(TaskDueDateFilterChanged value)? dueDateFilterChanged,
    TResult? Function(TaskBulkToggle value)? bulkToggle,
    TResult? Function(TaskBulkDelete value)? bulkDelete,
    TResult? Function(TaskBulkUpdatePriority value)? bulkUpdatePriority,
    TResult? Function(TaskBulkUpdateCategory value)? bulkUpdateCategory,
    TResult? Function(TaskRefresh value)? refresh,
  }) {
    return deleted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskInitialized value)? initialized,
    TResult Function(TaskAdded value)? added,
    TResult Function(TaskUpdated value)? updated,
    TResult Function(TaskDeleted value)? deleted,
    TResult Function(TaskToggled value)? toggled,
    TResult Function(TaskSearched value)? searched,
    TResult Function(TaskFilterChanged value)? filterChanged,
    TResult Function(TaskSortChanged value)? sortChanged,
    TResult Function(TaskPriorityFilterChanged value)? priorityFilterChanged,
    TResult Function(TaskCategoryFilterChanged value)? categoryFilterChanged,
    TResult Function(TaskDueDateFilterChanged value)? dueDateFilterChanged,
    TResult Function(TaskBulkToggle value)? bulkToggle,
    TResult Function(TaskBulkDelete value)? bulkDelete,
    TResult Function(TaskBulkUpdatePriority value)? bulkUpdatePriority,
    TResult Function(TaskBulkUpdateCategory value)? bulkUpdateCategory,
    TResult Function(TaskRefresh value)? refresh,
    required TResult orElse(),
  }) {
    if (deleted != null) {
      return deleted(this);
    }
    return orElse();
  }
}

abstract class TaskDeleted implements TaskEvent {
  const factory TaskDeleted(final String taskId) = _$TaskDeletedImpl;

  String get taskId;

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskDeletedImplCopyWith<_$TaskDeletedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TaskToggledImplCopyWith<$Res> {
  factory _$$TaskToggledImplCopyWith(
          _$TaskToggledImpl value, $Res Function(_$TaskToggledImpl) then) =
      __$$TaskToggledImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String taskId});
}

/// @nodoc
class __$$TaskToggledImplCopyWithImpl<$Res>
    extends _$TaskEventCopyWithImpl<$Res, _$TaskToggledImpl>
    implements _$$TaskToggledImplCopyWith<$Res> {
  __$$TaskToggledImplCopyWithImpl(
      _$TaskToggledImpl _value, $Res Function(_$TaskToggledImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
  }) {
    return _then(_$TaskToggledImpl(
      null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TaskToggledImpl implements TaskToggled {
  const _$TaskToggledImpl(this.taskId);

  @override
  final String taskId;

  @override
  String toString() {
    return 'TaskEvent.toggled(taskId: $taskId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskToggledImpl &&
            (identical(other.taskId, taskId) || other.taskId == taskId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, taskId);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskToggledImplCopyWith<_$TaskToggledImpl> get copyWith =>
      __$$TaskToggledImplCopyWithImpl<_$TaskToggledImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialized,
    required TResult Function(String title, String description,
            TaskPriority priority, DateTime? dueDate, String category)
        added,
    required TResult Function(Task task) updated,
    required TResult Function(String taskId) deleted,
    required TResult Function(String taskId) toggled,
    required TResult Function(String query) searched,
    required TResult Function(TaskFilter filter) filterChanged,
    required TResult Function(TaskSortOption sortOption) sortChanged,
    required TResult Function(TaskPriority? priority) priorityFilterChanged,
    required TResult Function(String? category) categoryFilterChanged,
    required TResult Function(DateTime? dueDateFilter) dueDateFilterChanged,
    required TResult Function(List<String> taskIds, bool isCompleted)
        bulkToggle,
    required TResult Function(List<String> taskIds) bulkDelete,
    required TResult Function(List<String> taskIds, TaskPriority priority)
        bulkUpdatePriority,
    required TResult Function(List<String> taskIds, String category)
        bulkUpdateCategory,
    required TResult Function() refresh,
  }) {
    return toggled(taskId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialized,
    TResult? Function(String title, String description, TaskPriority priority,
            DateTime? dueDate, String category)?
        added,
    TResult? Function(Task task)? updated,
    TResult? Function(String taskId)? deleted,
    TResult? Function(String taskId)? toggled,
    TResult? Function(String query)? searched,
    TResult? Function(TaskFilter filter)? filterChanged,
    TResult? Function(TaskSortOption sortOption)? sortChanged,
    TResult? Function(TaskPriority? priority)? priorityFilterChanged,
    TResult? Function(String? category)? categoryFilterChanged,
    TResult? Function(DateTime? dueDateFilter)? dueDateFilterChanged,
    TResult? Function(List<String> taskIds, bool isCompleted)? bulkToggle,
    TResult? Function(List<String> taskIds)? bulkDelete,
    TResult? Function(List<String> taskIds, TaskPriority priority)?
        bulkUpdatePriority,
    TResult? Function(List<String> taskIds, String category)?
        bulkUpdateCategory,
    TResult? Function()? refresh,
  }) {
    return toggled?.call(taskId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function(String title, String description, TaskPriority priority,
            DateTime? dueDate, String category)?
        added,
    TResult Function(Task task)? updated,
    TResult Function(String taskId)? deleted,
    TResult Function(String taskId)? toggled,
    TResult Function(String query)? searched,
    TResult Function(TaskFilter filter)? filterChanged,
    TResult Function(TaskSortOption sortOption)? sortChanged,
    TResult Function(TaskPriority? priority)? priorityFilterChanged,
    TResult Function(String? category)? categoryFilterChanged,
    TResult Function(DateTime? dueDateFilter)? dueDateFilterChanged,
    TResult Function(List<String> taskIds, bool isCompleted)? bulkToggle,
    TResult Function(List<String> taskIds)? bulkDelete,
    TResult Function(List<String> taskIds, TaskPriority priority)?
        bulkUpdatePriority,
    TResult Function(List<String> taskIds, String category)? bulkUpdateCategory,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (toggled != null) {
      return toggled(taskId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskInitialized value) initialized,
    required TResult Function(TaskAdded value) added,
    required TResult Function(TaskUpdated value) updated,
    required TResult Function(TaskDeleted value) deleted,
    required TResult Function(TaskToggled value) toggled,
    required TResult Function(TaskSearched value) searched,
    required TResult Function(TaskFilterChanged value) filterChanged,
    required TResult Function(TaskSortChanged value) sortChanged,
    required TResult Function(TaskPriorityFilterChanged value)
        priorityFilterChanged,
    required TResult Function(TaskCategoryFilterChanged value)
        categoryFilterChanged,
    required TResult Function(TaskDueDateFilterChanged value)
        dueDateFilterChanged,
    required TResult Function(TaskBulkToggle value) bulkToggle,
    required TResult Function(TaskBulkDelete value) bulkDelete,
    required TResult Function(TaskBulkUpdatePriority value) bulkUpdatePriority,
    required TResult Function(TaskBulkUpdateCategory value) bulkUpdateCategory,
    required TResult Function(TaskRefresh value) refresh,
  }) {
    return toggled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaskInitialized value)? initialized,
    TResult? Function(TaskAdded value)? added,
    TResult? Function(TaskUpdated value)? updated,
    TResult? Function(TaskDeleted value)? deleted,
    TResult? Function(TaskToggled value)? toggled,
    TResult? Function(TaskSearched value)? searched,
    TResult? Function(TaskFilterChanged value)? filterChanged,
    TResult? Function(TaskSortChanged value)? sortChanged,
    TResult? Function(TaskPriorityFilterChanged value)? priorityFilterChanged,
    TResult? Function(TaskCategoryFilterChanged value)? categoryFilterChanged,
    TResult? Function(TaskDueDateFilterChanged value)? dueDateFilterChanged,
    TResult? Function(TaskBulkToggle value)? bulkToggle,
    TResult? Function(TaskBulkDelete value)? bulkDelete,
    TResult? Function(TaskBulkUpdatePriority value)? bulkUpdatePriority,
    TResult? Function(TaskBulkUpdateCategory value)? bulkUpdateCategory,
    TResult? Function(TaskRefresh value)? refresh,
  }) {
    return toggled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskInitialized value)? initialized,
    TResult Function(TaskAdded value)? added,
    TResult Function(TaskUpdated value)? updated,
    TResult Function(TaskDeleted value)? deleted,
    TResult Function(TaskToggled value)? toggled,
    TResult Function(TaskSearched value)? searched,
    TResult Function(TaskFilterChanged value)? filterChanged,
    TResult Function(TaskSortChanged value)? sortChanged,
    TResult Function(TaskPriorityFilterChanged value)? priorityFilterChanged,
    TResult Function(TaskCategoryFilterChanged value)? categoryFilterChanged,
    TResult Function(TaskDueDateFilterChanged value)? dueDateFilterChanged,
    TResult Function(TaskBulkToggle value)? bulkToggle,
    TResult Function(TaskBulkDelete value)? bulkDelete,
    TResult Function(TaskBulkUpdatePriority value)? bulkUpdatePriority,
    TResult Function(TaskBulkUpdateCategory value)? bulkUpdateCategory,
    TResult Function(TaskRefresh value)? refresh,
    required TResult orElse(),
  }) {
    if (toggled != null) {
      return toggled(this);
    }
    return orElse();
  }
}

abstract class TaskToggled implements TaskEvent {
  const factory TaskToggled(final String taskId) = _$TaskToggledImpl;

  String get taskId;

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskToggledImplCopyWith<_$TaskToggledImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TaskSearchedImplCopyWith<$Res> {
  factory _$$TaskSearchedImplCopyWith(
          _$TaskSearchedImpl value, $Res Function(_$TaskSearchedImpl) then) =
      __$$TaskSearchedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$$TaskSearchedImplCopyWithImpl<$Res>
    extends _$TaskEventCopyWithImpl<$Res, _$TaskSearchedImpl>
    implements _$$TaskSearchedImplCopyWith<$Res> {
  __$$TaskSearchedImplCopyWithImpl(
      _$TaskSearchedImpl _value, $Res Function(_$TaskSearchedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
  }) {
    return _then(_$TaskSearchedImpl(
      null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TaskSearchedImpl implements TaskSearched {
  const _$TaskSearchedImpl(this.query);

  @override
  final String query;

  @override
  String toString() {
    return 'TaskEvent.searched(query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskSearchedImpl &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskSearchedImplCopyWith<_$TaskSearchedImpl> get copyWith =>
      __$$TaskSearchedImplCopyWithImpl<_$TaskSearchedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialized,
    required TResult Function(String title, String description,
            TaskPriority priority, DateTime? dueDate, String category)
        added,
    required TResult Function(Task task) updated,
    required TResult Function(String taskId) deleted,
    required TResult Function(String taskId) toggled,
    required TResult Function(String query) searched,
    required TResult Function(TaskFilter filter) filterChanged,
    required TResult Function(TaskSortOption sortOption) sortChanged,
    required TResult Function(TaskPriority? priority) priorityFilterChanged,
    required TResult Function(String? category) categoryFilterChanged,
    required TResult Function(DateTime? dueDateFilter) dueDateFilterChanged,
    required TResult Function(List<String> taskIds, bool isCompleted)
        bulkToggle,
    required TResult Function(List<String> taskIds) bulkDelete,
    required TResult Function(List<String> taskIds, TaskPriority priority)
        bulkUpdatePriority,
    required TResult Function(List<String> taskIds, String category)
        bulkUpdateCategory,
    required TResult Function() refresh,
  }) {
    return searched(query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialized,
    TResult? Function(String title, String description, TaskPriority priority,
            DateTime? dueDate, String category)?
        added,
    TResult? Function(Task task)? updated,
    TResult? Function(String taskId)? deleted,
    TResult? Function(String taskId)? toggled,
    TResult? Function(String query)? searched,
    TResult? Function(TaskFilter filter)? filterChanged,
    TResult? Function(TaskSortOption sortOption)? sortChanged,
    TResult? Function(TaskPriority? priority)? priorityFilterChanged,
    TResult? Function(String? category)? categoryFilterChanged,
    TResult? Function(DateTime? dueDateFilter)? dueDateFilterChanged,
    TResult? Function(List<String> taskIds, bool isCompleted)? bulkToggle,
    TResult? Function(List<String> taskIds)? bulkDelete,
    TResult? Function(List<String> taskIds, TaskPriority priority)?
        bulkUpdatePriority,
    TResult? Function(List<String> taskIds, String category)?
        bulkUpdateCategory,
    TResult? Function()? refresh,
  }) {
    return searched?.call(query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function(String title, String description, TaskPriority priority,
            DateTime? dueDate, String category)?
        added,
    TResult Function(Task task)? updated,
    TResult Function(String taskId)? deleted,
    TResult Function(String taskId)? toggled,
    TResult Function(String query)? searched,
    TResult Function(TaskFilter filter)? filterChanged,
    TResult Function(TaskSortOption sortOption)? sortChanged,
    TResult Function(TaskPriority? priority)? priorityFilterChanged,
    TResult Function(String? category)? categoryFilterChanged,
    TResult Function(DateTime? dueDateFilter)? dueDateFilterChanged,
    TResult Function(List<String> taskIds, bool isCompleted)? bulkToggle,
    TResult Function(List<String> taskIds)? bulkDelete,
    TResult Function(List<String> taskIds, TaskPriority priority)?
        bulkUpdatePriority,
    TResult Function(List<String> taskIds, String category)? bulkUpdateCategory,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (searched != null) {
      return searched(query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskInitialized value) initialized,
    required TResult Function(TaskAdded value) added,
    required TResult Function(TaskUpdated value) updated,
    required TResult Function(TaskDeleted value) deleted,
    required TResult Function(TaskToggled value) toggled,
    required TResult Function(TaskSearched value) searched,
    required TResult Function(TaskFilterChanged value) filterChanged,
    required TResult Function(TaskSortChanged value) sortChanged,
    required TResult Function(TaskPriorityFilterChanged value)
        priorityFilterChanged,
    required TResult Function(TaskCategoryFilterChanged value)
        categoryFilterChanged,
    required TResult Function(TaskDueDateFilterChanged value)
        dueDateFilterChanged,
    required TResult Function(TaskBulkToggle value) bulkToggle,
    required TResult Function(TaskBulkDelete value) bulkDelete,
    required TResult Function(TaskBulkUpdatePriority value) bulkUpdatePriority,
    required TResult Function(TaskBulkUpdateCategory value) bulkUpdateCategory,
    required TResult Function(TaskRefresh value) refresh,
  }) {
    return searched(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaskInitialized value)? initialized,
    TResult? Function(TaskAdded value)? added,
    TResult? Function(TaskUpdated value)? updated,
    TResult? Function(TaskDeleted value)? deleted,
    TResult? Function(TaskToggled value)? toggled,
    TResult? Function(TaskSearched value)? searched,
    TResult? Function(TaskFilterChanged value)? filterChanged,
    TResult? Function(TaskSortChanged value)? sortChanged,
    TResult? Function(TaskPriorityFilterChanged value)? priorityFilterChanged,
    TResult? Function(TaskCategoryFilterChanged value)? categoryFilterChanged,
    TResult? Function(TaskDueDateFilterChanged value)? dueDateFilterChanged,
    TResult? Function(TaskBulkToggle value)? bulkToggle,
    TResult? Function(TaskBulkDelete value)? bulkDelete,
    TResult? Function(TaskBulkUpdatePriority value)? bulkUpdatePriority,
    TResult? Function(TaskBulkUpdateCategory value)? bulkUpdateCategory,
    TResult? Function(TaskRefresh value)? refresh,
  }) {
    return searched?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskInitialized value)? initialized,
    TResult Function(TaskAdded value)? added,
    TResult Function(TaskUpdated value)? updated,
    TResult Function(TaskDeleted value)? deleted,
    TResult Function(TaskToggled value)? toggled,
    TResult Function(TaskSearched value)? searched,
    TResult Function(TaskFilterChanged value)? filterChanged,
    TResult Function(TaskSortChanged value)? sortChanged,
    TResult Function(TaskPriorityFilterChanged value)? priorityFilterChanged,
    TResult Function(TaskCategoryFilterChanged value)? categoryFilterChanged,
    TResult Function(TaskDueDateFilterChanged value)? dueDateFilterChanged,
    TResult Function(TaskBulkToggle value)? bulkToggle,
    TResult Function(TaskBulkDelete value)? bulkDelete,
    TResult Function(TaskBulkUpdatePriority value)? bulkUpdatePriority,
    TResult Function(TaskBulkUpdateCategory value)? bulkUpdateCategory,
    TResult Function(TaskRefresh value)? refresh,
    required TResult orElse(),
  }) {
    if (searched != null) {
      return searched(this);
    }
    return orElse();
  }
}

abstract class TaskSearched implements TaskEvent {
  const factory TaskSearched(final String query) = _$TaskSearchedImpl;

  String get query;

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskSearchedImplCopyWith<_$TaskSearchedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TaskFilterChangedImplCopyWith<$Res> {
  factory _$$TaskFilterChangedImplCopyWith(_$TaskFilterChangedImpl value,
          $Res Function(_$TaskFilterChangedImpl) then) =
      __$$TaskFilterChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TaskFilter filter});
}

/// @nodoc
class __$$TaskFilterChangedImplCopyWithImpl<$Res>
    extends _$TaskEventCopyWithImpl<$Res, _$TaskFilterChangedImpl>
    implements _$$TaskFilterChangedImplCopyWith<$Res> {
  __$$TaskFilterChangedImplCopyWithImpl(_$TaskFilterChangedImpl _value,
      $Res Function(_$TaskFilterChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filter = null,
  }) {
    return _then(_$TaskFilterChangedImpl(
      null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as TaskFilter,
    ));
  }
}

/// @nodoc

class _$TaskFilterChangedImpl implements TaskFilterChanged {
  const _$TaskFilterChangedImpl(this.filter);

  @override
  final TaskFilter filter;

  @override
  String toString() {
    return 'TaskEvent.filterChanged(filter: $filter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskFilterChangedImpl &&
            (identical(other.filter, filter) || other.filter == filter));
  }

  @override
  int get hashCode => Object.hash(runtimeType, filter);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskFilterChangedImplCopyWith<_$TaskFilterChangedImpl> get copyWith =>
      __$$TaskFilterChangedImplCopyWithImpl<_$TaskFilterChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialized,
    required TResult Function(String title, String description,
            TaskPriority priority, DateTime? dueDate, String category)
        added,
    required TResult Function(Task task) updated,
    required TResult Function(String taskId) deleted,
    required TResult Function(String taskId) toggled,
    required TResult Function(String query) searched,
    required TResult Function(TaskFilter filter) filterChanged,
    required TResult Function(TaskSortOption sortOption) sortChanged,
    required TResult Function(TaskPriority? priority) priorityFilterChanged,
    required TResult Function(String? category) categoryFilterChanged,
    required TResult Function(DateTime? dueDateFilter) dueDateFilterChanged,
    required TResult Function(List<String> taskIds, bool isCompleted)
        bulkToggle,
    required TResult Function(List<String> taskIds) bulkDelete,
    required TResult Function(List<String> taskIds, TaskPriority priority)
        bulkUpdatePriority,
    required TResult Function(List<String> taskIds, String category)
        bulkUpdateCategory,
    required TResult Function() refresh,
  }) {
    return filterChanged(filter);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialized,
    TResult? Function(String title, String description, TaskPriority priority,
            DateTime? dueDate, String category)?
        added,
    TResult? Function(Task task)? updated,
    TResult? Function(String taskId)? deleted,
    TResult? Function(String taskId)? toggled,
    TResult? Function(String query)? searched,
    TResult? Function(TaskFilter filter)? filterChanged,
    TResult? Function(TaskSortOption sortOption)? sortChanged,
    TResult? Function(TaskPriority? priority)? priorityFilterChanged,
    TResult? Function(String? category)? categoryFilterChanged,
    TResult? Function(DateTime? dueDateFilter)? dueDateFilterChanged,
    TResult? Function(List<String> taskIds, bool isCompleted)? bulkToggle,
    TResult? Function(List<String> taskIds)? bulkDelete,
    TResult? Function(List<String> taskIds, TaskPriority priority)?
        bulkUpdatePriority,
    TResult? Function(List<String> taskIds, String category)?
        bulkUpdateCategory,
    TResult? Function()? refresh,
  }) {
    return filterChanged?.call(filter);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function(String title, String description, TaskPriority priority,
            DateTime? dueDate, String category)?
        added,
    TResult Function(Task task)? updated,
    TResult Function(String taskId)? deleted,
    TResult Function(String taskId)? toggled,
    TResult Function(String query)? searched,
    TResult Function(TaskFilter filter)? filterChanged,
    TResult Function(TaskSortOption sortOption)? sortChanged,
    TResult Function(TaskPriority? priority)? priorityFilterChanged,
    TResult Function(String? category)? categoryFilterChanged,
    TResult Function(DateTime? dueDateFilter)? dueDateFilterChanged,
    TResult Function(List<String> taskIds, bool isCompleted)? bulkToggle,
    TResult Function(List<String> taskIds)? bulkDelete,
    TResult Function(List<String> taskIds, TaskPriority priority)?
        bulkUpdatePriority,
    TResult Function(List<String> taskIds, String category)? bulkUpdateCategory,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (filterChanged != null) {
      return filterChanged(filter);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskInitialized value) initialized,
    required TResult Function(TaskAdded value) added,
    required TResult Function(TaskUpdated value) updated,
    required TResult Function(TaskDeleted value) deleted,
    required TResult Function(TaskToggled value) toggled,
    required TResult Function(TaskSearched value) searched,
    required TResult Function(TaskFilterChanged value) filterChanged,
    required TResult Function(TaskSortChanged value) sortChanged,
    required TResult Function(TaskPriorityFilterChanged value)
        priorityFilterChanged,
    required TResult Function(TaskCategoryFilterChanged value)
        categoryFilterChanged,
    required TResult Function(TaskDueDateFilterChanged value)
        dueDateFilterChanged,
    required TResult Function(TaskBulkToggle value) bulkToggle,
    required TResult Function(TaskBulkDelete value) bulkDelete,
    required TResult Function(TaskBulkUpdatePriority value) bulkUpdatePriority,
    required TResult Function(TaskBulkUpdateCategory value) bulkUpdateCategory,
    required TResult Function(TaskRefresh value) refresh,
  }) {
    return filterChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaskInitialized value)? initialized,
    TResult? Function(TaskAdded value)? added,
    TResult? Function(TaskUpdated value)? updated,
    TResult? Function(TaskDeleted value)? deleted,
    TResult? Function(TaskToggled value)? toggled,
    TResult? Function(TaskSearched value)? searched,
    TResult? Function(TaskFilterChanged value)? filterChanged,
    TResult? Function(TaskSortChanged value)? sortChanged,
    TResult? Function(TaskPriorityFilterChanged value)? priorityFilterChanged,
    TResult? Function(TaskCategoryFilterChanged value)? categoryFilterChanged,
    TResult? Function(TaskDueDateFilterChanged value)? dueDateFilterChanged,
    TResult? Function(TaskBulkToggle value)? bulkToggle,
    TResult? Function(TaskBulkDelete value)? bulkDelete,
    TResult? Function(TaskBulkUpdatePriority value)? bulkUpdatePriority,
    TResult? Function(TaskBulkUpdateCategory value)? bulkUpdateCategory,
    TResult? Function(TaskRefresh value)? refresh,
  }) {
    return filterChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskInitialized value)? initialized,
    TResult Function(TaskAdded value)? added,
    TResult Function(TaskUpdated value)? updated,
    TResult Function(TaskDeleted value)? deleted,
    TResult Function(TaskToggled value)? toggled,
    TResult Function(TaskSearched value)? searched,
    TResult Function(TaskFilterChanged value)? filterChanged,
    TResult Function(TaskSortChanged value)? sortChanged,
    TResult Function(TaskPriorityFilterChanged value)? priorityFilterChanged,
    TResult Function(TaskCategoryFilterChanged value)? categoryFilterChanged,
    TResult Function(TaskDueDateFilterChanged value)? dueDateFilterChanged,
    TResult Function(TaskBulkToggle value)? bulkToggle,
    TResult Function(TaskBulkDelete value)? bulkDelete,
    TResult Function(TaskBulkUpdatePriority value)? bulkUpdatePriority,
    TResult Function(TaskBulkUpdateCategory value)? bulkUpdateCategory,
    TResult Function(TaskRefresh value)? refresh,
    required TResult orElse(),
  }) {
    if (filterChanged != null) {
      return filterChanged(this);
    }
    return orElse();
  }
}

abstract class TaskFilterChanged implements TaskEvent {
  const factory TaskFilterChanged(final TaskFilter filter) =
      _$TaskFilterChangedImpl;

  TaskFilter get filter;

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskFilterChangedImplCopyWith<_$TaskFilterChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TaskSortChangedImplCopyWith<$Res> {
  factory _$$TaskSortChangedImplCopyWith(_$TaskSortChangedImpl value,
          $Res Function(_$TaskSortChangedImpl) then) =
      __$$TaskSortChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TaskSortOption sortOption});
}

/// @nodoc
class __$$TaskSortChangedImplCopyWithImpl<$Res>
    extends _$TaskEventCopyWithImpl<$Res, _$TaskSortChangedImpl>
    implements _$$TaskSortChangedImplCopyWith<$Res> {
  __$$TaskSortChangedImplCopyWithImpl(
      _$TaskSortChangedImpl _value, $Res Function(_$TaskSortChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sortOption = null,
  }) {
    return _then(_$TaskSortChangedImpl(
      null == sortOption
          ? _value.sortOption
          : sortOption // ignore: cast_nullable_to_non_nullable
              as TaskSortOption,
    ));
  }
}

/// @nodoc

class _$TaskSortChangedImpl implements TaskSortChanged {
  const _$TaskSortChangedImpl(this.sortOption);

  @override
  final TaskSortOption sortOption;

  @override
  String toString() {
    return 'TaskEvent.sortChanged(sortOption: $sortOption)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskSortChangedImpl &&
            (identical(other.sortOption, sortOption) ||
                other.sortOption == sortOption));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sortOption);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskSortChangedImplCopyWith<_$TaskSortChangedImpl> get copyWith =>
      __$$TaskSortChangedImplCopyWithImpl<_$TaskSortChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialized,
    required TResult Function(String title, String description,
            TaskPriority priority, DateTime? dueDate, String category)
        added,
    required TResult Function(Task task) updated,
    required TResult Function(String taskId) deleted,
    required TResult Function(String taskId) toggled,
    required TResult Function(String query) searched,
    required TResult Function(TaskFilter filter) filterChanged,
    required TResult Function(TaskSortOption sortOption) sortChanged,
    required TResult Function(TaskPriority? priority) priorityFilterChanged,
    required TResult Function(String? category) categoryFilterChanged,
    required TResult Function(DateTime? dueDateFilter) dueDateFilterChanged,
    required TResult Function(List<String> taskIds, bool isCompleted)
        bulkToggle,
    required TResult Function(List<String> taskIds) bulkDelete,
    required TResult Function(List<String> taskIds, TaskPriority priority)
        bulkUpdatePriority,
    required TResult Function(List<String> taskIds, String category)
        bulkUpdateCategory,
    required TResult Function() refresh,
  }) {
    return sortChanged(sortOption);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialized,
    TResult? Function(String title, String description, TaskPriority priority,
            DateTime? dueDate, String category)?
        added,
    TResult? Function(Task task)? updated,
    TResult? Function(String taskId)? deleted,
    TResult? Function(String taskId)? toggled,
    TResult? Function(String query)? searched,
    TResult? Function(TaskFilter filter)? filterChanged,
    TResult? Function(TaskSortOption sortOption)? sortChanged,
    TResult? Function(TaskPriority? priority)? priorityFilterChanged,
    TResult? Function(String? category)? categoryFilterChanged,
    TResult? Function(DateTime? dueDateFilter)? dueDateFilterChanged,
    TResult? Function(List<String> taskIds, bool isCompleted)? bulkToggle,
    TResult? Function(List<String> taskIds)? bulkDelete,
    TResult? Function(List<String> taskIds, TaskPriority priority)?
        bulkUpdatePriority,
    TResult? Function(List<String> taskIds, String category)?
        bulkUpdateCategory,
    TResult? Function()? refresh,
  }) {
    return sortChanged?.call(sortOption);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function(String title, String description, TaskPriority priority,
            DateTime? dueDate, String category)?
        added,
    TResult Function(Task task)? updated,
    TResult Function(String taskId)? deleted,
    TResult Function(String taskId)? toggled,
    TResult Function(String query)? searched,
    TResult Function(TaskFilter filter)? filterChanged,
    TResult Function(TaskSortOption sortOption)? sortChanged,
    TResult Function(TaskPriority? priority)? priorityFilterChanged,
    TResult Function(String? category)? categoryFilterChanged,
    TResult Function(DateTime? dueDateFilter)? dueDateFilterChanged,
    TResult Function(List<String> taskIds, bool isCompleted)? bulkToggle,
    TResult Function(List<String> taskIds)? bulkDelete,
    TResult Function(List<String> taskIds, TaskPriority priority)?
        bulkUpdatePriority,
    TResult Function(List<String> taskIds, String category)? bulkUpdateCategory,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (sortChanged != null) {
      return sortChanged(sortOption);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskInitialized value) initialized,
    required TResult Function(TaskAdded value) added,
    required TResult Function(TaskUpdated value) updated,
    required TResult Function(TaskDeleted value) deleted,
    required TResult Function(TaskToggled value) toggled,
    required TResult Function(TaskSearched value) searched,
    required TResult Function(TaskFilterChanged value) filterChanged,
    required TResult Function(TaskSortChanged value) sortChanged,
    required TResult Function(TaskPriorityFilterChanged value)
        priorityFilterChanged,
    required TResult Function(TaskCategoryFilterChanged value)
        categoryFilterChanged,
    required TResult Function(TaskDueDateFilterChanged value)
        dueDateFilterChanged,
    required TResult Function(TaskBulkToggle value) bulkToggle,
    required TResult Function(TaskBulkDelete value) bulkDelete,
    required TResult Function(TaskBulkUpdatePriority value) bulkUpdatePriority,
    required TResult Function(TaskBulkUpdateCategory value) bulkUpdateCategory,
    required TResult Function(TaskRefresh value) refresh,
  }) {
    return sortChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaskInitialized value)? initialized,
    TResult? Function(TaskAdded value)? added,
    TResult? Function(TaskUpdated value)? updated,
    TResult? Function(TaskDeleted value)? deleted,
    TResult? Function(TaskToggled value)? toggled,
    TResult? Function(TaskSearched value)? searched,
    TResult? Function(TaskFilterChanged value)? filterChanged,
    TResult? Function(TaskSortChanged value)? sortChanged,
    TResult? Function(TaskPriorityFilterChanged value)? priorityFilterChanged,
    TResult? Function(TaskCategoryFilterChanged value)? categoryFilterChanged,
    TResult? Function(TaskDueDateFilterChanged value)? dueDateFilterChanged,
    TResult? Function(TaskBulkToggle value)? bulkToggle,
    TResult? Function(TaskBulkDelete value)? bulkDelete,
    TResult? Function(TaskBulkUpdatePriority value)? bulkUpdatePriority,
    TResult? Function(TaskBulkUpdateCategory value)? bulkUpdateCategory,
    TResult? Function(TaskRefresh value)? refresh,
  }) {
    return sortChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskInitialized value)? initialized,
    TResult Function(TaskAdded value)? added,
    TResult Function(TaskUpdated value)? updated,
    TResult Function(TaskDeleted value)? deleted,
    TResult Function(TaskToggled value)? toggled,
    TResult Function(TaskSearched value)? searched,
    TResult Function(TaskFilterChanged value)? filterChanged,
    TResult Function(TaskSortChanged value)? sortChanged,
    TResult Function(TaskPriorityFilterChanged value)? priorityFilterChanged,
    TResult Function(TaskCategoryFilterChanged value)? categoryFilterChanged,
    TResult Function(TaskDueDateFilterChanged value)? dueDateFilterChanged,
    TResult Function(TaskBulkToggle value)? bulkToggle,
    TResult Function(TaskBulkDelete value)? bulkDelete,
    TResult Function(TaskBulkUpdatePriority value)? bulkUpdatePriority,
    TResult Function(TaskBulkUpdateCategory value)? bulkUpdateCategory,
    TResult Function(TaskRefresh value)? refresh,
    required TResult orElse(),
  }) {
    if (sortChanged != null) {
      return sortChanged(this);
    }
    return orElse();
  }
}

abstract class TaskSortChanged implements TaskEvent {
  const factory TaskSortChanged(final TaskSortOption sortOption) =
      _$TaskSortChangedImpl;

  TaskSortOption get sortOption;

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskSortChangedImplCopyWith<_$TaskSortChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TaskPriorityFilterChangedImplCopyWith<$Res> {
  factory _$$TaskPriorityFilterChangedImplCopyWith(
          _$TaskPriorityFilterChangedImpl value,
          $Res Function(_$TaskPriorityFilterChangedImpl) then) =
      __$$TaskPriorityFilterChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TaskPriority? priority});
}

/// @nodoc
class __$$TaskPriorityFilterChangedImplCopyWithImpl<$Res>
    extends _$TaskEventCopyWithImpl<$Res, _$TaskPriorityFilterChangedImpl>
    implements _$$TaskPriorityFilterChangedImplCopyWith<$Res> {
  __$$TaskPriorityFilterChangedImplCopyWithImpl(
      _$TaskPriorityFilterChangedImpl _value,
      $Res Function(_$TaskPriorityFilterChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? priority = freezed,
  }) {
    return _then(_$TaskPriorityFilterChangedImpl(
      freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as TaskPriority?,
    ));
  }
}

/// @nodoc

class _$TaskPriorityFilterChangedImpl implements TaskPriorityFilterChanged {
  const _$TaskPriorityFilterChangedImpl(this.priority);

  @override
  final TaskPriority? priority;

  @override
  String toString() {
    return 'TaskEvent.priorityFilterChanged(priority: $priority)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskPriorityFilterChangedImpl &&
            (identical(other.priority, priority) ||
                other.priority == priority));
  }

  @override
  int get hashCode => Object.hash(runtimeType, priority);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskPriorityFilterChangedImplCopyWith<_$TaskPriorityFilterChangedImpl>
      get copyWith => __$$TaskPriorityFilterChangedImplCopyWithImpl<
          _$TaskPriorityFilterChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialized,
    required TResult Function(String title, String description,
            TaskPriority priority, DateTime? dueDate, String category)
        added,
    required TResult Function(Task task) updated,
    required TResult Function(String taskId) deleted,
    required TResult Function(String taskId) toggled,
    required TResult Function(String query) searched,
    required TResult Function(TaskFilter filter) filterChanged,
    required TResult Function(TaskSortOption sortOption) sortChanged,
    required TResult Function(TaskPriority? priority) priorityFilterChanged,
    required TResult Function(String? category) categoryFilterChanged,
    required TResult Function(DateTime? dueDateFilter) dueDateFilterChanged,
    required TResult Function(List<String> taskIds, bool isCompleted)
        bulkToggle,
    required TResult Function(List<String> taskIds) bulkDelete,
    required TResult Function(List<String> taskIds, TaskPriority priority)
        bulkUpdatePriority,
    required TResult Function(List<String> taskIds, String category)
        bulkUpdateCategory,
    required TResult Function() refresh,
  }) {
    return priorityFilterChanged(priority);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialized,
    TResult? Function(String title, String description, TaskPriority priority,
            DateTime? dueDate, String category)?
        added,
    TResult? Function(Task task)? updated,
    TResult? Function(String taskId)? deleted,
    TResult? Function(String taskId)? toggled,
    TResult? Function(String query)? searched,
    TResult? Function(TaskFilter filter)? filterChanged,
    TResult? Function(TaskSortOption sortOption)? sortChanged,
    TResult? Function(TaskPriority? priority)? priorityFilterChanged,
    TResult? Function(String? category)? categoryFilterChanged,
    TResult? Function(DateTime? dueDateFilter)? dueDateFilterChanged,
    TResult? Function(List<String> taskIds, bool isCompleted)? bulkToggle,
    TResult? Function(List<String> taskIds)? bulkDelete,
    TResult? Function(List<String> taskIds, TaskPriority priority)?
        bulkUpdatePriority,
    TResult? Function(List<String> taskIds, String category)?
        bulkUpdateCategory,
    TResult? Function()? refresh,
  }) {
    return priorityFilterChanged?.call(priority);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function(String title, String description, TaskPriority priority,
            DateTime? dueDate, String category)?
        added,
    TResult Function(Task task)? updated,
    TResult Function(String taskId)? deleted,
    TResult Function(String taskId)? toggled,
    TResult Function(String query)? searched,
    TResult Function(TaskFilter filter)? filterChanged,
    TResult Function(TaskSortOption sortOption)? sortChanged,
    TResult Function(TaskPriority? priority)? priorityFilterChanged,
    TResult Function(String? category)? categoryFilterChanged,
    TResult Function(DateTime? dueDateFilter)? dueDateFilterChanged,
    TResult Function(List<String> taskIds, bool isCompleted)? bulkToggle,
    TResult Function(List<String> taskIds)? bulkDelete,
    TResult Function(List<String> taskIds, TaskPriority priority)?
        bulkUpdatePriority,
    TResult Function(List<String> taskIds, String category)? bulkUpdateCategory,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (priorityFilterChanged != null) {
      return priorityFilterChanged(priority);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskInitialized value) initialized,
    required TResult Function(TaskAdded value) added,
    required TResult Function(TaskUpdated value) updated,
    required TResult Function(TaskDeleted value) deleted,
    required TResult Function(TaskToggled value) toggled,
    required TResult Function(TaskSearched value) searched,
    required TResult Function(TaskFilterChanged value) filterChanged,
    required TResult Function(TaskSortChanged value) sortChanged,
    required TResult Function(TaskPriorityFilterChanged value)
        priorityFilterChanged,
    required TResult Function(TaskCategoryFilterChanged value)
        categoryFilterChanged,
    required TResult Function(TaskDueDateFilterChanged value)
        dueDateFilterChanged,
    required TResult Function(TaskBulkToggle value) bulkToggle,
    required TResult Function(TaskBulkDelete value) bulkDelete,
    required TResult Function(TaskBulkUpdatePriority value) bulkUpdatePriority,
    required TResult Function(TaskBulkUpdateCategory value) bulkUpdateCategory,
    required TResult Function(TaskRefresh value) refresh,
  }) {
    return priorityFilterChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaskInitialized value)? initialized,
    TResult? Function(TaskAdded value)? added,
    TResult? Function(TaskUpdated value)? updated,
    TResult? Function(TaskDeleted value)? deleted,
    TResult? Function(TaskToggled value)? toggled,
    TResult? Function(TaskSearched value)? searched,
    TResult? Function(TaskFilterChanged value)? filterChanged,
    TResult? Function(TaskSortChanged value)? sortChanged,
    TResult? Function(TaskPriorityFilterChanged value)? priorityFilterChanged,
    TResult? Function(TaskCategoryFilterChanged value)? categoryFilterChanged,
    TResult? Function(TaskDueDateFilterChanged value)? dueDateFilterChanged,
    TResult? Function(TaskBulkToggle value)? bulkToggle,
    TResult? Function(TaskBulkDelete value)? bulkDelete,
    TResult? Function(TaskBulkUpdatePriority value)? bulkUpdatePriority,
    TResult? Function(TaskBulkUpdateCategory value)? bulkUpdateCategory,
    TResult? Function(TaskRefresh value)? refresh,
  }) {
    return priorityFilterChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskInitialized value)? initialized,
    TResult Function(TaskAdded value)? added,
    TResult Function(TaskUpdated value)? updated,
    TResult Function(TaskDeleted value)? deleted,
    TResult Function(TaskToggled value)? toggled,
    TResult Function(TaskSearched value)? searched,
    TResult Function(TaskFilterChanged value)? filterChanged,
    TResult Function(TaskSortChanged value)? sortChanged,
    TResult Function(TaskPriorityFilterChanged value)? priorityFilterChanged,
    TResult Function(TaskCategoryFilterChanged value)? categoryFilterChanged,
    TResult Function(TaskDueDateFilterChanged value)? dueDateFilterChanged,
    TResult Function(TaskBulkToggle value)? bulkToggle,
    TResult Function(TaskBulkDelete value)? bulkDelete,
    TResult Function(TaskBulkUpdatePriority value)? bulkUpdatePriority,
    TResult Function(TaskBulkUpdateCategory value)? bulkUpdateCategory,
    TResult Function(TaskRefresh value)? refresh,
    required TResult orElse(),
  }) {
    if (priorityFilterChanged != null) {
      return priorityFilterChanged(this);
    }
    return orElse();
  }
}

abstract class TaskPriorityFilterChanged implements TaskEvent {
  const factory TaskPriorityFilterChanged(final TaskPriority? priority) =
      _$TaskPriorityFilterChangedImpl;

  TaskPriority? get priority;

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskPriorityFilterChangedImplCopyWith<_$TaskPriorityFilterChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TaskCategoryFilterChangedImplCopyWith<$Res> {
  factory _$$TaskCategoryFilterChangedImplCopyWith(
          _$TaskCategoryFilterChangedImpl value,
          $Res Function(_$TaskCategoryFilterChangedImpl) then) =
      __$$TaskCategoryFilterChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? category});
}

/// @nodoc
class __$$TaskCategoryFilterChangedImplCopyWithImpl<$Res>
    extends _$TaskEventCopyWithImpl<$Res, _$TaskCategoryFilterChangedImpl>
    implements _$$TaskCategoryFilterChangedImplCopyWith<$Res> {
  __$$TaskCategoryFilterChangedImplCopyWithImpl(
      _$TaskCategoryFilterChangedImpl _value,
      $Res Function(_$TaskCategoryFilterChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = freezed,
  }) {
    return _then(_$TaskCategoryFilterChangedImpl(
      freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$TaskCategoryFilterChangedImpl implements TaskCategoryFilterChanged {
  const _$TaskCategoryFilterChangedImpl(this.category);

  @override
  final String? category;

  @override
  String toString() {
    return 'TaskEvent.categoryFilterChanged(category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskCategoryFilterChangedImpl &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(runtimeType, category);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskCategoryFilterChangedImplCopyWith<_$TaskCategoryFilterChangedImpl>
      get copyWith => __$$TaskCategoryFilterChangedImplCopyWithImpl<
          _$TaskCategoryFilterChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialized,
    required TResult Function(String title, String description,
            TaskPriority priority, DateTime? dueDate, String category)
        added,
    required TResult Function(Task task) updated,
    required TResult Function(String taskId) deleted,
    required TResult Function(String taskId) toggled,
    required TResult Function(String query) searched,
    required TResult Function(TaskFilter filter) filterChanged,
    required TResult Function(TaskSortOption sortOption) sortChanged,
    required TResult Function(TaskPriority? priority) priorityFilterChanged,
    required TResult Function(String? category) categoryFilterChanged,
    required TResult Function(DateTime? dueDateFilter) dueDateFilterChanged,
    required TResult Function(List<String> taskIds, bool isCompleted)
        bulkToggle,
    required TResult Function(List<String> taskIds) bulkDelete,
    required TResult Function(List<String> taskIds, TaskPriority priority)
        bulkUpdatePriority,
    required TResult Function(List<String> taskIds, String category)
        bulkUpdateCategory,
    required TResult Function() refresh,
  }) {
    return categoryFilterChanged(category);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialized,
    TResult? Function(String title, String description, TaskPriority priority,
            DateTime? dueDate, String category)?
        added,
    TResult? Function(Task task)? updated,
    TResult? Function(String taskId)? deleted,
    TResult? Function(String taskId)? toggled,
    TResult? Function(String query)? searched,
    TResult? Function(TaskFilter filter)? filterChanged,
    TResult? Function(TaskSortOption sortOption)? sortChanged,
    TResult? Function(TaskPriority? priority)? priorityFilterChanged,
    TResult? Function(String? category)? categoryFilterChanged,
    TResult? Function(DateTime? dueDateFilter)? dueDateFilterChanged,
    TResult? Function(List<String> taskIds, bool isCompleted)? bulkToggle,
    TResult? Function(List<String> taskIds)? bulkDelete,
    TResult? Function(List<String> taskIds, TaskPriority priority)?
        bulkUpdatePriority,
    TResult? Function(List<String> taskIds, String category)?
        bulkUpdateCategory,
    TResult? Function()? refresh,
  }) {
    return categoryFilterChanged?.call(category);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function(String title, String description, TaskPriority priority,
            DateTime? dueDate, String category)?
        added,
    TResult Function(Task task)? updated,
    TResult Function(String taskId)? deleted,
    TResult Function(String taskId)? toggled,
    TResult Function(String query)? searched,
    TResult Function(TaskFilter filter)? filterChanged,
    TResult Function(TaskSortOption sortOption)? sortChanged,
    TResult Function(TaskPriority? priority)? priorityFilterChanged,
    TResult Function(String? category)? categoryFilterChanged,
    TResult Function(DateTime? dueDateFilter)? dueDateFilterChanged,
    TResult Function(List<String> taskIds, bool isCompleted)? bulkToggle,
    TResult Function(List<String> taskIds)? bulkDelete,
    TResult Function(List<String> taskIds, TaskPriority priority)?
        bulkUpdatePriority,
    TResult Function(List<String> taskIds, String category)? bulkUpdateCategory,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (categoryFilterChanged != null) {
      return categoryFilterChanged(category);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskInitialized value) initialized,
    required TResult Function(TaskAdded value) added,
    required TResult Function(TaskUpdated value) updated,
    required TResult Function(TaskDeleted value) deleted,
    required TResult Function(TaskToggled value) toggled,
    required TResult Function(TaskSearched value) searched,
    required TResult Function(TaskFilterChanged value) filterChanged,
    required TResult Function(TaskSortChanged value) sortChanged,
    required TResult Function(TaskPriorityFilterChanged value)
        priorityFilterChanged,
    required TResult Function(TaskCategoryFilterChanged value)
        categoryFilterChanged,
    required TResult Function(TaskDueDateFilterChanged value)
        dueDateFilterChanged,
    required TResult Function(TaskBulkToggle value) bulkToggle,
    required TResult Function(TaskBulkDelete value) bulkDelete,
    required TResult Function(TaskBulkUpdatePriority value) bulkUpdatePriority,
    required TResult Function(TaskBulkUpdateCategory value) bulkUpdateCategory,
    required TResult Function(TaskRefresh value) refresh,
  }) {
    return categoryFilterChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaskInitialized value)? initialized,
    TResult? Function(TaskAdded value)? added,
    TResult? Function(TaskUpdated value)? updated,
    TResult? Function(TaskDeleted value)? deleted,
    TResult? Function(TaskToggled value)? toggled,
    TResult? Function(TaskSearched value)? searched,
    TResult? Function(TaskFilterChanged value)? filterChanged,
    TResult? Function(TaskSortChanged value)? sortChanged,
    TResult? Function(TaskPriorityFilterChanged value)? priorityFilterChanged,
    TResult? Function(TaskCategoryFilterChanged value)? categoryFilterChanged,
    TResult? Function(TaskDueDateFilterChanged value)? dueDateFilterChanged,
    TResult? Function(TaskBulkToggle value)? bulkToggle,
    TResult? Function(TaskBulkDelete value)? bulkDelete,
    TResult? Function(TaskBulkUpdatePriority value)? bulkUpdatePriority,
    TResult? Function(TaskBulkUpdateCategory value)? bulkUpdateCategory,
    TResult? Function(TaskRefresh value)? refresh,
  }) {
    return categoryFilterChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskInitialized value)? initialized,
    TResult Function(TaskAdded value)? added,
    TResult Function(TaskUpdated value)? updated,
    TResult Function(TaskDeleted value)? deleted,
    TResult Function(TaskToggled value)? toggled,
    TResult Function(TaskSearched value)? searched,
    TResult Function(TaskFilterChanged value)? filterChanged,
    TResult Function(TaskSortChanged value)? sortChanged,
    TResult Function(TaskPriorityFilterChanged value)? priorityFilterChanged,
    TResult Function(TaskCategoryFilterChanged value)? categoryFilterChanged,
    TResult Function(TaskDueDateFilterChanged value)? dueDateFilterChanged,
    TResult Function(TaskBulkToggle value)? bulkToggle,
    TResult Function(TaskBulkDelete value)? bulkDelete,
    TResult Function(TaskBulkUpdatePriority value)? bulkUpdatePriority,
    TResult Function(TaskBulkUpdateCategory value)? bulkUpdateCategory,
    TResult Function(TaskRefresh value)? refresh,
    required TResult orElse(),
  }) {
    if (categoryFilterChanged != null) {
      return categoryFilterChanged(this);
    }
    return orElse();
  }
}

abstract class TaskCategoryFilterChanged implements TaskEvent {
  const factory TaskCategoryFilterChanged(final String? category) =
      _$TaskCategoryFilterChangedImpl;

  String? get category;

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskCategoryFilterChangedImplCopyWith<_$TaskCategoryFilterChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TaskDueDateFilterChangedImplCopyWith<$Res> {
  factory _$$TaskDueDateFilterChangedImplCopyWith(
          _$TaskDueDateFilterChangedImpl value,
          $Res Function(_$TaskDueDateFilterChangedImpl) then) =
      __$$TaskDueDateFilterChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime? dueDateFilter});
}

/// @nodoc
class __$$TaskDueDateFilterChangedImplCopyWithImpl<$Res>
    extends _$TaskEventCopyWithImpl<$Res, _$TaskDueDateFilterChangedImpl>
    implements _$$TaskDueDateFilterChangedImplCopyWith<$Res> {
  __$$TaskDueDateFilterChangedImplCopyWithImpl(
      _$TaskDueDateFilterChangedImpl _value,
      $Res Function(_$TaskDueDateFilterChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dueDateFilter = freezed,
  }) {
    return _then(_$TaskDueDateFilterChangedImpl(
      freezed == dueDateFilter
          ? _value.dueDateFilter
          : dueDateFilter // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$TaskDueDateFilterChangedImpl implements TaskDueDateFilterChanged {
  const _$TaskDueDateFilterChangedImpl(this.dueDateFilter);

  @override
  final DateTime? dueDateFilter;

  @override
  String toString() {
    return 'TaskEvent.dueDateFilterChanged(dueDateFilter: $dueDateFilter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskDueDateFilterChangedImpl &&
            (identical(other.dueDateFilter, dueDateFilter) ||
                other.dueDateFilter == dueDateFilter));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dueDateFilter);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskDueDateFilterChangedImplCopyWith<_$TaskDueDateFilterChangedImpl>
      get copyWith => __$$TaskDueDateFilterChangedImplCopyWithImpl<
          _$TaskDueDateFilterChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialized,
    required TResult Function(String title, String description,
            TaskPriority priority, DateTime? dueDate, String category)
        added,
    required TResult Function(Task task) updated,
    required TResult Function(String taskId) deleted,
    required TResult Function(String taskId) toggled,
    required TResult Function(String query) searched,
    required TResult Function(TaskFilter filter) filterChanged,
    required TResult Function(TaskSortOption sortOption) sortChanged,
    required TResult Function(TaskPriority? priority) priorityFilterChanged,
    required TResult Function(String? category) categoryFilterChanged,
    required TResult Function(DateTime? dueDateFilter) dueDateFilterChanged,
    required TResult Function(List<String> taskIds, bool isCompleted)
        bulkToggle,
    required TResult Function(List<String> taskIds) bulkDelete,
    required TResult Function(List<String> taskIds, TaskPriority priority)
        bulkUpdatePriority,
    required TResult Function(List<String> taskIds, String category)
        bulkUpdateCategory,
    required TResult Function() refresh,
  }) {
    return dueDateFilterChanged(dueDateFilter);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialized,
    TResult? Function(String title, String description, TaskPriority priority,
            DateTime? dueDate, String category)?
        added,
    TResult? Function(Task task)? updated,
    TResult? Function(String taskId)? deleted,
    TResult? Function(String taskId)? toggled,
    TResult? Function(String query)? searched,
    TResult? Function(TaskFilter filter)? filterChanged,
    TResult? Function(TaskSortOption sortOption)? sortChanged,
    TResult? Function(TaskPriority? priority)? priorityFilterChanged,
    TResult? Function(String? category)? categoryFilterChanged,
    TResult? Function(DateTime? dueDateFilter)? dueDateFilterChanged,
    TResult? Function(List<String> taskIds, bool isCompleted)? bulkToggle,
    TResult? Function(List<String> taskIds)? bulkDelete,
    TResult? Function(List<String> taskIds, TaskPriority priority)?
        bulkUpdatePriority,
    TResult? Function(List<String> taskIds, String category)?
        bulkUpdateCategory,
    TResult? Function()? refresh,
  }) {
    return dueDateFilterChanged?.call(dueDateFilter);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function(String title, String description, TaskPriority priority,
            DateTime? dueDate, String category)?
        added,
    TResult Function(Task task)? updated,
    TResult Function(String taskId)? deleted,
    TResult Function(String taskId)? toggled,
    TResult Function(String query)? searched,
    TResult Function(TaskFilter filter)? filterChanged,
    TResult Function(TaskSortOption sortOption)? sortChanged,
    TResult Function(TaskPriority? priority)? priorityFilterChanged,
    TResult Function(String? category)? categoryFilterChanged,
    TResult Function(DateTime? dueDateFilter)? dueDateFilterChanged,
    TResult Function(List<String> taskIds, bool isCompleted)? bulkToggle,
    TResult Function(List<String> taskIds)? bulkDelete,
    TResult Function(List<String> taskIds, TaskPriority priority)?
        bulkUpdatePriority,
    TResult Function(List<String> taskIds, String category)? bulkUpdateCategory,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (dueDateFilterChanged != null) {
      return dueDateFilterChanged(dueDateFilter);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskInitialized value) initialized,
    required TResult Function(TaskAdded value) added,
    required TResult Function(TaskUpdated value) updated,
    required TResult Function(TaskDeleted value) deleted,
    required TResult Function(TaskToggled value) toggled,
    required TResult Function(TaskSearched value) searched,
    required TResult Function(TaskFilterChanged value) filterChanged,
    required TResult Function(TaskSortChanged value) sortChanged,
    required TResult Function(TaskPriorityFilterChanged value)
        priorityFilterChanged,
    required TResult Function(TaskCategoryFilterChanged value)
        categoryFilterChanged,
    required TResult Function(TaskDueDateFilterChanged value)
        dueDateFilterChanged,
    required TResult Function(TaskBulkToggle value) bulkToggle,
    required TResult Function(TaskBulkDelete value) bulkDelete,
    required TResult Function(TaskBulkUpdatePriority value) bulkUpdatePriority,
    required TResult Function(TaskBulkUpdateCategory value) bulkUpdateCategory,
    required TResult Function(TaskRefresh value) refresh,
  }) {
    return dueDateFilterChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaskInitialized value)? initialized,
    TResult? Function(TaskAdded value)? added,
    TResult? Function(TaskUpdated value)? updated,
    TResult? Function(TaskDeleted value)? deleted,
    TResult? Function(TaskToggled value)? toggled,
    TResult? Function(TaskSearched value)? searched,
    TResult? Function(TaskFilterChanged value)? filterChanged,
    TResult? Function(TaskSortChanged value)? sortChanged,
    TResult? Function(TaskPriorityFilterChanged value)? priorityFilterChanged,
    TResult? Function(TaskCategoryFilterChanged value)? categoryFilterChanged,
    TResult? Function(TaskDueDateFilterChanged value)? dueDateFilterChanged,
    TResult? Function(TaskBulkToggle value)? bulkToggle,
    TResult? Function(TaskBulkDelete value)? bulkDelete,
    TResult? Function(TaskBulkUpdatePriority value)? bulkUpdatePriority,
    TResult? Function(TaskBulkUpdateCategory value)? bulkUpdateCategory,
    TResult? Function(TaskRefresh value)? refresh,
  }) {
    return dueDateFilterChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskInitialized value)? initialized,
    TResult Function(TaskAdded value)? added,
    TResult Function(TaskUpdated value)? updated,
    TResult Function(TaskDeleted value)? deleted,
    TResult Function(TaskToggled value)? toggled,
    TResult Function(TaskSearched value)? searched,
    TResult Function(TaskFilterChanged value)? filterChanged,
    TResult Function(TaskSortChanged value)? sortChanged,
    TResult Function(TaskPriorityFilterChanged value)? priorityFilterChanged,
    TResult Function(TaskCategoryFilterChanged value)? categoryFilterChanged,
    TResult Function(TaskDueDateFilterChanged value)? dueDateFilterChanged,
    TResult Function(TaskBulkToggle value)? bulkToggle,
    TResult Function(TaskBulkDelete value)? bulkDelete,
    TResult Function(TaskBulkUpdatePriority value)? bulkUpdatePriority,
    TResult Function(TaskBulkUpdateCategory value)? bulkUpdateCategory,
    TResult Function(TaskRefresh value)? refresh,
    required TResult orElse(),
  }) {
    if (dueDateFilterChanged != null) {
      return dueDateFilterChanged(this);
    }
    return orElse();
  }
}

abstract class TaskDueDateFilterChanged implements TaskEvent {
  const factory TaskDueDateFilterChanged(final DateTime? dueDateFilter) =
      _$TaskDueDateFilterChangedImpl;

  DateTime? get dueDateFilter;

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskDueDateFilterChangedImplCopyWith<_$TaskDueDateFilterChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TaskBulkToggleImplCopyWith<$Res> {
  factory _$$TaskBulkToggleImplCopyWith(_$TaskBulkToggleImpl value,
          $Res Function(_$TaskBulkToggleImpl) then) =
      __$$TaskBulkToggleImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<String> taskIds, bool isCompleted});
}

/// @nodoc
class __$$TaskBulkToggleImplCopyWithImpl<$Res>
    extends _$TaskEventCopyWithImpl<$Res, _$TaskBulkToggleImpl>
    implements _$$TaskBulkToggleImplCopyWith<$Res> {
  __$$TaskBulkToggleImplCopyWithImpl(
      _$TaskBulkToggleImpl _value, $Res Function(_$TaskBulkToggleImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskIds = null,
    Object? isCompleted = null,
  }) {
    return _then(_$TaskBulkToggleImpl(
      taskIds: null == taskIds
          ? _value._taskIds
          : taskIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$TaskBulkToggleImpl implements TaskBulkToggle {
  const _$TaskBulkToggleImpl(
      {required final List<String> taskIds, required this.isCompleted})
      : _taskIds = taskIds;

  final List<String> _taskIds;
  @override
  List<String> get taskIds {
    if (_taskIds is EqualUnmodifiableListView) return _taskIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_taskIds);
  }

  @override
  final bool isCompleted;

  @override
  String toString() {
    return 'TaskEvent.bulkToggle(taskIds: $taskIds, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskBulkToggleImpl &&
            const DeepCollectionEquality().equals(other._taskIds, _taskIds) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_taskIds), isCompleted);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskBulkToggleImplCopyWith<_$TaskBulkToggleImpl> get copyWith =>
      __$$TaskBulkToggleImplCopyWithImpl<_$TaskBulkToggleImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialized,
    required TResult Function(String title, String description,
            TaskPriority priority, DateTime? dueDate, String category)
        added,
    required TResult Function(Task task) updated,
    required TResult Function(String taskId) deleted,
    required TResult Function(String taskId) toggled,
    required TResult Function(String query) searched,
    required TResult Function(TaskFilter filter) filterChanged,
    required TResult Function(TaskSortOption sortOption) sortChanged,
    required TResult Function(TaskPriority? priority) priorityFilterChanged,
    required TResult Function(String? category) categoryFilterChanged,
    required TResult Function(DateTime? dueDateFilter) dueDateFilterChanged,
    required TResult Function(List<String> taskIds, bool isCompleted)
        bulkToggle,
    required TResult Function(List<String> taskIds) bulkDelete,
    required TResult Function(List<String> taskIds, TaskPriority priority)
        bulkUpdatePriority,
    required TResult Function(List<String> taskIds, String category)
        bulkUpdateCategory,
    required TResult Function() refresh,
  }) {
    return bulkToggle(taskIds, isCompleted);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialized,
    TResult? Function(String title, String description, TaskPriority priority,
            DateTime? dueDate, String category)?
        added,
    TResult? Function(Task task)? updated,
    TResult? Function(String taskId)? deleted,
    TResult? Function(String taskId)? toggled,
    TResult? Function(String query)? searched,
    TResult? Function(TaskFilter filter)? filterChanged,
    TResult? Function(TaskSortOption sortOption)? sortChanged,
    TResult? Function(TaskPriority? priority)? priorityFilterChanged,
    TResult? Function(String? category)? categoryFilterChanged,
    TResult? Function(DateTime? dueDateFilter)? dueDateFilterChanged,
    TResult? Function(List<String> taskIds, bool isCompleted)? bulkToggle,
    TResult? Function(List<String> taskIds)? bulkDelete,
    TResult? Function(List<String> taskIds, TaskPriority priority)?
        bulkUpdatePriority,
    TResult? Function(List<String> taskIds, String category)?
        bulkUpdateCategory,
    TResult? Function()? refresh,
  }) {
    return bulkToggle?.call(taskIds, isCompleted);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function(String title, String description, TaskPriority priority,
            DateTime? dueDate, String category)?
        added,
    TResult Function(Task task)? updated,
    TResult Function(String taskId)? deleted,
    TResult Function(String taskId)? toggled,
    TResult Function(String query)? searched,
    TResult Function(TaskFilter filter)? filterChanged,
    TResult Function(TaskSortOption sortOption)? sortChanged,
    TResult Function(TaskPriority? priority)? priorityFilterChanged,
    TResult Function(String? category)? categoryFilterChanged,
    TResult Function(DateTime? dueDateFilter)? dueDateFilterChanged,
    TResult Function(List<String> taskIds, bool isCompleted)? bulkToggle,
    TResult Function(List<String> taskIds)? bulkDelete,
    TResult Function(List<String> taskIds, TaskPriority priority)?
        bulkUpdatePriority,
    TResult Function(List<String> taskIds, String category)? bulkUpdateCategory,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (bulkToggle != null) {
      return bulkToggle(taskIds, isCompleted);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskInitialized value) initialized,
    required TResult Function(TaskAdded value) added,
    required TResult Function(TaskUpdated value) updated,
    required TResult Function(TaskDeleted value) deleted,
    required TResult Function(TaskToggled value) toggled,
    required TResult Function(TaskSearched value) searched,
    required TResult Function(TaskFilterChanged value) filterChanged,
    required TResult Function(TaskSortChanged value) sortChanged,
    required TResult Function(TaskPriorityFilterChanged value)
        priorityFilterChanged,
    required TResult Function(TaskCategoryFilterChanged value)
        categoryFilterChanged,
    required TResult Function(TaskDueDateFilterChanged value)
        dueDateFilterChanged,
    required TResult Function(TaskBulkToggle value) bulkToggle,
    required TResult Function(TaskBulkDelete value) bulkDelete,
    required TResult Function(TaskBulkUpdatePriority value) bulkUpdatePriority,
    required TResult Function(TaskBulkUpdateCategory value) bulkUpdateCategory,
    required TResult Function(TaskRefresh value) refresh,
  }) {
    return bulkToggle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaskInitialized value)? initialized,
    TResult? Function(TaskAdded value)? added,
    TResult? Function(TaskUpdated value)? updated,
    TResult? Function(TaskDeleted value)? deleted,
    TResult? Function(TaskToggled value)? toggled,
    TResult? Function(TaskSearched value)? searched,
    TResult? Function(TaskFilterChanged value)? filterChanged,
    TResult? Function(TaskSortChanged value)? sortChanged,
    TResult? Function(TaskPriorityFilterChanged value)? priorityFilterChanged,
    TResult? Function(TaskCategoryFilterChanged value)? categoryFilterChanged,
    TResult? Function(TaskDueDateFilterChanged value)? dueDateFilterChanged,
    TResult? Function(TaskBulkToggle value)? bulkToggle,
    TResult? Function(TaskBulkDelete value)? bulkDelete,
    TResult? Function(TaskBulkUpdatePriority value)? bulkUpdatePriority,
    TResult? Function(TaskBulkUpdateCategory value)? bulkUpdateCategory,
    TResult? Function(TaskRefresh value)? refresh,
  }) {
    return bulkToggle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskInitialized value)? initialized,
    TResult Function(TaskAdded value)? added,
    TResult Function(TaskUpdated value)? updated,
    TResult Function(TaskDeleted value)? deleted,
    TResult Function(TaskToggled value)? toggled,
    TResult Function(TaskSearched value)? searched,
    TResult Function(TaskFilterChanged value)? filterChanged,
    TResult Function(TaskSortChanged value)? sortChanged,
    TResult Function(TaskPriorityFilterChanged value)? priorityFilterChanged,
    TResult Function(TaskCategoryFilterChanged value)? categoryFilterChanged,
    TResult Function(TaskDueDateFilterChanged value)? dueDateFilterChanged,
    TResult Function(TaskBulkToggle value)? bulkToggle,
    TResult Function(TaskBulkDelete value)? bulkDelete,
    TResult Function(TaskBulkUpdatePriority value)? bulkUpdatePriority,
    TResult Function(TaskBulkUpdateCategory value)? bulkUpdateCategory,
    TResult Function(TaskRefresh value)? refresh,
    required TResult orElse(),
  }) {
    if (bulkToggle != null) {
      return bulkToggle(this);
    }
    return orElse();
  }
}

abstract class TaskBulkToggle implements TaskEvent {
  const factory TaskBulkToggle(
      {required final List<String> taskIds,
      required final bool isCompleted}) = _$TaskBulkToggleImpl;

  List<String> get taskIds;
  bool get isCompleted;

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskBulkToggleImplCopyWith<_$TaskBulkToggleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TaskBulkDeleteImplCopyWith<$Res> {
  factory _$$TaskBulkDeleteImplCopyWith(_$TaskBulkDeleteImpl value,
          $Res Function(_$TaskBulkDeleteImpl) then) =
      __$$TaskBulkDeleteImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<String> taskIds});
}

/// @nodoc
class __$$TaskBulkDeleteImplCopyWithImpl<$Res>
    extends _$TaskEventCopyWithImpl<$Res, _$TaskBulkDeleteImpl>
    implements _$$TaskBulkDeleteImplCopyWith<$Res> {
  __$$TaskBulkDeleteImplCopyWithImpl(
      _$TaskBulkDeleteImpl _value, $Res Function(_$TaskBulkDeleteImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskIds = null,
  }) {
    return _then(_$TaskBulkDeleteImpl(
      null == taskIds
          ? _value._taskIds
          : taskIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$TaskBulkDeleteImpl implements TaskBulkDelete {
  const _$TaskBulkDeleteImpl(final List<String> taskIds) : _taskIds = taskIds;

  final List<String> _taskIds;
  @override
  List<String> get taskIds {
    if (_taskIds is EqualUnmodifiableListView) return _taskIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_taskIds);
  }

  @override
  String toString() {
    return 'TaskEvent.bulkDelete(taskIds: $taskIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskBulkDeleteImpl &&
            const DeepCollectionEquality().equals(other._taskIds, _taskIds));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_taskIds));

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskBulkDeleteImplCopyWith<_$TaskBulkDeleteImpl> get copyWith =>
      __$$TaskBulkDeleteImplCopyWithImpl<_$TaskBulkDeleteImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialized,
    required TResult Function(String title, String description,
            TaskPriority priority, DateTime? dueDate, String category)
        added,
    required TResult Function(Task task) updated,
    required TResult Function(String taskId) deleted,
    required TResult Function(String taskId) toggled,
    required TResult Function(String query) searched,
    required TResult Function(TaskFilter filter) filterChanged,
    required TResult Function(TaskSortOption sortOption) sortChanged,
    required TResult Function(TaskPriority? priority) priorityFilterChanged,
    required TResult Function(String? category) categoryFilterChanged,
    required TResult Function(DateTime? dueDateFilter) dueDateFilterChanged,
    required TResult Function(List<String> taskIds, bool isCompleted)
        bulkToggle,
    required TResult Function(List<String> taskIds) bulkDelete,
    required TResult Function(List<String> taskIds, TaskPriority priority)
        bulkUpdatePriority,
    required TResult Function(List<String> taskIds, String category)
        bulkUpdateCategory,
    required TResult Function() refresh,
  }) {
    return bulkDelete(taskIds);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialized,
    TResult? Function(String title, String description, TaskPriority priority,
            DateTime? dueDate, String category)?
        added,
    TResult? Function(Task task)? updated,
    TResult? Function(String taskId)? deleted,
    TResult? Function(String taskId)? toggled,
    TResult? Function(String query)? searched,
    TResult? Function(TaskFilter filter)? filterChanged,
    TResult? Function(TaskSortOption sortOption)? sortChanged,
    TResult? Function(TaskPriority? priority)? priorityFilterChanged,
    TResult? Function(String? category)? categoryFilterChanged,
    TResult? Function(DateTime? dueDateFilter)? dueDateFilterChanged,
    TResult? Function(List<String> taskIds, bool isCompleted)? bulkToggle,
    TResult? Function(List<String> taskIds)? bulkDelete,
    TResult? Function(List<String> taskIds, TaskPriority priority)?
        bulkUpdatePriority,
    TResult? Function(List<String> taskIds, String category)?
        bulkUpdateCategory,
    TResult? Function()? refresh,
  }) {
    return bulkDelete?.call(taskIds);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function(String title, String description, TaskPriority priority,
            DateTime? dueDate, String category)?
        added,
    TResult Function(Task task)? updated,
    TResult Function(String taskId)? deleted,
    TResult Function(String taskId)? toggled,
    TResult Function(String query)? searched,
    TResult Function(TaskFilter filter)? filterChanged,
    TResult Function(TaskSortOption sortOption)? sortChanged,
    TResult Function(TaskPriority? priority)? priorityFilterChanged,
    TResult Function(String? category)? categoryFilterChanged,
    TResult Function(DateTime? dueDateFilter)? dueDateFilterChanged,
    TResult Function(List<String> taskIds, bool isCompleted)? bulkToggle,
    TResult Function(List<String> taskIds)? bulkDelete,
    TResult Function(List<String> taskIds, TaskPriority priority)?
        bulkUpdatePriority,
    TResult Function(List<String> taskIds, String category)? bulkUpdateCategory,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (bulkDelete != null) {
      return bulkDelete(taskIds);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskInitialized value) initialized,
    required TResult Function(TaskAdded value) added,
    required TResult Function(TaskUpdated value) updated,
    required TResult Function(TaskDeleted value) deleted,
    required TResult Function(TaskToggled value) toggled,
    required TResult Function(TaskSearched value) searched,
    required TResult Function(TaskFilterChanged value) filterChanged,
    required TResult Function(TaskSortChanged value) sortChanged,
    required TResult Function(TaskPriorityFilterChanged value)
        priorityFilterChanged,
    required TResult Function(TaskCategoryFilterChanged value)
        categoryFilterChanged,
    required TResult Function(TaskDueDateFilterChanged value)
        dueDateFilterChanged,
    required TResult Function(TaskBulkToggle value) bulkToggle,
    required TResult Function(TaskBulkDelete value) bulkDelete,
    required TResult Function(TaskBulkUpdatePriority value) bulkUpdatePriority,
    required TResult Function(TaskBulkUpdateCategory value) bulkUpdateCategory,
    required TResult Function(TaskRefresh value) refresh,
  }) {
    return bulkDelete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaskInitialized value)? initialized,
    TResult? Function(TaskAdded value)? added,
    TResult? Function(TaskUpdated value)? updated,
    TResult? Function(TaskDeleted value)? deleted,
    TResult? Function(TaskToggled value)? toggled,
    TResult? Function(TaskSearched value)? searched,
    TResult? Function(TaskFilterChanged value)? filterChanged,
    TResult? Function(TaskSortChanged value)? sortChanged,
    TResult? Function(TaskPriorityFilterChanged value)? priorityFilterChanged,
    TResult? Function(TaskCategoryFilterChanged value)? categoryFilterChanged,
    TResult? Function(TaskDueDateFilterChanged value)? dueDateFilterChanged,
    TResult? Function(TaskBulkToggle value)? bulkToggle,
    TResult? Function(TaskBulkDelete value)? bulkDelete,
    TResult? Function(TaskBulkUpdatePriority value)? bulkUpdatePriority,
    TResult? Function(TaskBulkUpdateCategory value)? bulkUpdateCategory,
    TResult? Function(TaskRefresh value)? refresh,
  }) {
    return bulkDelete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskInitialized value)? initialized,
    TResult Function(TaskAdded value)? added,
    TResult Function(TaskUpdated value)? updated,
    TResult Function(TaskDeleted value)? deleted,
    TResult Function(TaskToggled value)? toggled,
    TResult Function(TaskSearched value)? searched,
    TResult Function(TaskFilterChanged value)? filterChanged,
    TResult Function(TaskSortChanged value)? sortChanged,
    TResult Function(TaskPriorityFilterChanged value)? priorityFilterChanged,
    TResult Function(TaskCategoryFilterChanged value)? categoryFilterChanged,
    TResult Function(TaskDueDateFilterChanged value)? dueDateFilterChanged,
    TResult Function(TaskBulkToggle value)? bulkToggle,
    TResult Function(TaskBulkDelete value)? bulkDelete,
    TResult Function(TaskBulkUpdatePriority value)? bulkUpdatePriority,
    TResult Function(TaskBulkUpdateCategory value)? bulkUpdateCategory,
    TResult Function(TaskRefresh value)? refresh,
    required TResult orElse(),
  }) {
    if (bulkDelete != null) {
      return bulkDelete(this);
    }
    return orElse();
  }
}

abstract class TaskBulkDelete implements TaskEvent {
  const factory TaskBulkDelete(final List<String> taskIds) =
      _$TaskBulkDeleteImpl;

  List<String> get taskIds;

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskBulkDeleteImplCopyWith<_$TaskBulkDeleteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TaskBulkUpdatePriorityImplCopyWith<$Res> {
  factory _$$TaskBulkUpdatePriorityImplCopyWith(
          _$TaskBulkUpdatePriorityImpl value,
          $Res Function(_$TaskBulkUpdatePriorityImpl) then) =
      __$$TaskBulkUpdatePriorityImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<String> taskIds, TaskPriority priority});
}

/// @nodoc
class __$$TaskBulkUpdatePriorityImplCopyWithImpl<$Res>
    extends _$TaskEventCopyWithImpl<$Res, _$TaskBulkUpdatePriorityImpl>
    implements _$$TaskBulkUpdatePriorityImplCopyWith<$Res> {
  __$$TaskBulkUpdatePriorityImplCopyWithImpl(
      _$TaskBulkUpdatePriorityImpl _value,
      $Res Function(_$TaskBulkUpdatePriorityImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskIds = null,
    Object? priority = null,
  }) {
    return _then(_$TaskBulkUpdatePriorityImpl(
      taskIds: null == taskIds
          ? _value._taskIds
          : taskIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as TaskPriority,
    ));
  }
}

/// @nodoc

class _$TaskBulkUpdatePriorityImpl implements TaskBulkUpdatePriority {
  const _$TaskBulkUpdatePriorityImpl(
      {required final List<String> taskIds, required this.priority})
      : _taskIds = taskIds;

  final List<String> _taskIds;
  @override
  List<String> get taskIds {
    if (_taskIds is EqualUnmodifiableListView) return _taskIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_taskIds);
  }

  @override
  final TaskPriority priority;

  @override
  String toString() {
    return 'TaskEvent.bulkUpdatePriority(taskIds: $taskIds, priority: $priority)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskBulkUpdatePriorityImpl &&
            const DeepCollectionEquality().equals(other._taskIds, _taskIds) &&
            (identical(other.priority, priority) ||
                other.priority == priority));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_taskIds), priority);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskBulkUpdatePriorityImplCopyWith<_$TaskBulkUpdatePriorityImpl>
      get copyWith => __$$TaskBulkUpdatePriorityImplCopyWithImpl<
          _$TaskBulkUpdatePriorityImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialized,
    required TResult Function(String title, String description,
            TaskPriority priority, DateTime? dueDate, String category)
        added,
    required TResult Function(Task task) updated,
    required TResult Function(String taskId) deleted,
    required TResult Function(String taskId) toggled,
    required TResult Function(String query) searched,
    required TResult Function(TaskFilter filter) filterChanged,
    required TResult Function(TaskSortOption sortOption) sortChanged,
    required TResult Function(TaskPriority? priority) priorityFilterChanged,
    required TResult Function(String? category) categoryFilterChanged,
    required TResult Function(DateTime? dueDateFilter) dueDateFilterChanged,
    required TResult Function(List<String> taskIds, bool isCompleted)
        bulkToggle,
    required TResult Function(List<String> taskIds) bulkDelete,
    required TResult Function(List<String> taskIds, TaskPriority priority)
        bulkUpdatePriority,
    required TResult Function(List<String> taskIds, String category)
        bulkUpdateCategory,
    required TResult Function() refresh,
  }) {
    return bulkUpdatePriority(taskIds, priority);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialized,
    TResult? Function(String title, String description, TaskPriority priority,
            DateTime? dueDate, String category)?
        added,
    TResult? Function(Task task)? updated,
    TResult? Function(String taskId)? deleted,
    TResult? Function(String taskId)? toggled,
    TResult? Function(String query)? searched,
    TResult? Function(TaskFilter filter)? filterChanged,
    TResult? Function(TaskSortOption sortOption)? sortChanged,
    TResult? Function(TaskPriority? priority)? priorityFilterChanged,
    TResult? Function(String? category)? categoryFilterChanged,
    TResult? Function(DateTime? dueDateFilter)? dueDateFilterChanged,
    TResult? Function(List<String> taskIds, bool isCompleted)? bulkToggle,
    TResult? Function(List<String> taskIds)? bulkDelete,
    TResult? Function(List<String> taskIds, TaskPriority priority)?
        bulkUpdatePriority,
    TResult? Function(List<String> taskIds, String category)?
        bulkUpdateCategory,
    TResult? Function()? refresh,
  }) {
    return bulkUpdatePriority?.call(taskIds, priority);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function(String title, String description, TaskPriority priority,
            DateTime? dueDate, String category)?
        added,
    TResult Function(Task task)? updated,
    TResult Function(String taskId)? deleted,
    TResult Function(String taskId)? toggled,
    TResult Function(String query)? searched,
    TResult Function(TaskFilter filter)? filterChanged,
    TResult Function(TaskSortOption sortOption)? sortChanged,
    TResult Function(TaskPriority? priority)? priorityFilterChanged,
    TResult Function(String? category)? categoryFilterChanged,
    TResult Function(DateTime? dueDateFilter)? dueDateFilterChanged,
    TResult Function(List<String> taskIds, bool isCompleted)? bulkToggle,
    TResult Function(List<String> taskIds)? bulkDelete,
    TResult Function(List<String> taskIds, TaskPriority priority)?
        bulkUpdatePriority,
    TResult Function(List<String> taskIds, String category)? bulkUpdateCategory,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (bulkUpdatePriority != null) {
      return bulkUpdatePriority(taskIds, priority);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskInitialized value) initialized,
    required TResult Function(TaskAdded value) added,
    required TResult Function(TaskUpdated value) updated,
    required TResult Function(TaskDeleted value) deleted,
    required TResult Function(TaskToggled value) toggled,
    required TResult Function(TaskSearched value) searched,
    required TResult Function(TaskFilterChanged value) filterChanged,
    required TResult Function(TaskSortChanged value) sortChanged,
    required TResult Function(TaskPriorityFilterChanged value)
        priorityFilterChanged,
    required TResult Function(TaskCategoryFilterChanged value)
        categoryFilterChanged,
    required TResult Function(TaskDueDateFilterChanged value)
        dueDateFilterChanged,
    required TResult Function(TaskBulkToggle value) bulkToggle,
    required TResult Function(TaskBulkDelete value) bulkDelete,
    required TResult Function(TaskBulkUpdatePriority value) bulkUpdatePriority,
    required TResult Function(TaskBulkUpdateCategory value) bulkUpdateCategory,
    required TResult Function(TaskRefresh value) refresh,
  }) {
    return bulkUpdatePriority(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaskInitialized value)? initialized,
    TResult? Function(TaskAdded value)? added,
    TResult? Function(TaskUpdated value)? updated,
    TResult? Function(TaskDeleted value)? deleted,
    TResult? Function(TaskToggled value)? toggled,
    TResult? Function(TaskSearched value)? searched,
    TResult? Function(TaskFilterChanged value)? filterChanged,
    TResult? Function(TaskSortChanged value)? sortChanged,
    TResult? Function(TaskPriorityFilterChanged value)? priorityFilterChanged,
    TResult? Function(TaskCategoryFilterChanged value)? categoryFilterChanged,
    TResult? Function(TaskDueDateFilterChanged value)? dueDateFilterChanged,
    TResult? Function(TaskBulkToggle value)? bulkToggle,
    TResult? Function(TaskBulkDelete value)? bulkDelete,
    TResult? Function(TaskBulkUpdatePriority value)? bulkUpdatePriority,
    TResult? Function(TaskBulkUpdateCategory value)? bulkUpdateCategory,
    TResult? Function(TaskRefresh value)? refresh,
  }) {
    return bulkUpdatePriority?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskInitialized value)? initialized,
    TResult Function(TaskAdded value)? added,
    TResult Function(TaskUpdated value)? updated,
    TResult Function(TaskDeleted value)? deleted,
    TResult Function(TaskToggled value)? toggled,
    TResult Function(TaskSearched value)? searched,
    TResult Function(TaskFilterChanged value)? filterChanged,
    TResult Function(TaskSortChanged value)? sortChanged,
    TResult Function(TaskPriorityFilterChanged value)? priorityFilterChanged,
    TResult Function(TaskCategoryFilterChanged value)? categoryFilterChanged,
    TResult Function(TaskDueDateFilterChanged value)? dueDateFilterChanged,
    TResult Function(TaskBulkToggle value)? bulkToggle,
    TResult Function(TaskBulkDelete value)? bulkDelete,
    TResult Function(TaskBulkUpdatePriority value)? bulkUpdatePriority,
    TResult Function(TaskBulkUpdateCategory value)? bulkUpdateCategory,
    TResult Function(TaskRefresh value)? refresh,
    required TResult orElse(),
  }) {
    if (bulkUpdatePriority != null) {
      return bulkUpdatePriority(this);
    }
    return orElse();
  }
}

abstract class TaskBulkUpdatePriority implements TaskEvent {
  const factory TaskBulkUpdatePriority(
      {required final List<String> taskIds,
      required final TaskPriority priority}) = _$TaskBulkUpdatePriorityImpl;

  List<String> get taskIds;
  TaskPriority get priority;

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskBulkUpdatePriorityImplCopyWith<_$TaskBulkUpdatePriorityImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TaskBulkUpdateCategoryImplCopyWith<$Res> {
  factory _$$TaskBulkUpdateCategoryImplCopyWith(
          _$TaskBulkUpdateCategoryImpl value,
          $Res Function(_$TaskBulkUpdateCategoryImpl) then) =
      __$$TaskBulkUpdateCategoryImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<String> taskIds, String category});
}

/// @nodoc
class __$$TaskBulkUpdateCategoryImplCopyWithImpl<$Res>
    extends _$TaskEventCopyWithImpl<$Res, _$TaskBulkUpdateCategoryImpl>
    implements _$$TaskBulkUpdateCategoryImplCopyWith<$Res> {
  __$$TaskBulkUpdateCategoryImplCopyWithImpl(
      _$TaskBulkUpdateCategoryImpl _value,
      $Res Function(_$TaskBulkUpdateCategoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskIds = null,
    Object? category = null,
  }) {
    return _then(_$TaskBulkUpdateCategoryImpl(
      taskIds: null == taskIds
          ? _value._taskIds
          : taskIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TaskBulkUpdateCategoryImpl implements TaskBulkUpdateCategory {
  const _$TaskBulkUpdateCategoryImpl(
      {required final List<String> taskIds, required this.category})
      : _taskIds = taskIds;

  final List<String> _taskIds;
  @override
  List<String> get taskIds {
    if (_taskIds is EqualUnmodifiableListView) return _taskIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_taskIds);
  }

  @override
  final String category;

  @override
  String toString() {
    return 'TaskEvent.bulkUpdateCategory(taskIds: $taskIds, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskBulkUpdateCategoryImpl &&
            const DeepCollectionEquality().equals(other._taskIds, _taskIds) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_taskIds), category);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskBulkUpdateCategoryImplCopyWith<_$TaskBulkUpdateCategoryImpl>
      get copyWith => __$$TaskBulkUpdateCategoryImplCopyWithImpl<
          _$TaskBulkUpdateCategoryImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialized,
    required TResult Function(String title, String description,
            TaskPriority priority, DateTime? dueDate, String category)
        added,
    required TResult Function(Task task) updated,
    required TResult Function(String taskId) deleted,
    required TResult Function(String taskId) toggled,
    required TResult Function(String query) searched,
    required TResult Function(TaskFilter filter) filterChanged,
    required TResult Function(TaskSortOption sortOption) sortChanged,
    required TResult Function(TaskPriority? priority) priorityFilterChanged,
    required TResult Function(String? category) categoryFilterChanged,
    required TResult Function(DateTime? dueDateFilter) dueDateFilterChanged,
    required TResult Function(List<String> taskIds, bool isCompleted)
        bulkToggle,
    required TResult Function(List<String> taskIds) bulkDelete,
    required TResult Function(List<String> taskIds, TaskPriority priority)
        bulkUpdatePriority,
    required TResult Function(List<String> taskIds, String category)
        bulkUpdateCategory,
    required TResult Function() refresh,
  }) {
    return bulkUpdateCategory(taskIds, category);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialized,
    TResult? Function(String title, String description, TaskPriority priority,
            DateTime? dueDate, String category)?
        added,
    TResult? Function(Task task)? updated,
    TResult? Function(String taskId)? deleted,
    TResult? Function(String taskId)? toggled,
    TResult? Function(String query)? searched,
    TResult? Function(TaskFilter filter)? filterChanged,
    TResult? Function(TaskSortOption sortOption)? sortChanged,
    TResult? Function(TaskPriority? priority)? priorityFilterChanged,
    TResult? Function(String? category)? categoryFilterChanged,
    TResult? Function(DateTime? dueDateFilter)? dueDateFilterChanged,
    TResult? Function(List<String> taskIds, bool isCompleted)? bulkToggle,
    TResult? Function(List<String> taskIds)? bulkDelete,
    TResult? Function(List<String> taskIds, TaskPriority priority)?
        bulkUpdatePriority,
    TResult? Function(List<String> taskIds, String category)?
        bulkUpdateCategory,
    TResult? Function()? refresh,
  }) {
    return bulkUpdateCategory?.call(taskIds, category);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function(String title, String description, TaskPriority priority,
            DateTime? dueDate, String category)?
        added,
    TResult Function(Task task)? updated,
    TResult Function(String taskId)? deleted,
    TResult Function(String taskId)? toggled,
    TResult Function(String query)? searched,
    TResult Function(TaskFilter filter)? filterChanged,
    TResult Function(TaskSortOption sortOption)? sortChanged,
    TResult Function(TaskPriority? priority)? priorityFilterChanged,
    TResult Function(String? category)? categoryFilterChanged,
    TResult Function(DateTime? dueDateFilter)? dueDateFilterChanged,
    TResult Function(List<String> taskIds, bool isCompleted)? bulkToggle,
    TResult Function(List<String> taskIds)? bulkDelete,
    TResult Function(List<String> taskIds, TaskPriority priority)?
        bulkUpdatePriority,
    TResult Function(List<String> taskIds, String category)? bulkUpdateCategory,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (bulkUpdateCategory != null) {
      return bulkUpdateCategory(taskIds, category);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskInitialized value) initialized,
    required TResult Function(TaskAdded value) added,
    required TResult Function(TaskUpdated value) updated,
    required TResult Function(TaskDeleted value) deleted,
    required TResult Function(TaskToggled value) toggled,
    required TResult Function(TaskSearched value) searched,
    required TResult Function(TaskFilterChanged value) filterChanged,
    required TResult Function(TaskSortChanged value) sortChanged,
    required TResult Function(TaskPriorityFilterChanged value)
        priorityFilterChanged,
    required TResult Function(TaskCategoryFilterChanged value)
        categoryFilterChanged,
    required TResult Function(TaskDueDateFilterChanged value)
        dueDateFilterChanged,
    required TResult Function(TaskBulkToggle value) bulkToggle,
    required TResult Function(TaskBulkDelete value) bulkDelete,
    required TResult Function(TaskBulkUpdatePriority value) bulkUpdatePriority,
    required TResult Function(TaskBulkUpdateCategory value) bulkUpdateCategory,
    required TResult Function(TaskRefresh value) refresh,
  }) {
    return bulkUpdateCategory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaskInitialized value)? initialized,
    TResult? Function(TaskAdded value)? added,
    TResult? Function(TaskUpdated value)? updated,
    TResult? Function(TaskDeleted value)? deleted,
    TResult? Function(TaskToggled value)? toggled,
    TResult? Function(TaskSearched value)? searched,
    TResult? Function(TaskFilterChanged value)? filterChanged,
    TResult? Function(TaskSortChanged value)? sortChanged,
    TResult? Function(TaskPriorityFilterChanged value)? priorityFilterChanged,
    TResult? Function(TaskCategoryFilterChanged value)? categoryFilterChanged,
    TResult? Function(TaskDueDateFilterChanged value)? dueDateFilterChanged,
    TResult? Function(TaskBulkToggle value)? bulkToggle,
    TResult? Function(TaskBulkDelete value)? bulkDelete,
    TResult? Function(TaskBulkUpdatePriority value)? bulkUpdatePriority,
    TResult? Function(TaskBulkUpdateCategory value)? bulkUpdateCategory,
    TResult? Function(TaskRefresh value)? refresh,
  }) {
    return bulkUpdateCategory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskInitialized value)? initialized,
    TResult Function(TaskAdded value)? added,
    TResult Function(TaskUpdated value)? updated,
    TResult Function(TaskDeleted value)? deleted,
    TResult Function(TaskToggled value)? toggled,
    TResult Function(TaskSearched value)? searched,
    TResult Function(TaskFilterChanged value)? filterChanged,
    TResult Function(TaskSortChanged value)? sortChanged,
    TResult Function(TaskPriorityFilterChanged value)? priorityFilterChanged,
    TResult Function(TaskCategoryFilterChanged value)? categoryFilterChanged,
    TResult Function(TaskDueDateFilterChanged value)? dueDateFilterChanged,
    TResult Function(TaskBulkToggle value)? bulkToggle,
    TResult Function(TaskBulkDelete value)? bulkDelete,
    TResult Function(TaskBulkUpdatePriority value)? bulkUpdatePriority,
    TResult Function(TaskBulkUpdateCategory value)? bulkUpdateCategory,
    TResult Function(TaskRefresh value)? refresh,
    required TResult orElse(),
  }) {
    if (bulkUpdateCategory != null) {
      return bulkUpdateCategory(this);
    }
    return orElse();
  }
}

abstract class TaskBulkUpdateCategory implements TaskEvent {
  const factory TaskBulkUpdateCategory(
      {required final List<String> taskIds,
      required final String category}) = _$TaskBulkUpdateCategoryImpl;

  List<String> get taskIds;
  String get category;

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskBulkUpdateCategoryImplCopyWith<_$TaskBulkUpdateCategoryImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TaskRefreshImplCopyWith<$Res> {
  factory _$$TaskRefreshImplCopyWith(
          _$TaskRefreshImpl value, $Res Function(_$TaskRefreshImpl) then) =
      __$$TaskRefreshImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TaskRefreshImplCopyWithImpl<$Res>
    extends _$TaskEventCopyWithImpl<$Res, _$TaskRefreshImpl>
    implements _$$TaskRefreshImplCopyWith<$Res> {
  __$$TaskRefreshImplCopyWithImpl(
      _$TaskRefreshImpl _value, $Res Function(_$TaskRefreshImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TaskRefreshImpl implements TaskRefresh {
  const _$TaskRefreshImpl();

  @override
  String toString() {
    return 'TaskEvent.refresh()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TaskRefreshImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialized,
    required TResult Function(String title, String description,
            TaskPriority priority, DateTime? dueDate, String category)
        added,
    required TResult Function(Task task) updated,
    required TResult Function(String taskId) deleted,
    required TResult Function(String taskId) toggled,
    required TResult Function(String query) searched,
    required TResult Function(TaskFilter filter) filterChanged,
    required TResult Function(TaskSortOption sortOption) sortChanged,
    required TResult Function(TaskPriority? priority) priorityFilterChanged,
    required TResult Function(String? category) categoryFilterChanged,
    required TResult Function(DateTime? dueDateFilter) dueDateFilterChanged,
    required TResult Function(List<String> taskIds, bool isCompleted)
        bulkToggle,
    required TResult Function(List<String> taskIds) bulkDelete,
    required TResult Function(List<String> taskIds, TaskPriority priority)
        bulkUpdatePriority,
    required TResult Function(List<String> taskIds, String category)
        bulkUpdateCategory,
    required TResult Function() refresh,
  }) {
    return refresh();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialized,
    TResult? Function(String title, String description, TaskPriority priority,
            DateTime? dueDate, String category)?
        added,
    TResult? Function(Task task)? updated,
    TResult? Function(String taskId)? deleted,
    TResult? Function(String taskId)? toggled,
    TResult? Function(String query)? searched,
    TResult? Function(TaskFilter filter)? filterChanged,
    TResult? Function(TaskSortOption sortOption)? sortChanged,
    TResult? Function(TaskPriority? priority)? priorityFilterChanged,
    TResult? Function(String? category)? categoryFilterChanged,
    TResult? Function(DateTime? dueDateFilter)? dueDateFilterChanged,
    TResult? Function(List<String> taskIds, bool isCompleted)? bulkToggle,
    TResult? Function(List<String> taskIds)? bulkDelete,
    TResult? Function(List<String> taskIds, TaskPriority priority)?
        bulkUpdatePriority,
    TResult? Function(List<String> taskIds, String category)?
        bulkUpdateCategory,
    TResult? Function()? refresh,
  }) {
    return refresh?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function(String title, String description, TaskPriority priority,
            DateTime? dueDate, String category)?
        added,
    TResult Function(Task task)? updated,
    TResult Function(String taskId)? deleted,
    TResult Function(String taskId)? toggled,
    TResult Function(String query)? searched,
    TResult Function(TaskFilter filter)? filterChanged,
    TResult Function(TaskSortOption sortOption)? sortChanged,
    TResult Function(TaskPriority? priority)? priorityFilterChanged,
    TResult Function(String? category)? categoryFilterChanged,
    TResult Function(DateTime? dueDateFilter)? dueDateFilterChanged,
    TResult Function(List<String> taskIds, bool isCompleted)? bulkToggle,
    TResult Function(List<String> taskIds)? bulkDelete,
    TResult Function(List<String> taskIds, TaskPriority priority)?
        bulkUpdatePriority,
    TResult Function(List<String> taskIds, String category)? bulkUpdateCategory,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskInitialized value) initialized,
    required TResult Function(TaskAdded value) added,
    required TResult Function(TaskUpdated value) updated,
    required TResult Function(TaskDeleted value) deleted,
    required TResult Function(TaskToggled value) toggled,
    required TResult Function(TaskSearched value) searched,
    required TResult Function(TaskFilterChanged value) filterChanged,
    required TResult Function(TaskSortChanged value) sortChanged,
    required TResult Function(TaskPriorityFilterChanged value)
        priorityFilterChanged,
    required TResult Function(TaskCategoryFilterChanged value)
        categoryFilterChanged,
    required TResult Function(TaskDueDateFilterChanged value)
        dueDateFilterChanged,
    required TResult Function(TaskBulkToggle value) bulkToggle,
    required TResult Function(TaskBulkDelete value) bulkDelete,
    required TResult Function(TaskBulkUpdatePriority value) bulkUpdatePriority,
    required TResult Function(TaskBulkUpdateCategory value) bulkUpdateCategory,
    required TResult Function(TaskRefresh value) refresh,
  }) {
    return refresh(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaskInitialized value)? initialized,
    TResult? Function(TaskAdded value)? added,
    TResult? Function(TaskUpdated value)? updated,
    TResult? Function(TaskDeleted value)? deleted,
    TResult? Function(TaskToggled value)? toggled,
    TResult? Function(TaskSearched value)? searched,
    TResult? Function(TaskFilterChanged value)? filterChanged,
    TResult? Function(TaskSortChanged value)? sortChanged,
    TResult? Function(TaskPriorityFilterChanged value)? priorityFilterChanged,
    TResult? Function(TaskCategoryFilterChanged value)? categoryFilterChanged,
    TResult? Function(TaskDueDateFilterChanged value)? dueDateFilterChanged,
    TResult? Function(TaskBulkToggle value)? bulkToggle,
    TResult? Function(TaskBulkDelete value)? bulkDelete,
    TResult? Function(TaskBulkUpdatePriority value)? bulkUpdatePriority,
    TResult? Function(TaskBulkUpdateCategory value)? bulkUpdateCategory,
    TResult? Function(TaskRefresh value)? refresh,
  }) {
    return refresh?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskInitialized value)? initialized,
    TResult Function(TaskAdded value)? added,
    TResult Function(TaskUpdated value)? updated,
    TResult Function(TaskDeleted value)? deleted,
    TResult Function(TaskToggled value)? toggled,
    TResult Function(TaskSearched value)? searched,
    TResult Function(TaskFilterChanged value)? filterChanged,
    TResult Function(TaskSortChanged value)? sortChanged,
    TResult Function(TaskPriorityFilterChanged value)? priorityFilterChanged,
    TResult Function(TaskCategoryFilterChanged value)? categoryFilterChanged,
    TResult Function(TaskDueDateFilterChanged value)? dueDateFilterChanged,
    TResult Function(TaskBulkToggle value)? bulkToggle,
    TResult Function(TaskBulkDelete value)? bulkDelete,
    TResult Function(TaskBulkUpdatePriority value)? bulkUpdatePriority,
    TResult Function(TaskBulkUpdateCategory value)? bulkUpdateCategory,
    TResult Function(TaskRefresh value)? refresh,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh(this);
    }
    return orElse();
  }
}

abstract class TaskRefresh implements TaskEvent {
  const factory TaskRefresh() = _$TaskRefreshImpl;
}

/// @nodoc
mixin _$TaskState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<Task> tasks,
            List<Task> filteredTasks,
            TaskFilter currentFilter,
            TaskSortOption currentSort,
            TaskPriority? selectedPriority,
            String? selectedCategory,
            DateTime? selectedDueDateFilter,
            String searchQuery,
            List<String> categories,
            Map<String, int> statistics)
        loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<Task> tasks,
            List<Task> filteredTasks,
            TaskFilter currentFilter,
            TaskSortOption currentSort,
            TaskPriority? selectedPriority,
            String? selectedCategory,
            DateTime? selectedDueDateFilter,
            String searchQuery,
            List<String> categories,
            Map<String, int> statistics)?
        loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<Task> tasks,
            List<Task> filteredTasks,
            TaskFilter currentFilter,
            TaskSortOption currentSort,
            TaskPriority? selectedPriority,
            String? selectedCategory,
            DateTime? selectedDueDateFilter,
            String searchQuery,
            List<String> categories,
            Map<String, int> statistics)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskInitial value) initial,
    required TResult Function(TaskLoading value) loading,
    required TResult Function(TaskLoaded value) loaded,
    required TResult Function(TaskError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaskInitial value)? initial,
    TResult? Function(TaskLoading value)? loading,
    TResult? Function(TaskLoaded value)? loaded,
    TResult? Function(TaskError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskInitial value)? initial,
    TResult Function(TaskLoading value)? loading,
    TResult Function(TaskLoaded value)? loaded,
    TResult Function(TaskError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskStateCopyWith<$Res> {
  factory $TaskStateCopyWith(TaskState value, $Res Function(TaskState) then) =
      _$TaskStateCopyWithImpl<$Res, TaskState>;
}

/// @nodoc
class _$TaskStateCopyWithImpl<$Res, $Val extends TaskState>
    implements $TaskStateCopyWith<$Res> {
  _$TaskStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$TaskInitialImplCopyWith<$Res> {
  factory _$$TaskInitialImplCopyWith(
          _$TaskInitialImpl value, $Res Function(_$TaskInitialImpl) then) =
      __$$TaskInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TaskInitialImplCopyWithImpl<$Res>
    extends _$TaskStateCopyWithImpl<$Res, _$TaskInitialImpl>
    implements _$$TaskInitialImplCopyWith<$Res> {
  __$$TaskInitialImplCopyWithImpl(
      _$TaskInitialImpl _value, $Res Function(_$TaskInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TaskInitialImpl implements TaskInitial {
  const _$TaskInitialImpl();

  @override
  String toString() {
    return 'TaskState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TaskInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<Task> tasks,
            List<Task> filteredTasks,
            TaskFilter currentFilter,
            TaskSortOption currentSort,
            TaskPriority? selectedPriority,
            String? selectedCategory,
            DateTime? selectedDueDateFilter,
            String searchQuery,
            List<String> categories,
            Map<String, int> statistics)
        loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<Task> tasks,
            List<Task> filteredTasks,
            TaskFilter currentFilter,
            TaskSortOption currentSort,
            TaskPriority? selectedPriority,
            String? selectedCategory,
            DateTime? selectedDueDateFilter,
            String searchQuery,
            List<String> categories,
            Map<String, int> statistics)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<Task> tasks,
            List<Task> filteredTasks,
            TaskFilter currentFilter,
            TaskSortOption currentSort,
            TaskPriority? selectedPriority,
            String? selectedCategory,
            DateTime? selectedDueDateFilter,
            String searchQuery,
            List<String> categories,
            Map<String, int> statistics)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskInitial value) initial,
    required TResult Function(TaskLoading value) loading,
    required TResult Function(TaskLoaded value) loaded,
    required TResult Function(TaskError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaskInitial value)? initial,
    TResult? Function(TaskLoading value)? loading,
    TResult? Function(TaskLoaded value)? loaded,
    TResult? Function(TaskError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskInitial value)? initial,
    TResult Function(TaskLoading value)? loading,
    TResult Function(TaskLoaded value)? loaded,
    TResult Function(TaskError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class TaskInitial implements TaskState {
  const factory TaskInitial() = _$TaskInitialImpl;
}

/// @nodoc
abstract class _$$TaskLoadingImplCopyWith<$Res> {
  factory _$$TaskLoadingImplCopyWith(
          _$TaskLoadingImpl value, $Res Function(_$TaskLoadingImpl) then) =
      __$$TaskLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TaskLoadingImplCopyWithImpl<$Res>
    extends _$TaskStateCopyWithImpl<$Res, _$TaskLoadingImpl>
    implements _$$TaskLoadingImplCopyWith<$Res> {
  __$$TaskLoadingImplCopyWithImpl(
      _$TaskLoadingImpl _value, $Res Function(_$TaskLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TaskLoadingImpl implements TaskLoading {
  const _$TaskLoadingImpl();

  @override
  String toString() {
    return 'TaskState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TaskLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<Task> tasks,
            List<Task> filteredTasks,
            TaskFilter currentFilter,
            TaskSortOption currentSort,
            TaskPriority? selectedPriority,
            String? selectedCategory,
            DateTime? selectedDueDateFilter,
            String searchQuery,
            List<String> categories,
            Map<String, int> statistics)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<Task> tasks,
            List<Task> filteredTasks,
            TaskFilter currentFilter,
            TaskSortOption currentSort,
            TaskPriority? selectedPriority,
            String? selectedCategory,
            DateTime? selectedDueDateFilter,
            String searchQuery,
            List<String> categories,
            Map<String, int> statistics)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<Task> tasks,
            List<Task> filteredTasks,
            TaskFilter currentFilter,
            TaskSortOption currentSort,
            TaskPriority? selectedPriority,
            String? selectedCategory,
            DateTime? selectedDueDateFilter,
            String searchQuery,
            List<String> categories,
            Map<String, int> statistics)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskInitial value) initial,
    required TResult Function(TaskLoading value) loading,
    required TResult Function(TaskLoaded value) loaded,
    required TResult Function(TaskError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaskInitial value)? initial,
    TResult? Function(TaskLoading value)? loading,
    TResult? Function(TaskLoaded value)? loaded,
    TResult? Function(TaskError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskInitial value)? initial,
    TResult Function(TaskLoading value)? loading,
    TResult Function(TaskLoaded value)? loaded,
    TResult Function(TaskError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class TaskLoading implements TaskState {
  const factory TaskLoading() = _$TaskLoadingImpl;
}

/// @nodoc
abstract class _$$TaskLoadedImplCopyWith<$Res> {
  factory _$$TaskLoadedImplCopyWith(
          _$TaskLoadedImpl value, $Res Function(_$TaskLoadedImpl) then) =
      __$$TaskLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<Task> tasks,
      List<Task> filteredTasks,
      TaskFilter currentFilter,
      TaskSortOption currentSort,
      TaskPriority? selectedPriority,
      String? selectedCategory,
      DateTime? selectedDueDateFilter,
      String searchQuery,
      List<String> categories,
      Map<String, int> statistics});
}

/// @nodoc
class __$$TaskLoadedImplCopyWithImpl<$Res>
    extends _$TaskStateCopyWithImpl<$Res, _$TaskLoadedImpl>
    implements _$$TaskLoadedImplCopyWith<$Res> {
  __$$TaskLoadedImplCopyWithImpl(
      _$TaskLoadedImpl _value, $Res Function(_$TaskLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasks = null,
    Object? filteredTasks = null,
    Object? currentFilter = null,
    Object? currentSort = null,
    Object? selectedPriority = freezed,
    Object? selectedCategory = freezed,
    Object? selectedDueDateFilter = freezed,
    Object? searchQuery = null,
    Object? categories = null,
    Object? statistics = null,
  }) {
    return _then(_$TaskLoadedImpl(
      tasks: null == tasks
          ? _value._tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      filteredTasks: null == filteredTasks
          ? _value._filteredTasks
          : filteredTasks // ignore: cast_nullable_to_non_nullable
              as List<Task>,
      currentFilter: null == currentFilter
          ? _value.currentFilter
          : currentFilter // ignore: cast_nullable_to_non_nullable
              as TaskFilter,
      currentSort: null == currentSort
          ? _value.currentSort
          : currentSort // ignore: cast_nullable_to_non_nullable
              as TaskSortOption,
      selectedPriority: freezed == selectedPriority
          ? _value.selectedPriority
          : selectedPriority // ignore: cast_nullable_to_non_nullable
              as TaskPriority?,
      selectedCategory: freezed == selectedCategory
          ? _value.selectedCategory
          : selectedCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedDueDateFilter: freezed == selectedDueDateFilter
          ? _value.selectedDueDateFilter
          : selectedDueDateFilter // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      searchQuery: null == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      statistics: null == statistics
          ? _value._statistics
          : statistics // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
    ));
  }
}

/// @nodoc

class _$TaskLoadedImpl implements TaskLoaded {
  const _$TaskLoadedImpl(
      {required final List<Task> tasks,
      required final List<Task> filteredTasks,
      this.currentFilter = TaskFilter.all,
      this.currentSort = TaskSortOption.creationDate,
      this.selectedPriority,
      this.selectedCategory,
      this.selectedDueDateFilter,
      this.searchQuery = '',
      final List<String> categories = const [],
      final Map<String, int> statistics = const {}})
      : _tasks = tasks,
        _filteredTasks = filteredTasks,
        _categories = categories,
        _statistics = statistics;

  final List<Task> _tasks;
  @override
  List<Task> get tasks {
    if (_tasks is EqualUnmodifiableListView) return _tasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasks);
  }

  final List<Task> _filteredTasks;
  @override
  List<Task> get filteredTasks {
    if (_filteredTasks is EqualUnmodifiableListView) return _filteredTasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredTasks);
  }

  @override
  @JsonKey()
  final TaskFilter currentFilter;
  @override
  @JsonKey()
  final TaskSortOption currentSort;
  @override
  final TaskPriority? selectedPriority;
  @override
  final String? selectedCategory;
  @override
  final DateTime? selectedDueDateFilter;
  @override
  @JsonKey()
  final String searchQuery;
  final List<String> _categories;
  @override
  @JsonKey()
  List<String> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final Map<String, int> _statistics;
  @override
  @JsonKey()
  Map<String, int> get statistics {
    if (_statistics is EqualUnmodifiableMapView) return _statistics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_statistics);
  }

  @override
  String toString() {
    return 'TaskState.loaded(tasks: $tasks, filteredTasks: $filteredTasks, currentFilter: $currentFilter, currentSort: $currentSort, selectedPriority: $selectedPriority, selectedCategory: $selectedCategory, selectedDueDateFilter: $selectedDueDateFilter, searchQuery: $searchQuery, categories: $categories, statistics: $statistics)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskLoadedImpl &&
            const DeepCollectionEquality().equals(other._tasks, _tasks) &&
            const DeepCollectionEquality()
                .equals(other._filteredTasks, _filteredTasks) &&
            (identical(other.currentFilter, currentFilter) ||
                other.currentFilter == currentFilter) &&
            (identical(other.currentSort, currentSort) ||
                other.currentSort == currentSort) &&
            (identical(other.selectedPriority, selectedPriority) ||
                other.selectedPriority == selectedPriority) &&
            (identical(other.selectedCategory, selectedCategory) ||
                other.selectedCategory == selectedCategory) &&
            (identical(other.selectedDueDateFilter, selectedDueDateFilter) ||
                other.selectedDueDateFilter == selectedDueDateFilter) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality()
                .equals(other._statistics, _statistics));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_tasks),
      const DeepCollectionEquality().hash(_filteredTasks),
      currentFilter,
      currentSort,
      selectedPriority,
      selectedCategory,
      selectedDueDateFilter,
      searchQuery,
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_statistics));

  /// Create a copy of TaskState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskLoadedImplCopyWith<_$TaskLoadedImpl> get copyWith =>
      __$$TaskLoadedImplCopyWithImpl<_$TaskLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<Task> tasks,
            List<Task> filteredTasks,
            TaskFilter currentFilter,
            TaskSortOption currentSort,
            TaskPriority? selectedPriority,
            String? selectedCategory,
            DateTime? selectedDueDateFilter,
            String searchQuery,
            List<String> categories,
            Map<String, int> statistics)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(
        tasks,
        filteredTasks,
        currentFilter,
        currentSort,
        selectedPriority,
        selectedCategory,
        selectedDueDateFilter,
        searchQuery,
        categories,
        statistics);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<Task> tasks,
            List<Task> filteredTasks,
            TaskFilter currentFilter,
            TaskSortOption currentSort,
            TaskPriority? selectedPriority,
            String? selectedCategory,
            DateTime? selectedDueDateFilter,
            String searchQuery,
            List<String> categories,
            Map<String, int> statistics)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(
        tasks,
        filteredTasks,
        currentFilter,
        currentSort,
        selectedPriority,
        selectedCategory,
        selectedDueDateFilter,
        searchQuery,
        categories,
        statistics);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<Task> tasks,
            List<Task> filteredTasks,
            TaskFilter currentFilter,
            TaskSortOption currentSort,
            TaskPriority? selectedPriority,
            String? selectedCategory,
            DateTime? selectedDueDateFilter,
            String searchQuery,
            List<String> categories,
            Map<String, int> statistics)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(
          tasks,
          filteredTasks,
          currentFilter,
          currentSort,
          selectedPriority,
          selectedCategory,
          selectedDueDateFilter,
          searchQuery,
          categories,
          statistics);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskInitial value) initial,
    required TResult Function(TaskLoading value) loading,
    required TResult Function(TaskLoaded value) loaded,
    required TResult Function(TaskError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaskInitial value)? initial,
    TResult? Function(TaskLoading value)? loading,
    TResult? Function(TaskLoaded value)? loaded,
    TResult? Function(TaskError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskInitial value)? initial,
    TResult Function(TaskLoading value)? loading,
    TResult Function(TaskLoaded value)? loaded,
    TResult Function(TaskError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class TaskLoaded implements TaskState {
  const factory TaskLoaded(
      {required final List<Task> tasks,
      required final List<Task> filteredTasks,
      final TaskFilter currentFilter,
      final TaskSortOption currentSort,
      final TaskPriority? selectedPriority,
      final String? selectedCategory,
      final DateTime? selectedDueDateFilter,
      final String searchQuery,
      final List<String> categories,
      final Map<String, int> statistics}) = _$TaskLoadedImpl;

  List<Task> get tasks;
  List<Task> get filteredTasks;
  TaskFilter get currentFilter;
  TaskSortOption get currentSort;
  TaskPriority? get selectedPriority;
  String? get selectedCategory;
  DateTime? get selectedDueDateFilter;
  String get searchQuery;
  List<String> get categories;
  Map<String, int> get statistics;

  /// Create a copy of TaskState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskLoadedImplCopyWith<_$TaskLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TaskErrorImplCopyWith<$Res> {
  factory _$$TaskErrorImplCopyWith(
          _$TaskErrorImpl value, $Res Function(_$TaskErrorImpl) then) =
      __$$TaskErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$TaskErrorImplCopyWithImpl<$Res>
    extends _$TaskStateCopyWithImpl<$Res, _$TaskErrorImpl>
    implements _$$TaskErrorImplCopyWith<$Res> {
  __$$TaskErrorImplCopyWithImpl(
      _$TaskErrorImpl _value, $Res Function(_$TaskErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$TaskErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TaskErrorImpl implements TaskError {
  const _$TaskErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'TaskState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of TaskState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskErrorImplCopyWith<_$TaskErrorImpl> get copyWith =>
      __$$TaskErrorImplCopyWithImpl<_$TaskErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<Task> tasks,
            List<Task> filteredTasks,
            TaskFilter currentFilter,
            TaskSortOption currentSort,
            TaskPriority? selectedPriority,
            String? selectedCategory,
            DateTime? selectedDueDateFilter,
            String searchQuery,
            List<String> categories,
            Map<String, int> statistics)
        loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<Task> tasks,
            List<Task> filteredTasks,
            TaskFilter currentFilter,
            TaskSortOption currentSort,
            TaskPriority? selectedPriority,
            String? selectedCategory,
            DateTime? selectedDueDateFilter,
            String searchQuery,
            List<String> categories,
            Map<String, int> statistics)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<Task> tasks,
            List<Task> filteredTasks,
            TaskFilter currentFilter,
            TaskSortOption currentSort,
            TaskPriority? selectedPriority,
            String? selectedCategory,
            DateTime? selectedDueDateFilter,
            String searchQuery,
            List<String> categories,
            Map<String, int> statistics)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskInitial value) initial,
    required TResult Function(TaskLoading value) loading,
    required TResult Function(TaskLoaded value) loaded,
    required TResult Function(TaskError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaskInitial value)? initial,
    TResult? Function(TaskLoading value)? loading,
    TResult? Function(TaskLoaded value)? loaded,
    TResult? Function(TaskError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskInitial value)? initial,
    TResult Function(TaskLoading value)? loading,
    TResult Function(TaskLoaded value)? loaded,
    TResult Function(TaskError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class TaskError implements TaskState {
  const factory TaskError(final String message) = _$TaskErrorImpl;

  String get message;

  /// Create a copy of TaskState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskErrorImplCopyWith<_$TaskErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
