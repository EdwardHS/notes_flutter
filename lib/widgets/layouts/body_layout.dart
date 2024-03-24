import 'package:flutter/material.dart';

class BodyLayout extends StatelessWidget {
  final Widget child;

  const BodyLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1B284F), Color(0xFF351159), Color(0xFF421C45), Color(0xFF3B184E),], // gradient colors
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Important for transparency
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: child,
        ),
      ),
    );
  }
}
