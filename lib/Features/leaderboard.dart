import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:temp/Features/calculator.dart';
import 'package:temp/Features/chatbot.dart';
import 'package:temp/Features/rewards.dart';
import 'package:temp/widgets/navigationbar.dart';

const Color cool = Color(0xFF181A2F);
Color probtn = const Color.fromARGB(255, 140, 69, 202);
Color leadbtn = const Color.fromARGB(255, 184, 44, 222);
Color gold = const Color(0xFFD0B13E);
Color tealShade1 = const Color.fromARGB(255, 0, 128, 128); // Dark teal
Color tealShade2 = const Color.fromARGB(255, 0, 178, 178); // Teal shade 2
Color tealShade3 = const Color.fromARGB(255, 0, 204, 204); // Teal shade 3

class Board extends StatefulWidget {
  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  late Future<List<BoardTile>> _fetchDataFuture;

  Future<List<BoardTile>> fetchData() async {
    List<BoardTile> list = [];
    await FirebaseFirestore.instance
        .collection('DailyData')
        .doc("date_" +
            DateFormat('yyyy-MM-dd').format(DateTime.now()).toString())
        //.doc(DateFormat('yyyy-MM-dd').format(DateTime.now()))
        .collection('Users')
        .orderBy('totalCarbonFootprint', descending: false)
        .get()
        .then((event) {
      for (int i = 0; i < event.docs.length; i++) {
        list.add(BoardTile(
          email: event.docs[i].id.toString(),
          score: event.docs[i]['totalCarbonFootprint'].toString(),
          usrname: event.docs[i]['username'].toString(),
          pos: i + 1,
        ));
      }
    });
    return list;
  }

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      builder: (context) => CarbonFootprintCalculator()),
                );
                break;
              case 2:
                break;
              case 3:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Chatbot()),
                );
                break;
            }
          }),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: probtn,
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 200.0,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(4.0),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      cool,
                      Color.fromARGB(255, 63, 17, 177),
                    ],
                  ),
                ),
                height: 50,
                child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Rank",
                        style: TextStyle(
                            color: Colors.grey[200],
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Name",
                        style: TextStyle(
                            color: Colors.grey[200],
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Score",
                        style: TextStyle(
                            color: Colors.grey[200],
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[leadbtn.withOpacity(0.5), cool])),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "LEADERBOARD",
                        style: TextStyle(
                            fontSize: 25,
                            letterSpacing: 2,
                            color: Colors.grey[200],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Icon(
                      Icons.emoji_events_rounded,
                      color: gold,
                      size: 70,
                    ),
                  ],
                ),
              ),
            ),
            elevation: 9.0,
          ),
          FutureBuilder<List<BoardTile>>(
            future: _fetchDataFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasError) {
                return SliverToBoxAdapter(
                  child: Text('Error loading data' + snapshot.error.toString()),
                );
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext ctxx, int index) {
                      return poscardd(boardTile: snapshot.data![index]);
                    },
                    childCount: snapshot.data!.length,
                  ),
                );
              } else {
                return const SliverToBoxAdapter(
                  child: Text('No data available'),
                );
              }
            },
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DailyStreakRewards(),
                    ),
                  );
                },
                child: const Text('View Rewards'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class poscardd extends StatelessWidget {
  poscardd({
    required this.boardTile,
  });

  BoardTile boardTile;

  double height = 70;
  Color cardColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    // Determine card color based on position
    if (boardTile.pos == 1) {
      cardColor = tealShade1;
    } else if (boardTile.pos == 2) {
      cardColor = tealShade2;
    } else if (boardTile.pos == 3) {
      cardColor = tealShade3;
    }

    String rewardIcon = '';
    if (boardTile.pos == 1) {
      rewardIcon = '🏆';
    } else if (boardTile.pos == 2) {
      rewardIcon = '🥈';
    } else if (boardTile.pos == 3) {
      rewardIcon = '🥉';
    }
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      shadowColor: Colors.grey[200],
      color: cardColor,
      child: Container(
        height: height,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              '${boardTile.pos} $rewardIcon',
              style: cardTextstyles(),
            ),
            Text(
              boardTile.usrname,
              style: cardTextstyles(),
            ),
            Text(
              boardTile.score,
              style: cardTextstyles(),
            )
          ],
        ),
      ),
    );
  }

  TextStyle cardTextstyles() =>
      const TextStyle(color: Colors.black, fontWeight: FontWeight.bold);
}

class BoardTile {
  String score;
  String usrname;
  String email;
  int pos;

  BoardTile(
      {required this.email,
      required this.score,
      required this.usrname,
      required this.pos});
}
