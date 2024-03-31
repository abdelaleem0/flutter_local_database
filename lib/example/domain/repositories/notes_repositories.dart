
import 'package:flutter_local_database/example/domain/entities/note_entity.dart';

abstract class NotesRepository {
  Future<int> insertNote(NoteEntity model);

  Future<int> deleteNote({required int id});

  Future<List<NoteEntity>?> getNotes();

  Future<void> deleteNotesTable({required String tableName});
}
