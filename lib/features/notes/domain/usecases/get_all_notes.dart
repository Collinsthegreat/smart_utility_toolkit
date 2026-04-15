import '../entities/note_entity.dart';
import '../repositories/notes_repository.dart';

/// Use case for loading all notes.
class GetAllNotes {
  /// Creates [GetAllNotes].
  const GetAllNotes(this._repository);
  final NotesRepository _repository;
  List<NoteEntity> call() => _repository.getAllNotes();
}
