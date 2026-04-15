import 'package:flutter/material.dart';

/// Note editor widget.
class NoteEditor extends StatelessWidget {
  /// Creates [NoteEditor].
  const NoteEditor({required this.titleController, required this.bodyController, super.key});
  final TextEditingController titleController;
  final TextEditingController bodyController;
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      TextField(controller: titleController, decoration: const InputDecoration(hintText: 'Title')),
      const SizedBox(height: 12),
      TextField(controller: bodyController, maxLines: 10, decoration: const InputDecoration(hintText: 'Write your note...')),
    ]);
  }
}
