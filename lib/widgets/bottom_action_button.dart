import 'package:flutter/material.dart';

class BottomActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor; // Optional parameter for background color

  BottomActionButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = const Color(0xFFF94695),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, // Text color
            backgroundColor: backgroundColor, // Use the backgroundColor parameter
          minimumSize: Size(220, 40),
          ),
          onPressed: onPressed,
          child: Text(text, style: TextStyle(fontSize: 14),),
        ),
      ),
    );
  }
}
