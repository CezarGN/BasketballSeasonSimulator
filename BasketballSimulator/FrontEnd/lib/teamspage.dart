import 'package:flutter/material.dart';
import 'package:basketballsimulator/gamepage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
List<Team> teams = [];
class TeamsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Standings'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange[700],
      ),
      body: FutureBuilder(
        future: fetchTeams(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: 18,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Wins')),
                      DataColumn(label: Text('Losses')),
                    ],
                    rows: [
                      DataRow(
                        cells: [
                          DataCell(Text(teams[index].name)),
                          DataCell(Text(teams[index].wins.toString())),
                          DataCell(Text(teams[index].losses.toString())),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
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
      Team obj = Team(
          team["name"], team["wins"], team["loses"]);
      teams.add(obj);
    }
    return teams;
  } else {
    throw Exception('Failed to load teams');
  }
}

