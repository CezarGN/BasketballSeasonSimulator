import 'package:basketballsimulator/playoffBracket.dart';
import 'package:basketballsimulator/teamspage.dart';
import 'package:flutter/material.dart';
import 'package:basketballsimulator/gamepage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<Team> teams = [];
class TeamsSeasonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Regular Season Standings'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange[700],
      ),
      body: FutureBuilder(
        future: fetchTeams(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.only(top:10.0),
                      itemCount: teams.length,
                      itemBuilder: (context, index) {
                        final team = teams[index];
                        return ListTile(
                          title: Text(team.name),
                          subtitle: Text('Wins: ${team.wins} Losses: ${team.losses}'),
                        );
                      },
                ),
                ),
                ElevatedButton(
                    onPressed:() async {
                      Future<String> winner = playPlayoffs();
                      String finalWinner = await winner;
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) {
                        return PlayOffWinnerPage(finalWinner);
                      }));
                    },
                    child: Text("Playoff"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.deepOrange[700]),
                    )
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

Future fetchTeams() async {
  teams.clear();
  String something = 'http://10.0.2.2:9009/findTeams';
  var response = await http.get(
      Uri.parse(something)
  );
  if (response.statusCode == 200) {
    var dataResponse = jsonDecode(response.body);
    for (var team in dataResponse) {
      print(team);
      Team obj = Team(
          team["name"], team["wins"], team["loses"]);
      teams.add(obj);
    }
    return teams;
  } else {
    throw Exception('Failed to load teams');
  }
}

Future<String> playPlayoffs() async{
  String something = 'http://10.0.2.2:9009/playPlayoff';
  var response = await http.post(
      Uri.parse(something),
      headers: {},
    body: {}
  );
  if(response.statusCode == 200){
    var dataResponse = jsonDecode(response.body);
    List<String> winner = dataResponse.toString().split(",");
    List<String> Winner = winner[1].split(":");
    String finalWinner = Winner.elementAt(1);
    return finalWinner;
  } else{
    throw Exception('Failed to play Playoffs');
  }
}