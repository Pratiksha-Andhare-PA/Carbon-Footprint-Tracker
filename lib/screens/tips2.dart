import 'package:flutter/material.dart';

class TipBox extends StatelessWidget {
  final String? number;
  final String text;

  TipBox({this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 128, 211, 139),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(26.0),
      margin: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (number != null)
            Text(
              '$number. $text',
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
          if (number == null)
            Text(
              text,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
        ],
      ),
    );
  }
}
