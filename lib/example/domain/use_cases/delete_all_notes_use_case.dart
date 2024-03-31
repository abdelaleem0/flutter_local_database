
import 'package:flutter_local_database/example/domain/repositories/notes_repositories.dart';

class DeleteAllNotesUseCase{
  final NotesRepository repository;

  DeleteAllNotesUseCase({required this.repository});

  Future<void> call({required String tableName}){
    return repository.deleteNotesTable(tableName: tableName);
}


}