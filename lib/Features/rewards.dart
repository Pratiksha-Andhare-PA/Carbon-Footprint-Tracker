import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class DailyStreakRewards extends StatefulWidget {
  @override
  _DailyStreakRewardsState createState() => _DailyStreakRewardsState();
}

class _DailyStreakRewardsState extends State<DailyStreakRewards> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _updateDailyStreak() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      final String formattedDate =
          DateFormat('yyyy-MM-dd').format(DateTime.now());

      final docRef = _firestore
          .collection('DailyStreak')
          .doc(user.email)
          .collection('Dates')
          .doc(formattedDate);

      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        print('Already logged in today.');
      } else {
        final lastDate = userData.data()?['lastLoginDate'];

        if (lastDate != null) {
          final DateTime currentDate = DateTime.parse(formattedDate);
          final DateTime lastLoginDate = DateTime.parse(lastDate);

          if (currentDate.isAfter(lastLoginDate)) {
            int currentStreak = userData.data()?['currentStreak'] ?? 0;
            int maxStreak = userData.data()?['maxStreak'] ?? 0;
            currentStreak++;

            await _firestore.collection('users').doc(user.uid).update({
              'currentStreak': currentStreak,
              'maxStreak': max(currentStreak, maxStreak),
              'lastLoginDate': formattedDate,
            });

            await docRef.set({
              'currentStreak': currentStreak,
              'maxStreak': maxStreak,
            });

            if (currentStreak % 7 == 0) {
              print('Congratulations! You have a week streak!');
            }
          } else {
            await _firestore.collection('users').doc(user.uid).update({
              'currentStreak': 1,
              'lastLoginDate': formattedDate,
            });

            await docRef.set({
              'currentStreak': 1,
              'maxStreak': userData.data()?['maxStreak'] ?? 0,
            });
          }
        } else {
          await _firestore.collection('users').doc(user.uid).update({
            'currentStreak': 1,
            'maxStreak': 1,
            'lastLoginDate': formattedDate,
          });

          await docRef.set({
            'currentStreak': 1,
            'maxStreak': 1,
          });
        }
      }
    } catch (error) {
      print('Error updating daily streak: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Streak Rewards'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/I3.png',
              height: 300,
              width: 400,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _updateDailyStreak,
              child: const Text('Update Daily Streak'),
            ),
            const SizedBox(height: 20),
            FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .get(),
              builder: (context,
                  AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                      snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  Map<String, dynamic>? userData = snapshot.data?.data();

                  if (userData != null) {
                    int currentStreak = userData['currentStreak'] ?? 0;
                    int maxStreak = userData['maxStreak'] ?? 0;

                    return Column(
                      children: [
                        Text(
                          'Current Streak: $currentStreak',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Max Streak: $maxStreak',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Text('User data not available.');
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
