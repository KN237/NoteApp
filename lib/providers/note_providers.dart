import 'dart:math';
import 'package:faker/faker.dart' as fakers;
import 'package:flutter/material.dart';
import 'package:note_app/models/note.dart';

final faker = fakers.Faker();
final random = Random();

class NoteProviders extends ChangeNotifier {
  final List<Note> _notes = [];
  int get lenght => _notes.length;
  List<Note> get noteList => _notes;
  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void removeNote(Note note) {
    _notes.remove(note);
    notifyListeners();
  }

  void updateNote(String id, String title, String description) {
    Note note = _notes.firstWhere((elt) => elt.id == id);
    note.description = description;
    note.title = title;
    notifyListeners();
  }
}
