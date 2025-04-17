import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snake_game/core/utils/app_dialog.dart';
import 'package:snake_game/service/service_methods.dart';

import '../core/components/game_controls.dart';
import '../core/components/game_view.dart';

class Home extends StatefulWidget {
  static const id = "/home";
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int row = 20;
  int column = 20;

  List<int> borderList = [];
  List<int> snakePosition = [];
  int snakeHead = 0;
  int score = 0;
  late Direction direction;
  late int foodPosition;
  late Timer gameTimer;
  late double screenWidth;
  late double screenHeight;

  @override
  void initState() {
    startGame();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }

  @override
  void dispose() {
    gameTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: GameView(
                row: row,
                column: column,
                fillBoxColor:
                fillBoxColor,
            )
          ),
          GameControls(
              screenWidth: screenWidth,
              score: score,
              direction: direction,
              onDirectionChanged: (newDirection){
                setState(() {
                  direction = newDirection;
                });
              })
        ],
      ),
    );
  }

  void startGame() {
    ServiceMethods.makeBorder(borderList, row, column);
    generateFood();
    direction = Direction.right;
    snakePosition = [45, 44, 43];
    snakeHead = snakePosition.first;
    gameTimer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      updateSnake();
      if (checkCollision()) {
        timer.cancel();
        AppDialog.showMyDialog(
          context: context,
          mainText: "Game Over",
          text: "Your snake collided!",
          pressText: "Restart",
          press: () {
            Navigator.pop(context);
            setState(() {
              score = 0;
            });
            startGame();
          },
        );
      }
    });
  }

  void updateSnake() {
    setState(() {
      switch (direction) {
        case Direction.up:
          snakePosition.insert(0, snakeHead - column);
          break;
        case Direction.down:
          snakePosition.insert(0, snakeHead + column);
          break;
        case Direction.left:
          snakePosition.insert(0, snakeHead - 1);
          break;
        case Direction.right:
          snakePosition.insert(0, snakeHead + 1);
          break;
      }
    });

    if (snakeHead == foodPosition) {
      score++;
      generateFood();
    } else {
      snakePosition.removeLast();
    }
    snakeHead = snakePosition.first;
  }

  void generateFood() {
    foodPosition = Random().nextInt(column * row);
    if (borderList.contains(foodPosition)) {
      generateFood();
    }
  }

  bool checkCollision() {
    // Agar ilon chegaraga tegsa;
    if (borderList.contains(snakeHead)) return true;
    // Agar ilon o'ziga tegsa
    if (snakePosition.sublist(1).contains(snakeHead)) return true;

    return false;
  }

  Color fillBoxColor(int index) {
    if (borderList.contains(index)) {
      return Colors.yellow;
    } else {
      if (snakePosition.contains(index)) {
        if (snakeHead == index) {
          return Colors.green;
        } else {
          return Colors.white;
        }
      } else {
        if (index == foodPosition) {
          return Colors.red;
        }
      }
    }
    return Colors.grey.shade800;
  }

}


