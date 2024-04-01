import 'package:floor/floor.dart';
import'package:flutter_local_database/example/domain/entities/note_entity.dart';
import 'package:flutter_local_database/example/presentation/utils/constants.dart';

@Entity(tableName: AppConstants.notesTable)
class Note {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String noteContent;
  final ColorEnum color;

  Note(
      {required this.id,
      required this.noteContent,
      required this.color});
}
