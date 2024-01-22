import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:temp/screens/chart.dart';

class VisualizationPage extends StatefulWidget {
  const VisualizationPage({super.key});

  @override
  State<VisualizationPage> createState() => _VisualizationPageState();
}

class _VisualizationPageState extends State<VisualizationPage> {
  late Future<List<Map<String, int>>> _listOfScores;

  Future<List<Map<String, int>>> fetchScoresForUser(String userEmail) async {
    List<Map<String, int>> scoresList = [];

    try {
      await FirebaseFirestore.instance
          .collection('DailyData')
          .get()
          .then((value) {});

      for (int i = 0; i <= 2; i++) {
        await FirebaseFirestore.instance
            .collection('DailyData')
            .doc("date_" +
                DateFormat('yyyy-MM-dd')
                    .format(DateTime.now().subtract(Duration(days: i))))
            .collection(userEmail)
            .get()
            .then((value) {
          if (value == null) {
            scoresList.add({
              "${DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: i)))}":
                  0
            });
          }
        });
      }

      CollectionReference dailyDataCollection =
          FirebaseFirestore.instance.collection('DailyData');

      QuerySnapshot dailyDataQuery = await dailyDataCollection.get();

      print("printeddd" + dailyDataQuery.docs.length.toString());

      for (QueryDocumentSnapshot dailyDataDoc in dailyDataQuery.docs.reversed) {
        if (scoresList.length >= 7) break;
        String date = dailyDataDoc.id;

        CollectionReference usersCollection =
            dailyDataCollection.doc(date).collection('Users');

        DocumentSnapshot userDoc =
            await usersCollection.doc(userEmail).get().then((value) {
          print("okkk" + value.exists.toString());
          if (value.exists) {
            Map<String, dynamic>? data = value.data() as Map<String, dynamic>?;
            if (data != null && data.containsKey('score')) {
              print("Data " +
                  data['score'].toString() +
                  data['score'].runtimeType.toString());

              scoresList.add({"${date.substring(5)}": data['score']});
            }
          }
          return value;
        });
      }

      return scoresList.reversed.toList();
    } catch (e) {
      print("error Occured : " + e.toString());
      return scoresList;
    }
  }

  @override
  void initState() {
    _listOfScores =
        fetchScoresForUser(FirebaseAuth.instance.currentUser!.email.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text("Visualization")),
      body: Container(
        decoration: BoxDecoration(color: Colors.lightBlue.shade50),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              " Visualisation Graph",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            FutureBuilder<List<Map<String, int>>>(
                future: _listOfScores,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    print(snapshot.data);
                    return Container(
                      height: h * 0.5,
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                      child: ChartWidget(snapshot.data ?? []),
                    );
                  }
                  return const Center(
                    child: Text("Error Occured!"),
                  );
                }),
            const Text("bottom text"),
          ],
        ),
      ),
    );
  }
}
