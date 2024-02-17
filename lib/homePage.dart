import 'package:flutter/material.dart';
import 'package:tictactoe/AudioManager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});


  @override
  State<HomePage> createState() => _GameModeState();
}

class _GameModeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.brown,

      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tic - Tac - Toe',
              style: TextStyle(
                fontFamily: 'Soul_Calibur',
                color: Colors.black,
                fontSize: 70
              ),


            ),
            Image.asset(
              'assets/giphy.gif',
              height: 400,
              width: 400,
            ),



            SizedBox(
              width: 250,
              height: 80,
              child: ElevatedButton(
                onPressed: () async {
                 await AudioManager.clickSound();
                  Navigator.pushNamed(context, '/gameMode');
                },
                child: Text(
                  "Play Game",
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

          ],
        ),
      ),
    );
  }
}
