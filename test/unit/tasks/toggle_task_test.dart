import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_utility_toolkit/features/tasks/domain/entities/task_entity.dart';
import 'package:smart_utility_toolkit/features/tasks/domain/repositories/tasks_repository.dart';
import 'package:smart_utility_toolkit/features/tasks/domain/usecases/task_usecases.dart';

class MockTasksRepository extends Mock implements TasksRepository {}
class FakeTaskEntity extends Fake implements TaskEntity {}

void main() {
  late ToggleTaskCompletion usecase;
  late MockTasksRepository repository;

  setUpAll(() {
    registerFallbackValue(FakeTaskEntity());
  });

  setUp(() {
    repository = MockTasksRepository();
    usecase = ToggleTaskCompletion(repository);
  });

  test('should toggle task completion status', () {
    final now = DateTime.now();
    final task = TaskEntity(
      id: '1',
      title: 'Task 1',
      isCompleted: false,
      createdAt: now,
      updatedAt: now,
    );

    when(() => repository.getAllTasks()).thenReturn([task]);

    usecase('1');

    verify(() => repository.updateTask(any(that: predicate<TaskEntity>((t) => t.isCompleted == true)))).called(1);
  });
}
