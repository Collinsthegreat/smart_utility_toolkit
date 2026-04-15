import '../entities/note_entity.dart';
import '../repositories/notes_repository.dart';

/// Use case for note search.
class SearchNotes {
  /// Creates [SearchNotes].
  const SearchNotes(this._repository);
  final NotesRepository _repository;
  List<NoteEntity> call(String query) => _repository.searchNotes(query);
}
