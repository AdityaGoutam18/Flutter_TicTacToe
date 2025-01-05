import 'package:flutter/material.dart';

class BoardTile extends StatelessWidget {
  final String symbol;
  final VoidCallback onTap;

  const BoardTile({super.key, required this.symbol, required this.onTap, required Color backgroundColor, required Color borderColor, required TextStyle tileStyle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            symbol,
            style: TextStyle(
              fontSize: 40,
              color: symbol == 'X' ? Colors.blue : Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
