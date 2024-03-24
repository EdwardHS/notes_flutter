import 'package:flutter/material.dart';
import 'package:notes_flutter/views/note_screen.dart';
import 'package:notes_flutter/views/home_screen.dart';
import 'package:notes_flutter/views/summary_screen.dart';
import 'package:notes_flutter/widgets/layouts/bottom_bar_layout.dart';

class MainBottomNavBar extends StatelessWidget {
  final int selectedIndex;

  MainBottomNavBar({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define the icons for each state.
    final icons = [
      selectedIndex == 0
          ? 'assets/icons/home_selected_icon.png'
          : 'assets/icons/home_default_icon.png',
      'assets/icons/add_icon.png', // Assuming the create icon remains constant
      selectedIndex == 2
          ? 'assets/icons/summary_selected_icon.png'
          : 'assets/icons/summary_default_icon.png',
    ];

    return BottomBarLayout(
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        items: List.generate(icons.length, (index) {
          String label;
          switch (index) {
            case 0:
              label = 'Home';
              break;
            case 1:
              label = 'Create';
              break;
            case 2:
              label = 'Summary';
              break;
            default:
              label = '';
          }
          return BottomNavigationBarItem(
            icon: Image.asset(
              icons[index],
              width: 40,
              height: 40,
            ),
            label: label,
          );
        }),
        currentIndex: selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: (index) {
          if (index == selectedIndex) {
            return; // If the current tab is selected, do nothing.
          }

          switch (index) {
            case 0:
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (Route<dynamic> route) => false,
              );
              break;
            case 1:
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => NoteScreen()),
              );
              break;
            case 2:
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => SummaryScreen()),
                (Route<dynamic> route) => false,
              );
              break;
          }
        },
      ),
    );
  }
}
