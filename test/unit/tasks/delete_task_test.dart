import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_utility_toolkit/features/tasks/domain/repositories/tasks_repository.dart';
import 'package:smart_utility_toolkit/features/tasks/domain/usecases/task_usecases.dart';

class MockTasksRepository extends Mock implements TasksRepository {}

void main() {
  late DeleteTask usecase;
  late MockTasksRepository repository;

  setUp(() {
    repository = MockTasksRepository();
    usecase = DeleteTask(repository);
  });

  test('should remove task by id', () {
    usecase('1');
    verify(() => repository.deleteTask('1')).called(1);
  });
}
