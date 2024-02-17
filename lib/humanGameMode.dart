

import 'package:tictactoe/ticTacToeGame.dart';
import 'package:tictactoe/gameMode.dart';
import 'package:flutter/material.dart';
class HumanGameMode extends  GameMode {

  @override
  void handleMove(int row, int col) {
    if (game.board[row][col].isEmpty && game.winner.isEmpty ) {
      game.board[row][col] = game.currentPlayer;
      game.checkWinner(row, col);

    }
    if(game.winner.isEmpty){
      game.currentPlayer = (game.currentPlayer == "X") ? "O" : "X";
    }

  }

  @override
  Future<void> makeAIMove() async {
    // TODO: implement makeAIMove
  }

  @override
  void registerAiMove() {
    // TODO: implement registerAiMove
  }



}
