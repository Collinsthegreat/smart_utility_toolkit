import '../repositories/notes_repository.dart';

/// Use case for deleting note.
class DeleteNote {
  /// Creates [DeleteNote].
  const DeleteNote(this._repository);
  final NotesRepository _repository;
  Future<void> call(String id) => _repository.deleteNote(id);
}
