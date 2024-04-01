import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_database/example/domain/entities/note_entity.dart';
import 'package:flutter_local_database/example/database/entities/note.dart';

extension ConvertFromNoteToNoteEntity on Note {
  NoteEntity map() {
    return NoteEntity(
        id: id,
        title: _decoding(noteContent)['title'],
        description: _decoding(noteContent)['description'],
        color: color.name.map());
  }
}

extension ConvertFromNoteEntityToNote on NoteEntity {
  Note map() {
    return Note(
        id: id,
        noteContent: _mapping(title, description).encoding,
        color: color.name.map());
  }
}

extension ConvertFromStringtoEnum on String {
  ColorEnum map() {
    switch (this) {
      case "white":
        return ColorEnum.white;
      case "black":
        return ColorEnum.black;
      case "red":
        return ColorEnum.red;
      case "blue":
        return ColorEnum.blue;
      case "green":
        return ColorEnum.green;
      default:
        return ColorEnum.green;
    }
  }
}

extension GetColor on ColorEnum {
  Color get getColor {
    switch (this) {
      case ColorEnum.white:
        return Colors.black26;
      case ColorEnum.black:
        return Colors.black;

      case ColorEnum.red:
        return Colors.red;

      case ColorEnum.blue:
        return Colors.blue;

      case ColorEnum.green:
        return Colors.green;
    }
  }
}

extension Encoding on Map<String, dynamic> {
  String get encoding {
    return jsonEncode(this);
  }
}

Map<String, dynamic> _decoding(String mapAsString) {
  return jsonDecode(mapAsString);
}

Map<String, dynamic> _mapping(String title, String description) {
  return {
    "title": title,
    "description": description,
  };
}
