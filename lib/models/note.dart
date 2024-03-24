// Note model with fields
import 'package:notes_flutter/constants/app_constant.dart';

class Note {
  int? id;
  String description;
  String category;
  DateTime createdTime;

  Note({
    this.id,
    required this.description,
    required this.category,
    required this.createdTime,
  });

  Note copy({
    int? id,
    String? description,
    String? category,
    DateTime? createdTime,
  }) =>
      Note(
        id: id ?? this.id,
        description: description ?? this.description,
        category: category ?? this.category,
        createdTime: createdTime ?? this.createdTime,
      );

  // A method that constructs a Note from a Map. The map structure corresponds to database's columns.
  static Note fromJson(Map<String, dynamic> json) => Note(
        id: json[NoteFields.id] as int?,
        description: json[NoteFields.description] as String,
        category: json[NoteFields.category] as String,
        createdTime: DateTime.parse(json[NoteFields.time] as String),
      );

  // Convert a Note instance into a Map. The keys must correspond to the names of the columns in the database.
  Map<String, dynamic> toJson() => {
        NoteFields.id: id,
        NoteFields.description: description,
        NoteFields.category: category,
        NoteFields.time: createdTime.toIso8601String(),
      };

  factory Note.fromMap(Map<String, dynamic> json) => Note(
        id: json['id'],
        description: json['description'],
        category: json['category'],
        createdTime: DateTime.parse(json['createdTime']),
      );

  Map<String, dynamic> toMap() => {
        NoteFields.id: id,
        NoteFields.description: description,
        NoteFields.category: category,
        NoteFields.time: createdTime.toIso8601String(),
      };
}

class NoteFields {
  static final String id = AppConstant.COL_NOTE_ID;
  static final String description = AppConstant.COL_NOTE_DESC;
  static final String category = AppConstant.COL_NOTE_CATEGORY;
  static final String time = AppConstant.COL_NOTE_CREATED_TIME;
}
