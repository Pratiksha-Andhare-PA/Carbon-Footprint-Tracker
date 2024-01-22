import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  CustomBottomNavigationBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: const Color.fromARGB(255, 2, 188, 201),
      color: const Color.fromARGB(255, 2, 188, 201),
      animationDuration: const Duration(milliseconds: 300),
      index: currentIndex,
      items: const [
        Icon(Icons.home, color: Colors.black),
        Icon(Icons.calculate, color: Colors.black),
        Icon(Icons.leaderboard, color: Colors.black),
        Icon(Icons.chat, color: Colors.black),
      ],
      onTap: onTap,
    );
  }
}
