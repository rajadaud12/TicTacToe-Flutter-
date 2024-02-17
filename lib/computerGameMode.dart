
import 'dart:math';

import 'package:tictactoe/ticTacToeGame.dart';
import 'package:tictactoe/gameMode.dart';
import 'package:flutter/material.dart';

import 'AudioManager.dart';

class ComputerGameMode extends GameMode{
  Random random=Random();
  late int row;
  late int col;

  @override
  void handleMove(int row, int col) {
    if (game.board[row][col].isEmpty && game.winner.isEmpty) {
      game.board[row][col] = game.currentPlayer;
      game.checkWinner(row, col);


    }
    if(game.winner.isEmpty){
      game.currentPlayer = (game.currentPlayer == "X") ? "O" : "X";
    }
  }

  // Inside the _GameState class
  @override
  void makeAIMove() {
    int bestScore = -9999;
    row = -1;
    col = -1;

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (game.board[i][j].isEmpty) {
          game.board[i][j] = game.currentPlayer;
          int score = minimax(game.board, 0, false);
          game.board[i][j] = ""; // Undo the move

          if (score > bestScore) {
            bestScore = score;
            row = i;
            col = j;
          }
        }
      }
    }
  }

  int minimax(List<List<String>> board, int depth, bool isMaximizing) {
    String winner = game.checkWinnerAndReturnWinner(board);

    if (winner == game.currentPlayer) {
      return 1;
    } else if (winner == game.getOpponentPlayer()) {
      return -1;
    } else if (game.isBoardFull(board)) {
      return 0;
    }

    if (isMaximizing) {
      int bestScore = -9999;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (board[i][j].isEmpty) {
            board[i][j] = game.currentPlayer;
            bestScore =
                max(bestScore, minimax(board, depth + 1, !isMaximizing));
            board[i][j] = ""; // Undo the move
          }
        }
      }
      return bestScore;
    } else {
      int bestScore = 9999;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (board[i][j].isEmpty) {
            board[i][j] = game.getOpponentPlayer();
            bestScore =
                min(bestScore, minimax(board, depth + 1, !isMaximizing));
            board[i][j] = ""; // Undo the move
          }
        }
      }
      return bestScore;
    }
  }

  @override
  void registerAiMove() {
    AudioManager.clickSound();
    game.board[row][col] = game.currentPlayer;
    game.checkWinner(row, col);
    if (game.winner.isNotEmpty) {
      game.currentPlayer = (game.currentPlayer == "X") ? "O" : "X";
    }
    game.currentPlayer = (game.currentPlayer == "X") ? "O" : "X";

  }
}