import 'package:equatable/equatable.dart';
import '../../domain/entities/note_entity.dart';
import 'notes_state.dart';

/// Notes events.
abstract class NotesEvent extends Equatable {
  /// Creates [NotesEvent].
  const NotesEvent();

  @override
  List<Object?> get props => <Object?>[];
}

/// Loads notes event.
class LoadNotes extends NotesEvent {
  /// Creates [LoadNotes].
  const LoadNotes();
}

/// Search notes by query.
class SearchNotesEvent extends NotesEvent {
  /// Creates [SearchNotesEvent].
  const SearchNotesEvent(this.query);

  /// Search query.
  final String query;

  @override
  List<Object?> get props => <Object?>[query];
}

/// Save or update note event.
class SaveNote extends NotesEvent {
  /// Creates [SaveNote].
  const SaveNote(this.note);

  /// Note to save.
  final NoteEntity note;

  @override
  List<Object?> get props => <Object?>[note];
}

/// Delete note event.
class DeleteNote extends NotesEvent {
  /// Creates [DeleteNote].
  const DeleteNote(this.noteId);

  /// Note id to delete.
  final String noteId;

  @override
  List<Object?> get props => <Object?>[noteId];
}

/// Sort notes event.
class SortNotesChanged extends NotesEvent {
  /// Creates [SortNotesChanged].
  const SortNotesChanged(this.sortOrder);

  /// Selected sort order.
  final NoteSortOption sortOrder;

  @override
  List<Object?> get props => <Object?>[sortOrder];
}
