import 'dart:math';
import 'package:faker/faker.dart' as fakers;
import 'package:flutter/material.dart';
import 'package:note_app/models/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final faker = fakers.Faker();
final random = Random();

Future<Database> getDb() async {
  final dbPath = await getDatabasesPath();
  final String path = join(dbPath, 'note_app.db');

  return await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE Note (id INTEGER PRIMARY KEY, title TEXT, description TEXT, date TEXT, color TEXT)');
    },
  );
}

class NoteProviders extends ChangeNotifier {
  List<Note> _notes = [];
  bool isLoading = true;
  int get lenght => _notes.length;
  List<Note> get noteList => _notes;

  void loadData() async {
    final db = await getDb();
    List<Note> notes = [];
    List<Map<String, Object?>> temp = await db.query('Note');

    for (var elt in temp) {
      notes.add(
        Note.fromJson(elt),
      );
    }
    _notes = notes;
    isLoading = false;
    notifyListeners();
  }

  void addNote(Note note) async {
    isLoading = true;
    final db = await getDb();
    final test = await db.insert('Note', note.toJson());
    print(test);
    loadData();
  }

  void removeNote(Note note) async {
    isLoading = true;
    final db = await getDb();
    await db.delete('Note', where: 'id = ?', whereArgs: [note.id]);
    loadData();
  }

  void updateNote(int id, String title, String description) async {
    isLoading = true;
    Note note = _notes.firstWhere((elt) => elt.id == id);
    note.description = description;
    note.title = title;
    final db = await getDb();
    await db
        .update('Note', note.toJson(), where: 'id = ?', whereArgs: [note.id]);
    loadData();
  }
}
