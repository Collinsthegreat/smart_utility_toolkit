import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/constants/app_constants.dart';
import 'features/notes/data/datasources/notes_local_datasource.dart';
import 'features/notes/data/repositories/notes_repository_impl.dart';
import 'features/notes/domain/usecases/create_note.dart';
import 'features/notes/domain/usecases/delete_note.dart';
import 'features/notes/domain/usecases/get_all_notes.dart';
import 'features/notes/domain/usecases/search_notes.dart';
import 'features/notes/domain/usecases/update_note.dart';
import 'features/notes/presentation/bloc/notes_bloc.dart';

/// Global service locator.
final GetIt sl = GetIt.instance;

/// Configures all injectable dependencies.
Future<void> configureDependencies() async {
  final notesBox = Hive.box<dynamic>(AppConstants.notesBox);
  
  // Data sources
  sl.registerLazySingleton(() => NotesLocalDataSource(notesBox));
  
  // Repositories
  sl.registerLazySingleton(() => NotesRepositoryImpl(sl<NotesLocalDataSource>()));

  // Use cases
  sl.registerLazySingleton(() => GetAllNotes(sl<NotesRepositoryImpl>()));
  sl.registerLazySingleton(() => SearchNotes(sl<NotesRepositoryImpl>()));
  sl.registerLazySingleton(() => CreateNote(sl<NotesRepositoryImpl>()));
  sl.registerLazySingleton(() => UpdateNote(sl<NotesRepositoryImpl>()));
  sl.registerLazySingleton(() => DeleteNote(sl<NotesRepositoryImpl>()));

  // Blocs
  sl.registerFactory(() => NotesBloc(
    getAllNotes: sl<GetAllNotes>(),
    searchNotes: sl<SearchNotes>(),
    createNote: sl<CreateNote>(),
    updateNote: sl<UpdateNote>(),
    deleteNote: sl<DeleteNote>(),
  ));
}

