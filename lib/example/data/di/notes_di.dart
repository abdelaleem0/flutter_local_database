import 'package:flutter_local_database/example/data/repositories/floor_notes_repositories_impl.dart';
import 'package:flutter_local_database/example/database/dao/notes_dao.dart';
import 'package:flutter_local_database/example/database/notes_database.dart';
import 'package:flutter_local_database/example/domain/repositories/notes_repositories.dart';
import 'package:flutter_local_database/example/domain/use_cases/delete_note_use_case.dart';
import 'package:flutter_local_database/example/domain/use_cases/delete_all_notes_use_case.dart';
import 'package:flutter_local_database/example/domain/use_cases/get_notes_use_case.dart';
import 'package:flutter_local_database/example/domain/use_cases/insert_note_use_case.dart';
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  injector.pushNewScope();
  await _registerNotesFloorDependencies();
}

Future<void> _registerNotesFloorDependencies() async {
  injector.registerFactory(() => InsertNoteUseCase(repository: injector()));
  injector.registerFactory(() => DeleteNoteUseCase(repository: injector()));
  injector.registerFactory(
    () => GetNotesUseCase(repository: injector()),
  );
  injector.registerFactory(() => DeleteAllNotesUseCase(repository: injector()));

  _registerFloorDataBase();
}

Future<void> _registerFloorDataBase() async {
  injector.registerLazySingletonAsync<NotesDataBase>(
      () => $FloorNotesDataBase.databaseBuilder('app_database.db').build());
  injector.registerLazySingleton<NotesDao>(() => NotesDaoImp());
  injector.registerLazySingleton<NotesRepository>(
    () => NotesRepositoriesFloorImpl(notesDao: injector()),
  );
}
