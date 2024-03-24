import 'package:flutter/material.dart';
import 'package:notes_flutter/views/note_screen.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../providers/note_provider.dart';
import '../widgets/layouts/app_bar_layout.dart';
import '../widgets/layouts/body_layout.dart';

class CategoryDetailScreen extends StatelessWidget {
  final String categoryName;

  const CategoryDetailScreen({Key? key, required this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notes =
        Provider.of<NoteProvider>(context).getNotesByCategory(categoryName);

    return Scaffold(
      appBar: AppBarLayout(title: categoryName),
      body: BodyLayout(
        child: notes.isEmpty
            ? Center(
                child: Text(
                  'No notes in this category',
                  style: TextStyle(color: Colors.white54),
                ),
              )
            : ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return Card(
                    color: Colors.transparent,
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 0.09),
                        border: Border.all(
                            color: Color.fromRGBO(255, 255, 255, 0.05)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        title: Text(note.description,
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        trailing: IconButton(
                          icon: Icon(Icons.arrow_forward_ios,
                              color: Theme.of(context).primaryColor, size: 18),
                          onPressed: () {
                            print(
                                "Navigating with note: ${note.id}, ${note.description}");

                            // Navigate to NoteScreen with the selected note data
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => NoteScreen(note: note),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
