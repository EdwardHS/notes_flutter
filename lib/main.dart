import 'package:flutter/material.dart';
import 'package:notes_flutter/providers/note_provider.dart';
import 'package:notes_flutter/views/home_screen.dart';
import 'package:provider/provider.dart';

import 'models/note.dart';
import 'utils/database_helper.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure plugin services are initialized
  final dbHelper = DatabaseHelper.instance;

  // Prepare dummy data
  List<Note> dummyNotes = [
    Note(
      id: 1,
      description:
          'How to calculate float multiplication and division in Javascript?',
      category: 'Work and study',
      createdTime: DateTime.now().subtract(Duration(days: 1)),
    ),
    Note(
      id: 2,
      description: 'Overview of basic computer networking knowledge',
      category: 'Work and study',
      createdTime: DateTime.now(),
    ),
    Note(
      id: 3,
      description: 'Pan-fried chicken breast with vegetable salad',
      category: 'Life',
      createdTime: DateTime.now(),
    ),
    Note(
      id: 4,
      description: 'Maintain sufficient daily water intake',
      category: 'Health and wellness',
      createdTime: DateTime.now(),
    ),
  ];

  await dbHelper.pumpDummyData(dummyNotes); // Insert fake data if necessary

  final noteProvider = NoteProvider();
  await noteProvider.loadNotes(); // Load notes from the database

  runApp(
    ChangeNotifierProvider.value(
      value: noteProvider,
      child: MyApp(),
    ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Notes',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Color(0xFFF94695),
          fontFamily: 'PingFangSC',
          textTheme: TextTheme(
            displayLarge: TextStyle(color: Colors.white), 
            displayMedium: TextStyle(color: Colors.white), 
            displaySmall: TextStyle(color: Colors.white), 
            headlineLarge: TextStyle(color: Colors.white), 
            headlineMedium: TextStyle(color: Colors.white), 
            headlineSmall: TextStyle(color: Colors.white), 
            titleLarge: TextStyle(color: Colors.white), 
            titleMedium: TextStyle(color: Colors.white), 
            titleSmall: TextStyle(color: Colors.white), 
            labelLarge: TextStyle(color: Colors.white), 
            labelMedium: TextStyle(color: Colors.white), 
            labelSmall: TextStyle(color: Colors.white), 
            bodyLarge: TextStyle(color: Colors.white), 
            bodyMedium: TextStyle(color: Colors.white), 
            bodySmall: TextStyle(color: Colors.white), 
          ),
        ),
        home: HomeScreen(),
      );
  }
}
