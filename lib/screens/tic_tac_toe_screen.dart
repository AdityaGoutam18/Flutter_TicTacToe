import 'package:flutter/material.dart';
import '../models/game_logic.dart';
import '../widgets/board_tile.dart';
import '../widgets/scoreboard.dart';

class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({super.key});

  @override
  State<TicTacToeScreen> createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  final TicTacToeLogic _gameLogic = TicTacToeLogic();
  String _status = "Player X's Turn";

  void _handleTap(int index) {
    if (!_gameLogic.isGameOver() && !_gameLogic.isDraw() && _gameLogic.board[index] == '') {
      setState(() {
        _gameLogic.makeMove(index);

        if (_gameLogic.isGameOver()) {
          _status = "Player X Wins!";
          _gameLogic.playerScore++;
        } else if (_gameLogic.isDraw()) {
          _status = "It's a Draw!";
        } else {
          int aiMove = _gameLogic.getAiMove();
          _gameLogic.makeMove(aiMove);

          if (_gameLogic.isGameOver()) {
            _status = "AI Wins!";
            _gameLogic.aiScore++;
          } else if (_gameLogic.isDraw()) {
            _status = "It's a Draw!";
          } else {
            _status = "Player X's Turn";
          }
        }
      });
    }
  }

  // Reset the game and set the scores to zero
  void _resetGame() {
    setState(() {
      _gameLogic.resetGame();   // Reset the board
      _gameLogic.resetScores(); // Reset scores to zero
      _status = "Player X's Turn";  // Set status to initial
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Scoreboard
            ScoreBoard(
              playerScore: _gameLogic.playerScore,
              aiScore: _gameLogic.aiScore,
              textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            // Status Text
            Text(
              _status,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            // Game Board
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
              ),
              itemCount: 9,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return BoardTile(
                  symbol: _gameLogic.board[index],
                  onTap: () => _handleTap(index),
                  tileStyle: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  backgroundColor: Colors.grey.shade200,
                  borderColor: Colors.grey.shade400,
                );
              },
            ),
            const SizedBox(height: 20),
            // Reset Button
            TextButton(
              onPressed: _resetGame,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                backgroundColor: Colors.grey.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Reset Game',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
