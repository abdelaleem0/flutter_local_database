import 'package:equatable/equatable.dart';

class NoteEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final ColorEnum color;

  const NoteEntity(
      {required this.id,
      required this.title,
      required this.description,
      required this.color});

  const NoteEntity.initial()
      : this(id: 0, title: '', description: '', color: ColorEnum.white);

  @override
  List<Object?> get props => [title, description, color];
}

enum ColorEnum {
  white,
  black,
  red,
  blue,
  green,
}
