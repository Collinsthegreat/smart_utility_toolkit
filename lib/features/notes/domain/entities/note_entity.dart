import 'package:equatable/equatable.dart';

/// Notes entity used in domain.
class NoteEntity extends Equatable {
  /// Creates [NoteEntity].
  const NoteEntity({required this.id, required this.title, required this.body, required this.colorIndex, required this.createdAt, required this.updatedAt});
  final String id;
  final String title;
  final String body;
  final int colorIndex;
  final DateTime createdAt;
  final DateTime updatedAt;
  @override
  List<Object?> get props => <Object?>[id, title, body, colorIndex, createdAt, updatedAt];
}
