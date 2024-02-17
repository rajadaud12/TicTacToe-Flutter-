import 'package:flutter/material.dart';
import 'package:tictactoe/AudioManager.dart';

class GameModeSelection extends StatefulWidget {

  @override
  State<GameModeSelection> createState() => _GameModeState();
}

class _GameModeState extends State<GameModeSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.brown[800],
        title: const Text('Tick - Tac - Toe',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Soul_Calibur',
              fontSize: 40
          ),),
        centerTitle: true,
      ),
      backgroundColor: Colors.brown,

      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/giphy.gif',
              height: 400,
              width: 400,
            ),


            SizedBox(
              width: 200,
              height: 60,
              child: ElevatedButton(
                onPressed: (){
                  AudioManager.clickSound();
                  Navigator.pushNamed(context, '/toss');
                },
                child: Text(
                  "Computer",
                  style: TextStyle(
                    fontFamily: 'CombackHome',
                    fontSize: 40
                  ) ,
                ),

                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.brown[800]),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 200,
              height: 60,
              child: ElevatedButton(
                  onPressed: (){
                    AudioManager.clickSound();
                    AudioManager.startSound();
                    Navigator.pushNamed(context, '/human',arguments: {
                      'ai':false,'wonToss':true,
                    });
                  },
                child: const Text(
                  "Human",
                  style: TextStyle(
                    fontFamily: 'CombackHome',
                      fontSize: 40
                  ) ,
                ),

              ),
            )
          ],
        ),
      ),
    );
  }
}
