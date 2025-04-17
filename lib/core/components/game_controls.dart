import 'package:flutter/material.dart';

import '../../screen/home.dart';

enum Direction { up, down, left, right }

class GameControls extends StatelessWidget {
  final double screenWidth;
  final int score;
  final Direction direction;
  final void Function(Direction) onDirectionChanged;
  const GameControls({required this.screenWidth, required this.score, required this.direction, required this.onDirectionChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Score: $score"),
          IconButton(
            onPressed: () {
              if (direction != Direction.down) {
                onDirectionChanged(Direction.up);
              }
            },
            icon: Icon(Icons.arrow_circle_up_outlined),
            iconSize: screenWidth * 0.18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  if (direction != Direction.right) {
                    onDirectionChanged(Direction.left);
                  }
                },
                icon: Icon(Icons.arrow_circle_left_outlined),
                iconSize: screenWidth * 0.18,
              ),
              SizedBox(width: screenWidth * 0.1),
              IconButton(
                onPressed: () {
                  if (direction != Direction.left) {
                    onDirectionChanged(Direction.right);
                  }
                },
                icon: Icon(Icons.arrow_circle_right_outlined),
                iconSize: screenWidth * 0.18,
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              if (direction != Direction.up) {
                onDirectionChanged(Direction.down);
              }
            },
            icon: Icon(Icons.arrow_circle_down_outlined),
            iconSize: screenWidth * 0.18,
          ),
        ],
      ),
    );
  }
}

