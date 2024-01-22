import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:temp/Features/chatbot.dart';
import 'package:temp/Features/leaderboard.dart';
import 'package:temp/screens/HomeScreen.dart';
import 'package:temp/screens/visuals.dart';
import 'package:flutter/material.dart';
import 'package:temp/widgets/navigationbar.dart';

class CarbonFootprintCalculator extends StatefulWidget {
  @override
  _CarbonFootprintCalculatorState createState() =>
      _CarbonFootprintCalculatorState();
}

class _CarbonFootprintCalculatorState extends State<CarbonFootprintCalculator> {
  double _carMileage = 0;
  double _carUsageTime = 0;
  double _publicTransportUsageTime = 0;
  double _flightsPerYear = 0;
  double _meatConsumption = 0;
  double _plasticUsage = 0;
  double _electricityUsage = 0;

  double _carCarbonFootprint = 0;
  double _publicTransportCarbonFootprint = 0;
  double _flightsCarbonFootprint = 0;
  double _meatCarbonFootprint = 0;
  double _plasticCarbonFootprint = 0;
  double _electricityCarbonFootprint = 0;
  double _totalCarbonFootprint = 0;

  void _calculateCarbonFootprint() async {
    _carCarbonFootprint = _carMileage * _carUsageTime * 0.42;
    _publicTransportCarbonFootprint = _publicTransportUsageTime * 0.09;
    _flightsCarbonFootprint = _flightsPerYear * 0.24;
    _meatCarbonFootprint = _meatConsumption * 2.5;
    _plasticCarbonFootprint = _plasticUsage * 0.11;
    _electricityCarbonFootprint = _electricityUsage * 1.35;

    _totalCarbonFootprint = _carCarbonFootprint +
        _publicTransportCarbonFootprint +
        _flightsCarbonFootprint +
        _meatCarbonFootprint +
        _plasticCarbonFootprint +
        _electricityCarbonFootprint;

    final user = FirebaseAuth.instance.currentUser!;

    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    final String formattedDate =
        DateFormat('yyyy-MM-dd').format(DateTime.now());

    try {
      await FirebaseFirestore.instance
          .collection('DailyData')
          .doc("date_" + formattedDate.toString())
          .collection('Users')
          .doc(user.email)
          .set({
        'username': userData.data()?['username'],
        'totalCarbonFootprint': _totalCarbonFootprint,
        'timestamp': FieldValue.serverTimestamp(),
      });

      if (_totalCarbonFootprint < 10) {
      } else {}
      setState(() {});
    } catch (error) {
      print('Error saving data to Firestore: $error');
      print('Error saving data to Firestore: $error');
    }

    if (_totalCarbonFootprint < 10) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Great job!"),
            content: Text(
                "Your carbon footprint is less than 10 tons of CO2 per year."),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    } else {
      double treesToPlant = (_totalCarbonFootprint - 10) / 0.6;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("You can do better!"),
            content: Text(
                "Your carbon footprint is ${_totalCarbonFootprint.toStringAsFixed(2)} tons of CO2 per year. You should plant ${treesToPlant.toStringAsFixed(0)} trees per year to offset your carbon emissions."),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(brightness: Brightness.dark),
      child: Scaffold(
        backgroundColor: Colors.teal.shade600,
        bottomNavigationBar: CustomBottomNavigationBar(
            currentIndex: 0,
            onTap: (index) {
              switch (index) {
                case 0:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                  break;
                case 1:
                  break;
                case 2:
                  // Navigate to Leaderboard
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Board()),
                  );
                  break;
                case 3:
                  // Navigate to Chatbot
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Chatbot()),
                  );
                  break;
              }
            }),
        appBar: AppBar(
            title: const Text(
              'Calculator',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Kalam',
              ),
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  print("Logout button pressed");
                  await FirebaseAuth.instance.signOut();
                },
                icon: Icon(
                  Icons.exit_to_app,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
            centerTitle: true,
            backgroundColor: const Color.fromARGB(241, 3, 13, 150)),
        body: Stack(
          children: [
            Image.asset(
              'assets/bg.jpg',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Enter your information to calculate your carbon footprint:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Car mileage (kmpl)',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onChanged: (value) {
                        _carMileage = double.tryParse(value) ?? 0;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Car usage time (hours per week)',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onChanged: (value) {
                        _carUsageTime = double.tryParse(value) ?? 0;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText:
                            'Public transport usage time (hours per week)',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onChanged: (value) {
                        _publicTransportUsageTime = double.tryParse(value) ?? 0;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Flights per year',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onChanged: (value) {
                        _flightsPerYear = double.tryParse(value) ?? 0;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Meat consumption (pounds per week)',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onChanged: (value) {
                        _meatConsumption = double.tryParse(value) ?? 0;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Plastic usage (pounds per week)',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onChanged: (value) {
                        _plasticUsage = double.tryParse(value) ?? 0;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText:
                            'Electricity usage (kilowatt-hours per month)',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onChanged: (value) {
                        _electricityUsage = double.tryParse(value) ?? 0;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: _calculateCarbonFootprint,
                      child: const Text('Calculate'),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Your carbon footprint is:',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(242, 1, 10, 129),
                        fontFamily: 'Kalam',
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '${_totalCarbonFootprint.toStringAsFixed(2)} tons of CO2 per year',
                      style: const TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(238, 1, 34, 10),
                        fontFamily: 'Kalam',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VisualizationPage()),
                      ),
                      child: const Text('View'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
