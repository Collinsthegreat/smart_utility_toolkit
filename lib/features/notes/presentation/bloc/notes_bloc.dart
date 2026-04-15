import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/note_entity.dart';
import '../../domain/usecases/create_note.dart';
import '../../domain/usecases/delete_note.dart' as notes_usecases;
import '../../domain/usecases/get_all_notes.dart';
import '../../domain/usecases/search_notes.dart';
import '../../domain/usecases/update_note.dart';
import 'notes_event.dart';
import 'notes_state.dart';

/// Notes BLoC.
class NotesBloc extends Bloc<NotesEvent, NotesState> {
  /// Creates [NotesBloc].
  NotesBloc({
    required GetAllNotes getAllNotes,
    required SearchNotes searchNotes,
    required CreateNote createNote,
    required UpdateNote updateNote,
    required notes_usecases.DeleteNote deleteNote,
  })  : _getAllNotes = getAllNotes,
        _searchNotes = searchNotes,
        _createNote = createNote,
        _updateNote = updateNote,
        _deleteNote = deleteNote,
        super(const NotesState(
          notes: <NoteEntity>[],
          filteredNotes: <NoteEntity>[],
          sortOrder: NoteSortOption.dateCreated,
          query: '',
          status: NotesStatus.initial,
        )) {
    on<LoadNotes>(_onLoadNotes);
    on<SearchNotesEvent>(_onSearchNotes);
    on<SaveNote>(_onSaveNote);
    on<DeleteNote>(_onDeleteNote);
    on<SortNotesChanged>(_onSortChanged);
  }

  final GetAllNotes _getAllNotes;
  final SearchNotes _searchNotes;
  final CreateNote _createNote;
  final UpdateNote _updateNote;
  final notes_usecases.DeleteNote _deleteNote;

  Future<void> _onLoadNotes(LoadNotes event, Emitter<NotesState> emit) async {
    emit(state.copyWith(status: NotesStatus.loading));
    try {
      final List<NoteEntity> notes = _getAllNotes();
      final List<NoteEntity> sorted = _sort(notes, state.sortOrder);
      emit(state.copyWith(notes: notes, filteredNotes: sorted, status: NotesStatus.success));
    } catch (_) {
      emit(state.copyWith(status: NotesStatus.failure));
    }
  }

  void _onSearchNotes(SearchNotesEvent event, Emitter<NotesState> emit) {
    final List<NoteEntity> results = _searchNotes(event.query);
    final List<NoteEntity> sorted = _sort(results, state.sortOrder);
    emit(state.copyWith(query: event.query, filteredNotes: sorted, status: NotesStatus.success));
  }

  Future<void> _onSaveNote(SaveNote event, Emitter<NotesState> emit) async {
    emit(state.copyWith(status: NotesStatus.loading));
    try {
      final NoteEntity note = event.note;
      if (state.notes.any((NoteEntity existing) => existing.id == note.id)) {
        await _updateNote(note);
      } else {
        await _createNote(note);
      }
      add(const LoadNotes());
    } catch (_) {
      emit(state.copyWith(status: NotesStatus.failure));
    }
  }

  Future<void> _onDeleteNote(DeleteNote event, Emitter<NotesState> emit) async {
    emit(state.copyWith(status: NotesStatus.loading));
    try {
      await _deleteNote(event.noteId);
      add(const LoadNotes());
    } catch (_) {
      emit(state.copyWith(status: NotesStatus.failure));
    }
  }

  void _onSortChanged(SortNotesChanged event, Emitter<NotesState> emit) {
    final List<NoteEntity> sorted = _sort(state.filteredNotes, event.sortOrder);
    emit(state.copyWith(sortOrder: event.sortOrder, filteredNotes: sorted));
  }

  List<NoteEntity> _sort(List<NoteEntity> notes, NoteSortOption option) {
    final List<NoteEntity> sorted = List<NoteEntity>.from(notes);
    switch (option) {
      case NoteSortOption.dateCreated:
        sorted.sort((NoteEntity a, NoteEntity b) => b.createdAt.compareTo(a.createdAt));
        break;
      case NoteSortOption.dateModified:
        sorted.sort((NoteEntity a, NoteEntity b) => b.updatedAt.compareTo(a.updatedAt));
        break;
      case NoteSortOption.alphabetical:
        sorted.sort((NoteEntity a, NoteEntity b) => a.title.compareTo(b.title));
        break;
    }
    return sorted;
  }
}
