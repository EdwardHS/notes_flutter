import 'package:flutter/material.dart';
import 'package:notes_flutter/views/category_detail_screen.dart';
import 'package:notes_flutter/widgets/layouts/body_layout.dart';
import 'package:provider/provider.dart';
import '../constants/app_constant.dart';
import '../providers/note_provider.dart';
import '../widgets/main_bottom_nav_bar.dart';

class SummaryScreen extends StatelessWidget {
  SummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);
    final categoryCounts = noteProvider.getCategoryCounts();

    return Scaffold(
      body: BodyLayout(
        child: Stack(
          children: [
            Positioned(
              right: -70,
              top:
                  -140, // Adjust this value to control how much of the circle is visible
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF240D38),
                      Color(0xFF1B284F),
                      Color(0xFF351159),
                      Color(0xFF713294).withOpacity(0.1),
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
              ),
            ),
            Column(children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 4.0, right: 4.0, top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Summary',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Image.asset(
                      'assets/icons/robot.png',
                      width: 120,
                      height: 120,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: AppConstant.categories.length,
                  itemBuilder: (context, index) {
                    String category = AppConstant.categories[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 28.0),
                      child: SummaryCategoryCard(
                        categoryName: category,
                        noteCount: categoryCounts[category] ?? 0,
                      ),
                    );
                  },
                ),
              ),
            ]),
          ],
        ),
      ),
      bottomNavigationBar: MainBottomNavBar(selectedIndex: 2),
    );
  }
}

class SummaryCategoryCard extends StatelessWidget {
  final String categoryName;
  final int noteCount;

  const SummaryCategoryCard({
    Key? key,
    required this.categoryName,
    required this.noteCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, String> categoryIcons = {
      'Work and study': 'assets/icons/work_and_study_summary_icon.png',
      'Life': 'assets/icons/life_summary_icon.png',
      'Health and wellness':
          'assets/icons/health_and_wellness_summary_icon.png',
    };

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(categoryIcons[categoryName]!),
                  radius: 28,
                ),
                SizedBox(width: 8.0),
                Text(categoryName,
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        CategoryDetailScreen(categoryName: categoryName),
                  ),
                );
              },
              child: Text(
                'Detail',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Card(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.09),
              border: Border.all(color: Color.fromRGBO(255, 255, 255, 0.05)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              title: Text('This topic has a total of $noteCount records.',
                  style: TextStyle(color: Colors.white54, fontSize: 16)),
            ),
          ),
        ),
      ],
    );
  }
}
