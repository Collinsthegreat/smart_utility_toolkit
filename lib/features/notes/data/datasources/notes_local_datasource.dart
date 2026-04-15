import 'package:hive/hive.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/note_model.dart';

/// Local notes datasource backed by Hive.
class NotesLocalDataSource {
  /// Creates [NotesLocalDataSource].
  NotesLocalDataSource(this._box);
  final Box<dynamic> _box;
  List<NoteModel> getAll() {
    final List<dynamic> raw = _box.get(AppConstants.notesBox, defaultValue: <dynamic>[]) as List<dynamic>;
    return raw.map((dynamic item) => NoteModel.fromJson(Map<String, dynamic>.from(item as Map))).toList();
  }
  Future<void> saveAll(List<NoteModel> notes) async => _box.put(AppConstants.notesBox, notes.map((NoteModel e) => e.toJson()).toList());
}
