import 'package:floor/floor.dart';
import'package:flutter_local_database/note_app/domain/entities/note_entity.dart';
import 'package:flutter_local_database/note_app/presentation/utils/constants.dart';

@Entity(tableName: AppConstants.notesTable)
class Note {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String title;
  final String description;
  final ColorEnum color;

  Note(
      {required this.id,
      required this.title,
      required this.description,
      required this.color});
}
