import 'dart:async';

import 'package:floor/floor.dart';
import 'package:flutter_local_database/example/database/dao/notes_dao.dart';
import 'package:flutter_local_database/example/database/entities/note.dart';
import 'package:flutter_local_database/example/domain/entities/note_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'notes_database.g.dart';
@Database(version: 1, entities: [Note])
abstract class NotesDataBase extends FloorDatabase{
  NotesDao get notesDeo;

}