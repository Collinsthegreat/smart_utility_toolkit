import '../entities/note_entity.dart';
import '../repositories/notes_repository.dart';

/// Use case for updating note.
class UpdateNote {
  /// Creates [UpdateNote].
  const UpdateNote(this._repository);
  final NotesRepository _repository;
  Future<void> call(NoteEntity note) => _repository.updateNote(note);
}
