import 'package:flutter_local_database/note_app/data/mappers/notes_extension.dart';
import 'package:flutter_local_database/note_app/database/dao/notes_dao.dart';
import 'package:flutter_local_database/note_app/database/dao/notes_dao.dart';
import 'package:flutter_local_database/note_app/database/entities/note.dart';
import 'package:flutter_local_database/note_app/domain/entities/note_entity.dart';
import'package:flutter_local_database/note_app/domain/repositories/notes_repositories.dart';

class NotesRepositoriesFloorImpl implements NotesRepository {
  final NotesDao _notesDao;

  NotesRepositoriesFloorImpl({required NotesDao notesDao}) : _notesDao = notesDao;


  @override
  Future<int> deleteNote({required int id}) async {
    Note? item = await _notesDao.findNoteById(id);
    if (item == null) {
      return 0;
    } else {

      await _notesDao.deleteSpecificNote(item);
      return 1;
    }
  }

  @override
  Future<void> deleteNotesTable({required String tableName}) async {
    await _notesDao.deleteAllNotes();
  }

  @override
  Future<List<NoteEntity>?> getNotes() async {
    final data = await _notesDao.getAllNotes();
    final notes = data.map((e) => e.map()).toList();
    return notes;
  }

  @override
  Future<int> insertNote(NoteEntity model) {
    return _notesDao.insertNote(model.map());
  }
}
