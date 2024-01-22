import 'package:flutter/material.dart';

class IntroPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/241.png',
            height: 150.0,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Empowering Change: EcoTrace provides insights, tips, and tools to reduce your carbon footprint. Join the movement towards a greener world. Start making eco-friendly choices today!',
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
