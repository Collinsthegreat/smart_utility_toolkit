import 'package:hive/hive.dart';
import '../../domain/entities/task_entity.dart';

part 'task_model.g.dart';

/// Hive model for task.
@HiveType(typeId: 3)
class TaskModel {
  /// Creates [TaskModel].
  TaskModel({
    required this.id,
    required this.title,
    this.description = '',
    this.isCompleted = false,
    this.priority = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Unique task identifier.
  @HiveField(0)
  final String id;

  /// Task title.
  @HiveField(1)
  final String title;

  /// Task description.
  @HiveField(2)
  final String description;

  /// Whether task is completed.
  @HiveField(3)
  final bool isCompleted;

  /// Priority of task.
  @HiveField(4)
  final int priority;

  /// Date created.
  @HiveField(5)
  final DateTime createdAt;

  /// Date updated.
  @HiveField(6)
  final DateTime updatedAt;

  /// Maps model to entity.
  TaskEntity toEntity() {
    return TaskEntity(
      id: id,
      title: title,
      description: description,
      isCompleted: isCompleted,
      priority: priority,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Creates model from entity.
  factory TaskModel.fromEntity(TaskEntity entity) {
    return TaskModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      isCompleted: entity.isCompleted,
      priority: entity.priority,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  /// Returns copy of this model with given fields replaced.
  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    int? priority,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
