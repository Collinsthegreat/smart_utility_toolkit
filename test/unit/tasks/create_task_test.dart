import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_utility_toolkit/features/tasks/domain/entities/task_entity.dart';
import 'package:smart_utility_toolkit/features/tasks/domain/repositories/tasks_repository.dart';
import 'package:smart_utility_toolkit/features/tasks/domain/usecases/task_usecases.dart';

class MockTasksRepository extends Mock implements TasksRepository {}

class FakeTaskEntity extends Fake implements TaskEntity {}

void main() {
  late CreateTask usecase;
  late MockTasksRepository repository;

  setUpAll(() {
    registerFallbackValue(FakeTaskEntity());
  });

  setUp(() {
    repository = MockTasksRepository();
    usecase = CreateTask(repository);
  });

  test('should create task and save to repository', () {
    const title = 'Test Task';
    const description = 'Test Description';
    const priority = 1;

    usecase(title: title, description: description, priority: priority);

    verify(() => repository.createTask(any())).called(1);
  });
}
