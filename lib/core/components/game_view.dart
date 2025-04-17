
import 'package:flutter/material.dart';

class GameView extends StatelessWidget {
  final int row;
  final int column;
  final Color Function(int) fillBoxColor;
  const GameView({
    required this.row,
    required this.column,
    required this.fillBoxColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: row * column,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: column,
      ),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(1),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: fillBoxColor(index)),
        );
      },
    );
  }
}

