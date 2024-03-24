import 'package:flutter/material.dart';

class AppBarLayout extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions; // Optional actions list

  AppBarLayout({
    Key? key,
    required this.title,
    this.actions, // Accept actions as a parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF1C0B37),
            Color(0xFF1D0B37)
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: AppBar(
        backgroundColor: Colors.transparent, // Makes the AppBar's Material widget transparent
        elevation: 0, // Removes shadow
        iconTheme: IconThemeData(color: Colors.white), // Makes back button and other icons white
        title: Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        actions: actions, // Add actions here
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80);
}
