import '../../domain/entities/note_entity.dart';
import '../../domain/repositories/notes_repository.dart';
import '../datasources/notes_local_datasource.dart';
import '../models/note_model.dart';

/// Notes repository implementation.
class NotesRepositoryImpl implements NotesRepository {
  /// Creates [NotesRepositoryImpl].
  NotesRepositoryImpl(this._local);
  final NotesLocalDataSource _local;
  @override
  Future<void> createNote(NoteEntity note) async {
    final List<NoteModel> notes = _local.getAll();
    notes.add(NoteModel(id: note.id, title: note.title, body: note.body, colorIndex: note.colorIndex, createdAt: note.createdAt, updatedAt: note.updatedAt));
    await _local.saveAll(notes);
  }
  @override
  Future<void> deleteNote(String id) async {
    final List<NoteModel> notes = _local.getAll()..removeWhere((NoteModel e) => e.id == id);
    await _local.saveAll(notes);
  }
  @override
  List<NoteEntity> getAllNotes() => _local.getAll();
  @override
  List<NoteEntity> searchNotes(String query) {
    final String q = query.toLowerCase();
    return _local.getAll().where((NoteModel e) => e.title.toLowerCase().contains(q) || e.body.toLowerCase().contains(q)).toList();
  }
  @override
  Future<void> updateNote(NoteEntity note) async {
    final List<NoteModel> notes = _local.getAll();
    final int index = notes.indexWhere((NoteModel n) => n.id == note.id);
    if (index >= 0) {
      notes[index] = NoteModel(id: note.id, title: note.title, body: note.body, colorIndex: note.colorIndex, createdAt: note.createdAt, updatedAt: note.updatedAt);
      await _local.saveAll(notes);
    }
  }
}
