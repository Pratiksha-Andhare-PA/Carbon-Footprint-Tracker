import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/242.png',
            height: 150.0,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Understanding Carbon: Explore how daily activities contribute to carbon generation. From transportation to energy consumption, EcoTrace helps you make informed choices for a cleaner planet',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
