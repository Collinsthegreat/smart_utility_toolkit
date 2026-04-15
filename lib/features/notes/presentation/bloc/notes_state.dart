import 'package:equatable/equatable.dart';
import '../../domain/entities/note_entity.dart';

/// Sort options for notes.
enum NoteSortOption { dateCreated, dateModified, alphabetical }

/// Notes state.
class NotesState extends Equatable {
  /// Creates [NotesState].
  const NotesState({
    required this.notes,
    required this.filteredNotes,
    required this.sortOrder,
    required this.query,
    required this.status,
  });

  /// Notes loaded from storage.
  final List<NoteEntity> notes;

  /// Notes after search and sort.
  final List<NoteEntity> filteredNotes;

  /// Selected sort order.
  final NoteSortOption sortOrder;

  /// Current search query.
  final String query;

  /// Loading state.
  final NotesStatus status;

  /// Returns copied state.
  NotesState copyWith({
    List<NoteEntity>? notes,
    List<NoteEntity>? filteredNotes,
    NoteSortOption? sortOrder,
    String? query,
    NotesStatus? status,
  }) {
    return NotesState(
      notes: notes ?? this.notes,
      filteredNotes: filteredNotes ?? this.filteredNotes,
      sortOrder: sortOrder ?? this.sortOrder,
      query: query ?? this.query,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => <Object?>[notes, filteredNotes, sortOrder, query, status];
}

/// Notes loading status.
enum NotesStatus { initial, loading, success, failure }
