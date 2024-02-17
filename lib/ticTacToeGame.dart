class TicTacToeGame {
  List<List<String>> board = [
    ["", "", ""],
    ["", "", ""],
    ["", "", ""]
  ];
  String currentPlayer = "O";
  String winner = "";
  int p1winCount = 0;
  int p2winCount = 0;
  String checkWinnerAndReturnWinner(List<List<String>> board) {
    // Check rows
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == board[i][1] && board[i][1] == board[i][2] && board[i][0].isNotEmpty) {
        return board[i][0];
      }
    }

    // Check columns
    for (int j = 0; j < 3; j++) {
      if (board[0][j] == board[1][j] && board[1][j] == board[2][j] && board[0][j].isNotEmpty) {
        return board[0][j];
      }
    }

    // Check diagonals
    if ((board[0][0] == board[1][1] && board[1][1] == board[2][2] && board[0][0].isNotEmpty) ||
        (board[0][2] == board[1][1] && board[1][1] == board[2][0] && board[0][2].isNotEmpty)) {
      return board[1][1];
    }

    return ""; // No winner
  }


  void checkWinner(int row, int col) {
    if (board[row].every((cell) => cell == currentPlayer)) {
      winner = currentPlayer;
    }
    if (board.every((row) => row[col] == currentPlayer)) {
      winner = currentPlayer;
    }

    // Check diagonals
    if (row == col || row + col == 2) {
      if ((board.every((row) => row[board.indexOf(row)] == currentPlayer)) ||
          (board.every((row) => row[2 - board.indexOf(row)] == currentPlayer))) {
        winner = currentPlayer;
        return;
      }
    }

    // Check for a draw
    if (board.every((row) => row.every((cell) => cell.isNotEmpty))) {
      winner = "Draw";
    }

  }

  void resetGame() {
    winner = "";
    currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
    board = [
      ["", "", ""],
      ["", "", ""],
      ["", "", ""],
    ];
  }
  String getOpponentPlayer() {
    return (currentPlayer == 'X') ? 'O' : 'X';
  }

  bool isBoardFull(List<List<String>> board) {
    return board.every((row) => row.every((cell) => cell.isNotEmpty));
  }

}