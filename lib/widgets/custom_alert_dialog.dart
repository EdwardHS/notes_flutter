import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
      content: Text(content, style: TextStyle(fontSize: 16, color: Colors.white),),
      contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
      actions: actions,
    );
  }
}
