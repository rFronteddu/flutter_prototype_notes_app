import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';

import 'note.dart';

class NoteDatabase extends ChangeNotifier {
  List<Note> currentNotes = [];

  static final NoteDatabase instance = NoteDatabase._init();
  static Database? _database;

  NoteDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE notes(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      text TEXT NOT NULL
    )
    ''');
  }

  Future<Note> create(String textFromUser) async {
    final newNote = Note(id: null, text: textFromUser);
    final db = await instance.database;
    final id = await db.insert('notes', newNote.toMap());
    return newNote.copyWith(id: id);
  }

  Future<void> readAllNotes() async {
    final db = await instance.database;
    const orderBy = 'id DESC';
    final result = await db.query('notes', orderBy: orderBy);
    currentNotes.clear();
    currentNotes.addAll(result.map((json) => Note.fromMap(json)).toList());
    notifyListeners();
  }

  Future<void> update(int id, String newText) async {
    Note newNote = Note(id: id, text: newText);
    final db = await instance.database;

    int count = await db.update(
      'notes',
      newNote.toMap(),
      where: 'id = ?',
      whereArgs: [newNote.id],
    );
    if(count > 0) {
      await readAllNotes();
    }
  }

  Future<void> delete(int id) async {
    final db = await instance.database;
    db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
