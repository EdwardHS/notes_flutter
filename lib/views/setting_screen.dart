import 'package:flutter/material.dart';
import 'package:notes_flutter/widgets/bottom_action_button.dart';
import 'package:notes_flutter/widgets/custom_alert_dialog.dart';
import 'package:notes_flutter/widgets/custom_snack_bar.dart';
import 'package:notes_flutter/widgets/layouts/app_bar_layout.dart';
import 'package:notes_flutter/widgets/layouts/body_layout.dart';
import 'package:notes_flutter/widgets/layouts/bottom_bar_layout.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/note_provider.dart';

class SettingScreen extends StatelessWidget {
  final List<Map<String, dynamic>> settingButtons = [
    {
      "icon": 'person_outline',
      "title": "Online Customer",
      "url": "https://www.google.com",
    },
    {
      "icon": 'text_snippet_outlined',
      "title": "User Agreement",
      "url": "https://www.google.com",
    },
    {
      "icon": 'security_outlined',
      "title": "Privacy Policy",
      "url": "https://www.google.com",
    },
    {
      "icon": 'info_outline',
      "title": "About Us",
      "url": "https://www.google.com",
    },
  ];

  final Map<String, IconData> iconMap = {
    'person_outline': Icons.person_outline,
    'text_snippet_outlined': Icons.text_snippet_outlined,
    'security_outlined': Icons.security_outlined,
    'info_outline': Icons.info_outline,
  };

  // Function to launch URLs
  void _launchURL(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  // Function to delete all notes
  void _deleteAllNotes(BuildContext context) {
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: 'Confirm',
          content: 'Are you sure you want to delete all notes?',
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: TextStyle(color: Colors.white),),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await Provider.of<NoteProvider>(context, listen: false)
                    .deleteAllNotes(); // Delete all notes from db

                // show a snackbar
                CustomSnackbar.show(context, 'All notes have been cleared');

              },
              child: Text('Delete', style: TextStyle(color: Colors.white),),
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
          title: 'Settings',
        ),
        body: BodyLayout(
          child: ListView(
            children: settingButtons.map((settingButton) {
              return Card(
                color: Colors.transparent,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(
                        255, 255, 255, 0.09),
                    border:
                        Border.all(color: Color.fromRGBO(255, 255, 255, 0.05)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    leading: Icon(
                      iconMap[settingButton['icon']],
                      color: Color(0xFFC724E1),
                    ),
                    title: Text(settingButton['title'],
                        style: TextStyle(color: Colors.white, fontSize: 14)),
                    trailing: Icon(Icons.arrow_forward_ios,
                        color: Theme.of(context).primaryColor, size: 18),
                    onTap: () => _launchURL(Uri.parse(settingButton['url'])),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        bottomNavigationBar: BottomBarLayout(
          child: BottomActionButton(
              text: 'Delete All Notes',
              onPressed: () => _deleteAllNotes(context)),
        ));
  }
}
