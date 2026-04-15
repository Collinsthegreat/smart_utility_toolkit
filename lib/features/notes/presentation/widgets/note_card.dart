import 'package:flutter/material.dart';
import '../../domain/entities/note_entity.dart';

/// Card widget for note preview.
class NoteCard extends StatelessWidget {
  /// Creates [NoteCard].
  const NoteCard({required this.note, required this.onTap, super.key});

  /// Note entity.
  final NoteEntity note;

  /// Tap callback.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.primaries[note.colorIndex % Colors.primaries.length].shade100,
      child: ListTile(
        onTap: onTap,
        title: Text(note.title, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 4),
            Text(
              note.body,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              'Updated ${note.updatedAt.toLocal().toString().split(' ').first}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
