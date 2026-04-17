import 'package:equatable/equatable.dart';

/// Task Entity representing business logic model.
class TaskEntity extends Equatable {
  /// Creates [TaskEntity].
  const TaskEntity({
    required this.id,
    required this.title,
    this.description = '',
    this.isCompleted = false,
    this.priority = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Unique task identifier.
  final String id;

  /// Task title.
  final String title;

  /// Task description.
  final String description;

  /// Whether task is completed.
  final bool isCompleted;

  /// Priority of task (0 = Low, 1 = Medium, 2 = High).
  final int priority;

  /// Date task was created.
  final DateTime createdAt;

  /// Date task was last updated.
  final DateTime updatedAt;

  /// Returns copy of this entity with given fields replaced.
  TaskEntity copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    int? priority,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        id,
        title,
        description,
        isCompleted,
        priority,
        createdAt,
        updatedAt,
      ];
}
