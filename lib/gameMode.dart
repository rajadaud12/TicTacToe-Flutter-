import 'package:tictactoe/ticTacToeGame.dart';

abstract class GameMode {
  TicTacToeGame game =TicTacToeGame();

  void handleMove(int row, int col) ;
  void makeAIMove() ;
  void registerAiMove();


  }