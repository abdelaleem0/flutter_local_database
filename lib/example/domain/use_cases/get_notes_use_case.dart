import 'package:flutter_local_database/example/domain/entities/note_entity.dart';
import 'package:flutter_local_database/example/domain/repositories/notes_repositories.dart';

class GetNotesUseCase{
  final NotesRepository repository;

  GetNotesUseCase({required this.repository});
  Future<List<NoteEntity>?> call() {
    return repository.getNotes();
  }


}