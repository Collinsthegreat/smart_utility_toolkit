import '../entities/note_entity.dart';

/// Repository contract for notes.
abstract class NotesRepository {
  List<NoteEntity> getAllNotes();
  Future<void> createNote(NoteEntity note);
  Future<void> updateNote(NoteEntity note);
  Future<void> deleteNote(String id);
  List<NoteEntity> searchNotes(String query);
}
