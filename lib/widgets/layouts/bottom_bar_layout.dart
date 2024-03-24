import 'package:flutter/material.dart';

class BottomBarLayout extends StatelessWidget {
  final Widget child;

  BottomBarLayout({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [
            Color(0xFF1B284F),
            Color(0xFF351159),
            Color(0xFF421C45),
            Color(0xFF3B184E),
          ], // gradient colors
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1C0B37), Color(0xFF1D0B37)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: child,
      ),
    );
  }
}
