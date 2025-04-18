import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snake_game/core/utils/app_dialog.dart';

import '../service/service_methods.dart';

enum Direction { up, down, left, right }

class AppController extends ChangeNotifier {
  int row = 20;
  int column = 20;

  List<int> borderList = [];
  List<int> snakePosition = [];

  int snakeHead = 0;
  int score = 0;

  Direction direction = Direction.right;
  int foodPosition = 0;
  Timer? gameTimer;
  bool isGameOver = false;

  AppController() {
    startGame();
  }

  void startGame() {
    isGameOver = false;
    score = 0;
    ServiceMethods.makeBorder(borderList, row, column);
    generateFood();
    direction = Direction.right;
    snakePosition = [45, 44, 43];
    snakeHead = snakePosition.first;

    gameTimer?.cancel();

    gameTimer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      updateSnake();
      if (checkCollision()) {
        gameOver();
        timer.cancel();
      }
      notifyListeners();
    });

    notifyListeners();
  }

  void gameOver() {
    isGameOver = true;
    gameTimer?.cancel();
    notifyListeners();
  }

  void updateSnake() {
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

  void showGameOverDialog(BuildContext context) {
    AppDialog.showMyDialog(
      context: context,
      mainText: "Game Over",
      text: "Your snake collided!",
      pressText: "Restart",
      press: () {
        Navigator.pop(context);
        startGame();
      },
    );
  }

  void changeDirection(Direction newDirection) {
    if ((direction == Direction.up && newDirection == Direction.down) ||
        (direction == Direction.down && newDirection == Direction.up) ||
        (direction == Direction.left && newDirection == Direction.right) ||
        (direction == Direction.right && newDirection == Direction.left)) {
      return;
    }
    direction = newDirection;
    notifyListeners();
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

  @override
  void dispose() {
    gameTimer?.cancel();
    super.dispose();
  }

}
