import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_utility_toolkit/features/tasks/domain/entities/task_entity.dart';
import 'package:smart_utility_toolkit/features/tasks/domain/usecases/task_usecases.dart';
import 'package:smart_utility_toolkit/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:smart_utility_toolkit/features/tasks/presentation/bloc/tasks_event.dart';
import 'package:smart_utility_toolkit/features/tasks/presentation/bloc/tasks_state.dart';

class MockGetAllTasks extends Mock implements GetAllTasks {}
class MockCreateTask extends Mock implements CreateTask {}
class MockUpdateTask extends Mock implements UpdateTask {}
class MockDeleteTask extends Mock implements DeleteTask {}
class MockToggleTaskCompletion extends Mock implements ToggleTaskCompletion {}
class MockFilterTasks extends Mock implements FilterTasks {}
class FakeTaskEntity extends Fake implements TaskEntity {}

void main() {
  late TasksBloc bloc;
  late MockGetAllTasks mockGetAll;
  late MockCreateTask mockCreate;
  late MockUpdateTask mockUpdate;
  late MockDeleteTask mockDelete;
  late MockToggleTaskCompletion mockToggle;
  late MockFilterTasks mockFilter;

  setUpAll(() {
    registerFallbackValue(FakeTaskEntity());
    registerFallbackValue(TaskFilterMode.all);
  });

  setUp(() {
    mockGetAll = MockGetAllTasks();
    mockCreate = MockCreateTask();
    mockUpdate = MockUpdateTask();
    mockDelete = MockDeleteTask();
    mockToggle = MockToggleTaskCompletion();
    mockFilter = MockFilterTasks();

    bloc = TasksBloc(
      getAllTasks: mockGetAll,
      createTask: mockCreate,
      updateTask: mockUpdate,
      deleteTask: mockDelete,
      toggleTaskCompletion: mockToggle,
      filterTasks: mockFilter,
    );
  });

  tearDown(() {
    bloc.close();
  });

  group('TasksBloc', () {
    final now = DateTime.now();
    final tasks = [
      TaskEntity(id: '1', title: 'Task 1', isCompleted: false, createdAt: now, updatedAt: now),
    ];

    test('initial state is TasksInitial', () {
      expect(bloc.state, const TasksInitial());
    });

    test('emits [TasksLoading, TasksLoaded] when LoadTasksEvent is added', () async {
      when(() => mockGetAll()).thenReturn(tasks);
      when(() => mockFilter(any(), any()))
          .thenReturn(tasks);

      final expected = [
        const TasksLoading(),
        TasksLoaded(
          tasks: tasks,
          filter: TaskFilterMode.all,
          activeCount: 1,
          completedCount: 0,
        ),
      ];

      expectLater(bloc.stream, emitsInOrder(expected));
      bloc.add(const LoadTasksEvent());
    });

    test('emits [TasksLoaded] when CreateTaskEvent is added', () async {
      when(() => mockCreate(
        title: any(named: 'title'),
        description: any(named: 'description'),
        priority: any(named: 'priority'),
      )).thenAnswer((_) async {});
      
      when(() => mockGetAll()).thenReturn(tasks);
      when(() => mockFilter(any(), any()))
          .thenReturn(tasks);

      final expected = [
        TasksLoaded(
          tasks: tasks,
          filter: TaskFilterMode.all,
          activeCount: 1,
          completedCount: 0,
        ),
      ];

      expectLater(bloc.stream, emitsInOrder(expected));
      
      bloc.add(const CreateTaskEvent(
        title: 'T',
        description: 'D',
        priority: 1,
      ));
    });
  });
}
