import 'dart:math';

class TicTacToeLogic {
  List<String> board = List.filled(9, '');
  String currentPlayer = 'X';
  int playerScore = 0;
  int aiScore = 0;
  void resetGame() {
    board = List.filled(9, ''); // Reset the board to empty
  }

  void resetScores() {
    playerScore = 0; // Reset player score to 0
    aiScore = 0; // Reset AI score to 0
  }

  bool isGameOver() {
    // Check rows
    for (int i = 0; i < 9; i += 3) {
      if (board[i] != '' &&
          board[i] == board[i + 1] &&
          board[i] == board[i + 2]) {
        return true;
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (board[i] != '' &&
          board[i] == board[i + 3] &&
          board[i] == board[i + 6]) {
        return true;
      }
    }

    // Check diagonals
    if (board[0] != '' && board[0] == board[4] && board[0] == board[8]) {
      return true;
    }
    if (board[2] != '' && board[2] == board[4] && board[2] == board[6]) {
      return true;
    }

    // No winner
    return false;
  }

  bool isDraw() {
    return !board.contains('') && !isGameOver();
  }

  void resetScore() {
    board = List.filled(9, '');
    currentPlayer = 'X';
  }

  void restartGame() {
    resetGame();
    playerScore = 0;
    aiScore = 0;
  }

  void makeMove(int index) {
    if (board[index] == '') {
      board[index] = currentPlayer;
      currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
    }
  }

  int getAiMove() {
    int bestScore = -1000;
    int bestMove = -1;

    for (int i = 0; i < board.length; i++) {
      if (board[i] == '') {
        board[i] = 'O';
        int score = minimax(false);
        board[i] = '';

        if (score > bestScore) {
          bestScore = score;
          bestMove = i;
        }
      }
    }
    return bestMove;
  }

  int minimax(bool isMaximizing) {
    if (isGameOver()) {
      return isMaximizing ? -10 : 10;
    }
    if (isDraw()) {
      return 0;
    }

    if (isMaximizing) {
      int bestScore = -1000;
      for (int i = 0; i < board.length; i++) {
        if (board[i] == '') {
          board[i] = 'O';
          bestScore = max(bestScore, minimax(false));
          board[i] = '';
        }
      }
      return bestScore;
    } else {
      int bestScore = 1000;
      for (int i = 0; i < board.length; i++) {
        if (board[i] == '') {
          board[i] = 'X';
          bestScore = min(bestScore, minimax(true));
          board[i] = '';
        }
      }
      return bestScore;
    }
  }
}
