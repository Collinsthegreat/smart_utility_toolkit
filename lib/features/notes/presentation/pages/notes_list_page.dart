import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/notes_bloc.dart';
import '../bloc/notes_event.dart';
import '../bloc/notes_state.dart';
import '../../../../injection.dart';
import '../widgets/note_card.dart';
import 'note_detail_page.dart';

/// Notes listing page.
class NotesListPage extends StatelessWidget {
  /// Creates [NotesListPage].
  const NotesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotesBloc>(
      create: (_) => sl<NotesBloc>()..add(const LoadNotes()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.notes),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<Widget>(builder: (_) => const NoteDetailPage()),
              ),
            )
          ],
        ),
        body: BlocBuilder<NotesBloc, NotesState>(
          builder: (BuildContext context, NotesState state) {
            if (state.status == NotesStatus.loading) {
              return const LoadingWidget();
            }
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  TextField(
                    onChanged: (String value) => context.read<NotesBloc>().add(SearchNotesEvent(value)),
                    decoration: InputDecoration(
                      hintText: 'Search notes',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Sort by', style: Theme.of(context).textTheme.titleMedium),
                      PopupMenuButton<NoteSortOption>(
                        initialValue: state.sortOrder,
                        onSelected: (NoteSortOption value) => context.read<NotesBloc>().add(SortNotesChanged(value)),
                        itemBuilder: (BuildContext context) => <PopupMenuEntry<NoteSortOption>>[
                          const PopupMenuItem<NoteSortOption>(value: NoteSortOption.dateCreated, child: Text('Created')),
                          const PopupMenuItem<NoteSortOption>(value: NoteSortOption.dateModified, child: Text('Modified')),
                          const PopupMenuItem<NoteSortOption>(value: NoteSortOption.alphabetical, child: Text('Alphabetical')),
                        ],
                        child: Row(
                          children: <Widget>[
                            Text(state.sortOrder.name, style: Theme.of(context).textTheme.bodyMedium),
                            const Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (state.filteredNotes.isEmpty)
                    const Expanded(child: EmptyStateWidget(message: AppStrings.noNotes))
                  else
                    Expanded(
                      child: ListView.separated(
                        itemCount: state.filteredNotes.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (BuildContext context, int index) {
                          final note = state.filteredNotes[index];
                          return Dismissible(
                            key: ValueKey(note.id),
                            background: Container(
                              color: Theme.of(context).colorScheme.error,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 16),
                              child: const Icon(Icons.delete, color: Colors.white),
                            ),
                            direction: DismissDirection.endToStart,
                            onDismissed: (_) {
                              context.read<NotesBloc>().add(DeleteNote(note.id));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('Note deleted.'),
                                  action: SnackBarAction(
                                    label: AppStrings.undo,
                                    onPressed: () {
                                      context.read<NotesBloc>().add(SaveNote(note));
                                    },
                                  ),
                                ),
                              );
                            },
                            child: NoteCard(
                              note: note,
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute<Widget>(builder: (_) => NoteDetailPage(note: note)),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
