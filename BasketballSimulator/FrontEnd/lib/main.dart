
import 'package:basketballsimulator/gamepage.dart';
import 'package:basketballsimulator/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BasketballSimulator(),
    );
  }}

class BasketballSimulator extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return initState();
  }
}
void _startGame() async{
  final response = await http.post(
    Uri.parse('http://10.0.2.2:9009/startGame'),
    body: {},
    headers: {}
  );
  if(response.statusCode == 201){
    final ResponseBody = response.body;
  }
  else{
    print('nu merge uai');
  }
}

class initState extends State<BasketballSimulator>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[700],
        title: Text("Basketball Simulator"),
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
                        backgroundColor: MaterialStateColor.resolveWith((states) => Colors.orange.shade800)
                    ),
                    onPressed:(){
                      _startGame();
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const GamePage();
                      }));

                    } ,
                    child: Text(
                      "Start Game",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 33
                      ) ,
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
                        backgroundColor: MaterialStateColor.resolveWith((states) => Colors.orange.shade800)
                    ),
                    onPressed:(){

                    } ,
                    child: Text(
                      "Options",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 35
                      ) ,
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
                        backgroundColor: MaterialStateColor.resolveWith((states) => Colors.orange.shade800)
                    ),
                    onPressed:(){

                    } ,
                    child: Text(
                      "Exit",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 35
                      ) ,
                    )
                ),
              ),
            )
          ],
        ),
      ),
    )
    ;
  }
}



class Match {
  final Team team1;
  final Team team2;
  final Team winner;

  Match({required this.team1, required this.team2, required this.winner});
}