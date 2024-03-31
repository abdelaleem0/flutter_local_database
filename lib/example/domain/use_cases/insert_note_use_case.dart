
import 'package:flutter_local_database/example/domain/entities/note_entity.dart';
import 'package:flutter_local_database/example/domain/repositories/notes_repositories.dart';

class InsertNoteUseCase{
  final NotesRepository repository;

  InsertNoteUseCase({required this.repository});
  Future<int> call({required NoteEntity model}) {
    return repository.insertNote(model);
  }


}