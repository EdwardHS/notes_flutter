import 'package:notes_flutter/constants/app_constant.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/note.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE ${AppConstant.TABLE_NAME_NOTES} ( 
  ${NoteFields.id} $idType, 
  ${NoteFields.description} $textType,
  ${NoteFields.category} $textType,
  ${NoteFields.time} $textType
  )
''');
  }

  Future<Note> create(Note note) async {
    final db = await instance.database;
    final id = await db.insert(AppConstant.TABLE_NAME_NOTES, note.toJson());
    return note.copy(id: id);
  }

  Future<int> update(Note note) async {
    final db = await instance.database;
    return await db.update(
      AppConstant.TABLE_NAME_NOTES,
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Note>> getNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(AppConstant.TABLE_NAME_NOTES);

    return List.generate(maps.length, (i) {
      return Note.fromMap(maps[i]);
    });
  }

  Future<void> deleteAllNotes() async {
    final db = await database;
    await db.delete(AppConstant.TABLE_NAME_NOTES);
  }

  Future<void> pumpDummyData(List<Note> notes) async {
    final db = await database;

    // Check the number of records in the database
    final count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM ${AppConstant.TABLE_NAME_NOTES}'));
    if (count == 0 || count == 1) {
      for (Note note in notes) {
        await db.insert(
          AppConstant.TABLE_NAME_NOTES,
          note.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    }
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
