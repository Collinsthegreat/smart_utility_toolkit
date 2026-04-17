import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../domain/entities/note_entity.dart';
import '../bloc/notes_bloc.dart';
import '../bloc/notes_event.dart';

/// Note editor page.
class NoteDetailPage extends StatefulWidget {
  /// Creates [NoteDetailPage].
  const NoteDetailPage({this.note, super.key});

  /// Existing note to edit.
  final NoteEntity? note;

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late final TextEditingController _titleController;
  late final TextEditingController _bodyController;
  late int _colorIndex;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _bodyController = TextEditingController(text: widget.note?.body ?? '');
    _colorIndex = widget.note?.colorIndex ?? 0;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _saveNote() {
    final String title = _titleController.text.trim();
    final String body = _bodyController.text.trim();
    if (title.isEmpty && body.isEmpty) {
      Navigator.of(context).pop();
      return;
    }
    final DateTime now = DateTime.now();
    final String id = widget.note?.id ?? now.millisecondsSinceEpoch.toString();
    final DateTime createdAt = widget.note?.createdAt ?? now;
    final note = NoteEntity(
      id: id,
      title: title.isEmpty ? 'Untitled note' : title,
      body: body,
      colorIndex: _colorIndex,
      createdAt: createdAt,
      updatedAt: now,
    );
    context.read<NotesBloc>().add(SaveNote(note));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (!didPop) {
          _saveNote();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.note == null ? AppStrings.addNote : AppStrings.notes),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _saveNote,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: AppStrings.noteTitleHint,
                ),
              ),
              const SizedBox(height: AppSizes.md),
              Expanded(
                child: TextField(
                  controller: _bodyController,
                  maxLines: null,
                  expands: true,
                  decoration: const InputDecoration(
                    hintText: AppStrings.noteBodyHint,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.md),
              Text('Color Tag', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSizes.sm),
              Wrap(
                spacing: AppSizes.sm,
                children: List<Widget>.generate(
                  6,
                  (int index) {
                    return ChoiceChip(
                      label: const SizedBox.shrink(),
                      selected: _colorIndex == index,
                      onSelected: (_) => setState(() => _colorIndex = index),
                      selectedColor: Colors.primaries[index].shade200,
                      backgroundColor: Colors.primaries[index].shade100,
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSizes.sm),
              Text(
                '${_bodyController.text.length} characters',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
