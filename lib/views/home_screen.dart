import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notes_flutter/constants/app_constant.dart';
import 'package:notes_flutter/views/note_screen.dart';
import 'package:notes_flutter/views/setting_screen.dart';
import 'package:notes_flutter/widgets/layouts/body_layout.dart';
import 'package:notes_flutter/widgets/layouts/app_bar_layout.dart';
import 'package:notes_flutter/widgets/main_bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, String> categoryIcons = {
      'Work and study': 'assets/icons/work_and_study_icon.png',
      'Life': 'assets/icons/life_icon.png',
      'Health and wellness': 'assets/icons/health_and_wellness_icon.png',
    };

    final notesProvider = Provider.of<NoteProvider>(context);

    return Scaffold(
        appBar: AppBarLayout(
          title: "Home",
          actions: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SettingScreen()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Image.asset(
                  'assets/icons/setting_icon.png',
                  width: 24,
                  height: 24,
                  color: Color(0xFFC724E1),
                ),
              ),
            )
          ],
        ),
        body: BodyLayout(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 14),
              child: Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: Colors.white54,
                  ),
                  SizedBox(width: 10.0), // Space between the icon and text
                  Text(
                    "Recently created notes",
                    style: TextStyle(fontSize: 20, color: Colors.white54),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: AppConstant.categories.length,
                itemBuilder: (context, index) {
                  final category = AppConstant.categories[index];
                  final categoryNotes = notesProvider.notes
                      .where((note) => note.category == category)
                      .toList()
                    ..sort((a, b) => b.createdTime.compareTo(a.createdTime));

                  final notesToShow = categoryNotes.take(3).toList();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                  colors: [
                                    Color(0xFFC724E1),
                                    Color(0xFF4E22CC),
                                  ], // use for gradient color
                                  tileMode: TileMode.mirror,
                                ).createShader(bounds);
                              },
                              blendMode: BlendMode.srcIn,
                              child: Image.asset(
                                categoryIcons[category]!,
                                width: 24,
                                height: 24,
                              ),
                            ),
                            SizedBox(width: 12.0),
                            Text(
                              category,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      ...notesToShow
                          .map((note) => Card(
                                color: Colors.transparent,
                                child: Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 255, 255, 0.09),
                                    border: Border.all(
                                        color: Color.fromRGBO(
                                            255, 255, 255, 0.05)),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: ListTile(
                                    title: Text(note.description,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16)),
                                    trailing: IconButton(
                                      icon: Icon(Icons.arrow_forward_ios,
                                          color: Theme.of(context).primaryColor,
                                          size: 18),
                                      onPressed: () {
                                        print(
                                            "Navigating with note: ${note.id}, ${note.description}");

                                        // Navigate to NoteScreen with the selected note data
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                NoteScreen(note: note),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                      if (notesToShow.isEmpty)
                        Card(
                          color: Colors.transparent,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.05),
                              border: Border.all(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              title: Center(
                                child: Text('Empty notes',
                                    style: TextStyle(
                                        color: Colors.white54, fontSize: 16)),
                              ),
                            ),
                          ),
                        )
                    ],
                  );
                },
              ),
            ),
          ]),
        ),
        bottomNavigationBar: MainBottomNavBar(selectedIndex: 0));
  }
}
