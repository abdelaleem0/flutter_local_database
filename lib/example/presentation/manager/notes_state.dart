import 'package:equatable/equatable.dart';
import 'package:flutter_local_database/example/domain/entities/async_entity.dart';
import 'package:flutter_local_database/example/domain/entities/note_entity.dart';

class NotesState extends Equatable {
  final Async<List<NoteEntity>> notes;
  final Async<void> insertNote;
  final Async<void> deleteNote;
  final Async<void> deleteNotesTable;

  const NotesState({
    required this.notes,
    required this.insertNote,
    required this.deleteNote,
    required this.deleteNotesTable,
  });

  const NotesState.initial()
      : this(
          notes: const Async.initial(),
          insertNote: const Async.initial(),
          deleteNote: const Async.initial(),
          deleteNotesTable: const Async.initial(),
        );

  NotesState reduce({
    Async<List<NoteEntity>>? notes,
    Async<void>? insertNote,
    Async<void>? deleteNote,
    Async<void>? deleteNotesTable,
  }) {
    return NotesState(
      notes: notes ?? this.notes,
      insertNote: insertNote ?? this.insertNote,
      deleteNote: deleteNote ?? this.deleteNote,
      deleteNotesTable: deleteNotesTable ?? this.deleteNotesTable,
    );
  }

  @override
  List<Object?> get props => [notes, insertNote, deleteNote, deleteNotesTable];
}
