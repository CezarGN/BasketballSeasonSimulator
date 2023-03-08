import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayOffWinnerPage extends StatelessWidget{
  final String winner;

  const PlayOffWinnerPage(this.winner);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Winner'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange[700],
      ),
      backgroundColor: Colors.orange[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Congratulations to the',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            Text(
              winner,
              style: TextStyle(
                fontSize: 36,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'on their victory!',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}