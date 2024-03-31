import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_database/note_app/data/di/notes_di.dart';
import 'package:flutter_local_database/note_app/domain/entities/async_entity.dart';
import 'package:flutter_local_database/note_app/domain/entities/note_entity.dart';
import 'package:flutter_local_database/note_app/domain/use_cases/delete_note_use_case.dart';
import 'package:flutter_local_database/note_app/domain/use_cases/delete_all_notes_use_case.dart';
import 'package:flutter_local_database/note_app/domain/use_cases/get_notes_use_case.dart';
import 'package:flutter_local_database/note_app/domain/use_cases/insert_note_use_case.dart';
import 'package:flutter_local_database/note_app/presentation/manager/notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(const NotesState.initial()) {
    _loadUseCases();
  }

  late final GetNotesUseCase _getNotesUseCase;
  late final DeleteNoteUseCase _deleteNoteUseCase;
  late final InsertNoteUseCase _insertNoteUseCase;
  late final DeleteAllNotesUseCase _deleteNotesTableUseCase;

  void _loadUseCases() {
    _getNotesUseCase = injector();
    _deleteNoteUseCase = injector();
    _insertNoteUseCase = injector();
    _deleteNotesTableUseCase = injector();
  }

  void getNotes() async {
    emit(state.reduce(notes: const Async.successWithoutData()));

    emit(state.reduce(notes: const Async.loading()));
    try {
      final response = await _getNotesUseCase();
      if (response != null) {
        emit(state.reduce(notes: Async.success(response)));
      } else {
        emit(state.reduce(
            notes: const Async.failure('error during fetching database')));
      }
    } catch (e) {
      emit(state.reduce(notes: Async.failure(e.toString())));
    }
  }

  void insertNote(NoteEntity model) async {
    emit(state.reduce(insertNote: const Async.loading()));
    try {
      final response = await _insertNoteUseCase(model: model);
      if (response != 0) {
        emit(state.reduce(insertNote: const Async.successWithoutData()));
        _addNewNote(model);
      } else {
        emit(state.reduce(
            insertNote:
                const Async.failure('error during insert item in database')));
      }
    } catch (e) {
      emit(state.reduce(insertNote: Async.failure(e.toString())));
    }
  }

  void deleteNote(int id) async {
    emit(state.reduce(deleteNote: const Async.loading()));
    try {
      final response = await _deleteNoteUseCase(id: id);
      if (response != 0) {
        emit(state.reduce(deleteNote: const Async.successWithoutData()));
        _deleteNote(id);
      } else {
        emit(state.reduce(
            deleteNote:
                const Async.failure('error during delete item from database')));
      }
    } catch (e) {
      emit(state.reduce(deleteNote: Async.failure(e.toString())));
    }
  }

  void deleteNotesTable(String tableName) async {
    emit(state.reduce(deleteNotesTable: const Async.loading()));
    try {
      await _deleteNotesTableUseCase(tableName: tableName);
      emit(state.reduce(deleteNotesTable: const Async.successWithoutData()));
    } catch (e) {
      emit(state.reduce(deleteNotesTable: Async.failure(e.toString())));
    }
  }

  void _addNewNote(NoteEntity model) {
    final newNotesList = [...?state.notes.data];
    newNotesList.add(model);
    emit(state.reduce(notes: Async.success(newNotesList)));
  }

  void _deleteNote(int id) {
    final newNotesList = [...?state.notes.data];
    newNotesList.removeWhere((element) => element.id == id);
    emit(state.reduce(notes: Async.success(newNotesList)));
  }
}
