import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/24.png',
            height: 200.0,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Welcome to EcoTrace! Discover the impact of your lifestyle on the environment. Learn about your carbon footprint and take steps towards a sustainable future',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
