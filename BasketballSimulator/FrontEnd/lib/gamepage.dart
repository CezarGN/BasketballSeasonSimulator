import 'package:basketballsimulator/gameresultpage.dart';
import 'package:basketballsimulator/main.dart';
import 'package:basketballsimulator/teamsSeason.dart';
import 'package:basketballsimulator/teamspage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<Team> teams = [];
class GamePage extends StatelessWidget {
  const GamePage({Key? key}) :super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[700],
        title: Text("BasketballSimulator"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(0, 150, 0, 0),
                child: SizedBox(
                  height: 65,
                  width: 200,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith((
                              states) => Colors.orange.shade800)
                      ),
                      onPressed: () {
                        _playGame();
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) {
                          return GameResultPage();
                        }));
                      },
                      child: Text(
                        "Play Game",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30
                        ),
                      )
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(0, 45, 0, 0),
                child: SizedBox(
                  height: 65,
                  width: 200,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith((
                              states) => Colors.orange.shade800)
                      ),
                      onPressed: () {
                        _playSeason();
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) {
                          return TeamsSeasonPage();
                        }));
                      },
                      child: Text(
                        "Play Season",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30
                        ),
                      )
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(0, 45, 0, 0),
                child: SizedBox(
                  height: 65,
                  width: 200,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith((
                              states) => Colors.orange.shade800)
                      ),
                      onPressed: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) {
                          return TeamsPage();
                        }));
                      },
                      child: Text(
                        "Teams",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 35,
                        ),
                      )
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(0, 45, 0, 0),
                child: SizedBox(
                  height: 65,
                  width: 200,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith((
                              states) => Colors.orange.shade800)
                      ),
                      onPressed: () {
                        // Navigator.push(
                        //     context, MaterialPageRoute(builder: (context) {
                        //   return MatchesPage();
                        // }));

                      },
                      child: Text(
                        "Games Played",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25
                        ),
                      )
                  ),
                ),
              )
            ]

        ),
      ),
    );
  }
}

class Team {
  final String name;
  final int wins;
  final int losses;

  Team(this.name, this.wins, this.losses);
}



Future _playGame() async {
  final response = await http.post(
      Uri.parse('http://10.0.2.2:9009/playGame'),
      body: {},
      headers: {}
  );
  if (response.statusCode == 201) {
    final ResponseBody = response.body;
  }
  else {
    print('nu merge uai');
  }
}

  Future _playSeason() async {
    final response = await http.post(
        Uri.parse('http://10.0.2.2:9009/playSeason'),
        body: {},
        headers: {}
    );
    if (response.statusCode == 201) {
      final ResponseBody = response.body;
    }
    else {
      print('nu merge uai');
    }
  }

