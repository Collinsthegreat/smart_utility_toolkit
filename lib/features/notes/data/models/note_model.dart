import '../../domain/entities/note_entity.dart';

/// Note model for persistence.
class NoteModel extends NoteEntity {
  /// Creates [NoteModel].
  const NoteModel({required super.id, required super.title, required super.body, required super.colorIndex, required super.createdAt, required super.updatedAt});
  Map<String, dynamic> toJson() => <String, dynamic>{'id': id, 'title': title, 'body': body, 'colorIndex': colorIndex, 'createdAt': createdAt.toIso8601String(), 'updatedAt': updatedAt.toIso8601String()};
  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(id: json['id'] as String, title: json['title'] as String, body: json['body'] as String, colorIndex: json['colorIndex'] as int, createdAt: DateTime.parse(json['createdAt'] as String), updatedAt: DateTime.parse(json['updatedAt'] as String));
}
