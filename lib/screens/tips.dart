import 'package:flutter/material.dart';

class CarbonFootprintTipsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carbon Footprint Tips'),
        backgroundColor: const Color.fromARGB(255, 204, 85, 225),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Here are some tips for reducing your carbon footprint:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TipBox(
                number: '1',
                text:
                    'Reduce your meat consumption: Eating less meat can help reduce greenhouse gas emissions from livestock and the production of animal feed.',
              ),
              TipBox(
                number: '2',
                text:
                    'Use energy-efficient appliances: Switching to energy-efficient appliances can help reduce your electricity usage and carbon footprint.',
              ),
              TipBox(
                number: '3',
                text:
                    'Walk, bike, or take public transportation: Using alternative modes of transportation can help reduce your carbon footprint from driving.',
              ),
              TipBox(
                number: '4',
                text:
                    'Plant trees: Trees absorb carbon dioxide from the atmosphere and can help reduce greenhouse gas emissions.',
              ),
              TipBox(
                number: '5',
                text:
                    'Reduce your plastic usage: Plastics are made from fossil fuels and contribute to greenhouse gas emissions when they are produced and disposed of.',
              ),
              TipBox(
                number: '6',
                text:
                    'Use renewable energy sources: Switching to renewable energy sources like solar or wind power can help reduce your carbon footprint.',
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Remember, every small action counts towards reducing our carbon footprint and protecting the environment for future generations.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
