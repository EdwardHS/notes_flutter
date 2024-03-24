import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../models/note.dart';
import '../utils/database_helper.dart';
import '../constants/app_constant.dart'; // Use the same categories from constants

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];
  List<Note> get notes => _notes;

  void addNote(Note note) async {
    final newNote = await DatabaseHelper.instance.create(note);
    _notes.add(newNote);
    notifyListeners();
  }

  Future<void> updateNote(Note updatedNote) async {
    // Update the note in the database
    await DatabaseHelper.instance.update(updatedNote);

    // Find the index of the note with the same id as updatedNote in the local list.
    final noteIndex = _notes.indexWhere((note) => note.id == updatedNote.id);
    if (noteIndex != -1) {
      // Update the note in the list
      _notes[noteIndex] = updatedNote;
      // Notify listeners to rebuild the UI with updated data
      notifyListeners();
    }
  }

  Future<void> loadNotes() async {
    // Load notes from the database and assign them to _notes
    _notes = await DatabaseHelper.instance.getNotes(); // Hypothetical method to fetch notes
    notifyListeners();
  }

  Future<void> deleteNote(int id) async {
    // Delete the note from the database
    await DatabaseHelper.instance.delete(id);
    
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }

  Future<void> deleteAllNotes() async {
    // Delete all notes from database
    await DatabaseHelper.instance.deleteAllNotes();
    _notes.clear();
    notifyListeners();
  }

  Map<String, int> getCategoryCounts() {
    Map<String, int> categoryCounts = {};
    // count the notes based on category
    for (var category in AppConstant.categories) {
      categoryCounts[category] =
          _notes.where((note) => note.category == category).length;
    }
    return categoryCounts;
  }

  List<Note> getNotesByCategory(String category) {
    return _notes.where((note) => note.category == category).toList();
  }
}
