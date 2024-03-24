import 'package:flutter/material.dart';
import 'package:notes_flutter/constants/app_constant.dart';
import 'package:notes_flutter/widgets/bottom_action_button.dart';
import 'package:notes_flutter/widgets/custom_alert_dialog.dart';
import 'package:notes_flutter/widgets/layouts/app_bar_layout.dart';
import 'package:notes_flutter/widgets/layouts/body_layout.dart';
import 'package:notes_flutter/widgets/layouts/bottom_bar_layout.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../providers/note_provider.dart';

class NoteScreen extends StatefulWidget {
  final Note? note; // Accepts a note for editing

  NoteScreen({Key? key, this.note}) : super(key: key);

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  String? selectedCategory;
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _noteController.text = widget.note!.description;
      selectedCategory = widget.note!.category;
    }
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _saveNote() {
    if (selectedCategory == null || _noteController.text.isEmpty) {
      // Show alert dialog if no category or note content is provided
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            title: 'Missing Information',
            content:
                'Please select a category and enter note content before saving.',
            actions: <Widget>[
              TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return; // Return from the function, preventing the save action
    }

    final provider = Provider.of<NoteProvider>(context, listen: false);
    final now = DateTime.now();

    if (widget.note != null) {
      // Update existing note
      final note = widget.note!.copy(
        id: widget.note!.id,
        description: _noteController.text,
        category: selectedCategory!,
      );
      provider.updateNote(note);
      //update the note to database;
    } else {
      final note = Note(
        description: _noteController.text,
        category: selectedCategory!,
        createdTime: now,
      );
      provider.addNote(note);
      //add the note to database;
    }

    Navigator.of(context).pop(); // Go back to the previous screen
  }

void _deleteNote(BuildContext context, int noteId) {
  // Show a confirmation dialog before deletion
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomAlertDialog(
        title: 'Delete Note',
        content: 'Are you sure you want to delete this note?',
        actions: <Widget>[
          TextButton(
            child: Text('Cancel', style: TextStyle(color: Colors.white)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text('Delete', style: TextStyle(color: Colors.white)),
            onPressed: () async {
              Navigator.of(context).pop(); // Close the dialog
              await Provider.of<NoteProvider>(context, listen: false).deleteNote(noteId);
              Navigator.of(context).pop(); // Go back to the previous screen
            },
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarLayout(
          title: 'Create New Note',
        ),
        body: BodyLayout(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    // Applying a box decoration to the dropdown button form field
                    fillColor: Color.fromRGBO(255, 255, 255,
                        0.05), // Background color with ~5% opacity
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  hint: Text(
                    'Choose a category',
                    style: TextStyle(color: Colors.white),
                  ),
                  value: selectedCategory,
                  onChanged: (newValue) {
                    setState(() {
                      selectedCategory = newValue;
                    });
                  },
                  items: AppConstant.categories
                      .map<DropdownMenuItem<String>>((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child:
                          Text(category, style: TextStyle(color: Colors.white)),
                    );
                  }).toList(),
                  icon: Icon(Icons.keyboard_arrow_down_outlined,
                      color: Colors.white),
                  dropdownColor: Color.fromRGBO(96, 3, 195, 0.7),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _noteController,
                  maxLines: null,
                  maxLength: 200,
                  decoration: InputDecoration(
                    hintText: 'Please input note content',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 14),
                    filled: true,
                    fillColor: Color.fromRGBO(255, 255, 255, 0.05),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  textAlignVertical: TextAlignVertical.top,
                ),
                if(widget.note != null)
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red
                    ),
                  onPressed: () => _deleteNote(context, widget.note!.id as int),
                  child: Text('Delete'),
                  ),
                )
                
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomBarLayout(
          child: BottomActionButton(text: widget.note != null ? 'Update' : 'Save', onPressed: () => _saveNote()),
        ));
  }
}
