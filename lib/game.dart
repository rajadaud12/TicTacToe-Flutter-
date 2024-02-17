import 'dart:math';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/computerGameMode.dart';
import 'package:tictactoe/gameMode.dart';
import 'package:tictactoe/ticTacToeGame.dart';
import 'package:tictactoe/gameCell.dart';
import 'package:tictactoe/AudioManager.dart';

import 'humanGameMode.dart';
class HumanGame extends StatefulWidget {
  const HumanGame({super.key});

  @override
  State<HumanGame> createState() => _GameState();
}

class _GameState extends State<HumanGame> {
  bool gestureActive = true;
  Map data={};
  Random random = Random();
  GameMode gameMode=ComputerGameMode();
  bool coolDown=true;
  bool alert=false;
  bool isMuted = false;
  late bool toss=false;



  @override
  Widget build(BuildContext context) {
    data=ModalRoute.of(context)!.settings.arguments as Map;
    toss=(toss==true)?toss:data['wonToss'];
    print(toss);
    bool ai=data['ai'];
    gameMode=(ai==false && !(gameMode is HumanGameMode))?HumanGameMode():gameMode;

    if (!toss && ai) {
      Future.delayed(const Duration(milliseconds: 300), () {
        gameMode.game.currentPlayer='X';
        gameMode.makeAIMove();
        toss=true;
        setState(() {
          gameMode.registerAiMove();
        });
      });



    }


    return WillPopScope(
      onWillPop: () async {
        if(ai){
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }
        else{
          Navigator.of(context).pop();

        }
        return false;
      },
      child: Scaffold(

        backgroundColor: Colors.brown[300],
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Colors.brown,
          title: const Text('Tick - Tac - Toe',
          style: TextStyle(
              color: Colors.white,
            fontFamily: 'Soul_Calibur',
            fontSize: 40
          ),),
          centerTitle: true,
          actions: [
            // Mute IconButton
            IconButton(
              icon: Icon(
                isMuted ? Icons.volume_off : Icons.volume_up,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  isMuted = !isMuted;
                  AudioManager.setMute(isMuted);
                });
              },
            ),
          ],
        ),
        body:Column(
          children: [

            const SizedBox(height: 10),
            Text('Wins',
              style: TextStyle(
                  color: Colors.brown,
                  fontSize: 20
              ),

            ),
            Text('${gameMode.game.p1winCount}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30
              ),

            ),
            Text('Player 2',
              style: TextStyle(
                  color: gameMode.game.currentPlayer=='O'?Colors.purple:Colors.grey[300],
                  fontSize: 50,
                  fontFamily: 'Soul_Calibur'
              ),
            ),
            SizedBox(width: 40),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,

                  ),
                  itemBuilder: (context, index) {
                    int row = index ~/ 3;
                    int col = index % 3;
                    return GestureDetector(
                      // Inside the GestureDetector onTap method
                      onTap: () async {
                        await AudioManager.clickSound();
                        if(gameMode.game.currentPlayer=='O' || !ai){
                          setState(() {
                            if(gameMode.game.board[row][col].isEmpty){
                              gameMode.handleMove(row, col);
                              coolDown=false;
                            }
                            if (gameMode.game.winner.isNotEmpty ) {
                              alertMessage(ai);
                              alert=true;
                              gameMode.game.currentPlayer = (gameMode.game.currentPlayer == "X") ? "O" : "X";


                            }

                          });
                        }

                        if(coolDown==false && ai==true && gameMode.game.currentPlayer=='X'){
                          coolDown=true;
                          await Future.delayed(const Duration(milliseconds: 300), () {
                            gameMode.makeAIMove();
                          });
                          setState(() {
                            gameMode.registerAiMove();
                          });

                        }
                        if (gameMode.game.winner.isNotEmpty && alert==false ) {
                          alertMessage(ai);

                        }



                      },

                      child: GameCell(value: gameMode.game.board[row][col]),
                    );

                  },

                  itemCount: 9,
                ),
              ),
            ),
            Text('Player 1',
              style: TextStyle(
                color: gameMode.game.currentPlayer=='X'?Colors.purple:Colors.grey[300],
                fontSize: 50,
                fontFamily: 'Soul_Calibur'
              ),
            ),
              SizedBox(width: 40),
              Text('Wins',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 20
                ),

              ),
              Text('${gameMode.game.p2winCount}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30
                ),

              ),
            const SizedBox(height: 30),
          ],
        )
      ),
    );



  }


  Future<void> alertMessage(bool ai) async {
     await AudioManager.coinSound();
    if(gameMode.game.winner == 'X'){
      gameMode.game.p1winCount++;
    } else if (gameMode.game.winner == 'O') {
      gameMode.game.p2winCount++;
    }
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text((gameMode.game.winner!='Draw')?'Winner is ${gameMode.game.winner}':'Game is Draw'),
          content: const Text('If you want to play again, press restart'),
          actions: [
            TextButton(
              onPressed: () async {
                await AudioManager.clickSound();
                Navigator.of(context).pop();
                if(ai){
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
                else{
                  Navigator.pop(context);
                }

              },
              child: const Text('Home Screen'),
            ),
            TextButton(
              onPressed: () async {
                await AudioManager.clickSound();
                setState(()  {
                  alert=false;
                  toss=false;
                  gameMode.game.resetGame();
                });
                Navigator.of(context).pop();
              },
              child: const Text('Restart'),
            )
          ],
        );
      },
    );
  }



}
