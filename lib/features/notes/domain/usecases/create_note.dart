import '../entities/note_entity.dart';
import '../repositories/notes_repository.dart';

/// Use case for creating note.
class CreateNote {
  /// Creates [CreateNote].
  const CreateNote(this._repository);
  final NotesRepository _repository;
  Future<void> call(NoteEntity note) => _repository.createNote(note);
}
