import 'package:flutter/material.dart';

class CustomSnackbar {
  static void show(BuildContext context, String message,
      {Duration duration = const Duration(seconds: 4)}) {
    final snackBar = SnackBar(
      content: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [
              Color(0xFFC724E1),
              Color(0xFF4E22CC),
            ], // gradient colors
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      backgroundColor: Colors.transparent, // Important to keep this transparent
      elevation: 0, // No shadow for a cleaner look
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(10),
      duration: duration,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
