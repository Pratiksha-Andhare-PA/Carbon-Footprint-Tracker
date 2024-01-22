import 'package:flutter/material.dart';
import 'package:temp/Features/calculator.dart';
import 'package:temp/Features/chatbot.dart';
import 'package:temp/Features/leaderboard.dart';
import 'package:temp/screens/tips2.dart';
import 'package:temp/widgets/navigationbar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/bg.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            bottomNavigationBar: CustomBottomNavigationBar(
                currentIndex: 0,
                onTap: (index) {
                  switch (index) {
                    case 0:
                      break;
                    case 1:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CarbonFootprintCalculator(),
                        ),
                      );
                      break;
                    case 2:
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Board()),
                      );
                      break;
                    case 3:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Chatbot()),
                      );
                      break;
                  }
                }),
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(242, 1, 10, 129),
              title: const Text(
                'ECOTRACE',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Color.fromARGB(255, 239, 239, 243),
                  fontFamily: 'Kalam',
                ),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/home.png'),
                    const SizedBox(height: 10),
                    TipBox(
                      text:
                          'Reduce your meat consumption: Eating less meat can help reduce greenhouse gas emissions from livestock and the production of animal feed.',
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
