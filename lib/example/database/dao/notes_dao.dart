import 'package:floor/floor.dart';
import 'package:flutter_local_database/example/database/entities/note.dart';
import 'package:flutter_local_database/example/database/notes_database.dart';
import 'package:flutter_local_database/example/data/di/notes_di.dart';
import 'package:flutter_local_database/example/presentation/utils/constants.dart';

@dao
abstract class NotesDao {
  @Query('SELECT * FROM ${AppConstants.notesTable}')
  Future<List<Note>> getAllNotes();

  @insert
  Future<List<int>> insertNotes(List<Note> notes);

  @insert
  Future<int> insertNote(Note note);
  @delete
  Future<void> deleteSpecificNote(Note note);

  @Query('DELETE FROM ${AppConstants.notesTable}')
  Future<void> deleteAllNotes();

  @Query('SELECT * FROM ${AppConstants.notesTable} WHERE id = :id')
  Future<Note?> findNoteById(int id);

  @update
  Future<int> updateNote(Note note);
}
class NotesDaoImp extends NotesDao{
  NotesDao? _dao;

  Future<NotesDao> get _getInstance async {
    if (_dao == null) {
      final NotesDataBase appDatabase = await injector.getAsync();
      _dao = appDatabase.notesDeo;
    }
    return _dao!;
  }

  @override
  Future<void> deleteAllNotes() async{
    return (await _getInstance).deleteAllNotes();
  }

  @override
  Future<void> deleteSpecificNote(Note note)async {
    return (await _getInstance).deleteSpecificNote(note);
  }

  @override
  Future<List<Note>> getAllNotes()async {
    return (await _getInstance).getAllNotes();
  }

  @override
  Future<int> insertNote(Note note) async{
    return (await _getInstance).insertNote(note);
  }

  @override
  Future<List<int>> insertNotes(List<Note> notes)async {
    return (await _getInstance).insertNotes(notes);
  }

  @override
  Future<int> updateNote(Note note) async {
    return (await _getInstance).updateNote(note);
  }

  @override
  Future<Note?> findNoteById(int id) async{
    return (await _getInstance).findNoteById(id);
  }

}

