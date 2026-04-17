import 'package:flutter_test/flutter_test.dart';
import 'package:smart_utility_toolkit/features/tasks/domain/entities/task_entity.dart';
import 'package:smart_utility_toolkit/features/tasks/domain/usecases/task_usecases.dart';

void main() {
  late FilterTasks filterTasks;

  setUp(() {
    filterTasks = FilterTasks();
  });

  test('should return all tasks when filter is all', () {
    final now = DateTime.now();
    final tasks = [
      TaskEntity(id: '1', title: 'A', isCompleted: false, createdAt: now, updatedAt: now),
      TaskEntity(id: '2', title: 'B', isCompleted: true, createdAt: now, updatedAt: now),
    ];

    final result = filterTasks(tasks, TaskFilterMode.all);
    expect(result.length, 2);
  });

  test('should return active tasks when filter is active', () {
    final now = DateTime.now();
    final tasks = [
      TaskEntity(id: '1', title: 'A', isCompleted: false, createdAt: now, updatedAt: now),
      TaskEntity(id: '2', title: 'B', isCompleted: true, createdAt: now, updatedAt: now),
    ];

    final result = filterTasks(tasks, TaskFilterMode.active);
    expect(result.length, 1);
    expect(result.first.id, '1');
  });

  test('should return completed tasks when filter is completed', () {
    final now = DateTime.now();
    final tasks = [
      TaskEntity(id: '1', title: 'A', isCompleted: false, createdAt: now, updatedAt: now),
      TaskEntity(id: '2', title: 'B', isCompleted: true, createdAt: now, updatedAt: now),
    ];

    final result = filterTasks(tasks, TaskFilterMode.completed);
    expect(result.length, 1);
    expect(result.first.id, '2');
  });
}
