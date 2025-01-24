import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sub100daysofcode/constants/appColors.dart';

class SnakeGamePage extends StatefulWidget {
  const SnakeGamePage({super.key});

  @override
  State<SnakeGamePage> createState() => _SnakeGamePageState();
}

enum Direction { up, down, left, right }

class _SnakeGamePageState extends State<SnakeGamePage> {
  int row = 25, column = 20;
  List<int> borderList = [];
  List<int> snakePosition = [];
  int snakeHead = 0;
  int score = 11;
  late Direction direction;
  late int foodPosition;
  late Widget currentFoodIcon; // Store the current food icon

  // List of food icons
  List<Widget> foodIcons = [
    const Icon(Icons.fastfood, size: 20, color: Color.fromARGB(255, 96, 58, 2)),
    const Icon(Icons.apple, size: 20, color: Color.fromARGB(255, 243, 20, 4)),
    const Icon(Icons.cake, size: 20, color: Color.fromARGB(255, 234, 5, 230)),
    const Icon(Icons.local_pizza, size: 20, color: Color.fromARGB(255, 74, 67, 4)),
    const Icon(Icons.local_drink, size: 20, color: Colors.blue),
  ];

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    makeBorder();
    generateFood(); // Generate the first food
    direction = Direction.right;
    snakePosition = [45, 44, 43];
    snakeHead = snakePosition.first;
    Timer.periodic(const Duration(milliseconds: 300), (timer) {
      updateSnake();
      if (checkCollision()) {
        timer.cancel();
        showGameOverDialog();
      }
    });
  }

void showGameOverDialog() {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.black.withOpacity(0.8), // Dark background
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Rounded corners
        ),
        title: Column(
          children: [
            Icon(
              Icons.warning_rounded, // Icon to indicate Game Over
              color: Colors.red,
              size: 50,
            ),
            const SizedBox(height: 10),
            const Text(
              "Game Over",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            "Your snake collided!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              startGame();
            },
            child: const Text(
              "Restart",
              style: TextStyle(
                color: Colors.green,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "OK",
              style: TextStyle(
                color: Colors.red,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    },
  );
}


  bool checkCollision() {
    // If snake collides with border or itself
    if (borderList.contains(snakeHead) || snakePosition.sublist(1).contains(snakeHead)) {
      return true;
    }
    return false;
  }

  void generateFood() {
    foodPosition = Random().nextInt(row * column);
    if (borderList.contains(foodPosition) || snakePosition.contains(foodPosition)) {
      generateFood(); // Recurse if food overlaps with snake or border
    } else {
      // Randomly choose a food icon from the list
      setState(() {
        currentFoodIcon = foodIcons[Random().nextInt(foodIcons.length)];
      });
    }
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
        case Direction.right:
          snakePosition.insert(0, snakeHead + 1);
          break;
        case Direction.left:
          snakePosition.insert(0, snakeHead - 1);
          break;
      }
    });

    if (snakeHead == foodPosition) {
      score++;
      generateFood(); // Generate new food when snake eats
    } else {
      snakePosition.removeLast();
    }

    snakeHead = snakePosition.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Expanded(child: _buildGameView()), _buildGameControls()],
      ),
    );
  }

  Widget _buildGameView() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: column),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: fillBoxColor(index),
          ),
          child: foodPosition == index
              ? Center(child: currentFoodIcon) // Show the current food icon at the food position
              : null,
        );
      },
      itemCount: row * column,
    );
  }

  Widget _buildGameControls() {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Your Snack is $score long!"),
          IconButton(
            onPressed: () {
              if (direction != Direction.down) direction = Direction.up;
            },
            icon: const Icon(Icons.arrow_circle_up),
            iconSize: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  if (direction != Direction.right) direction = Direction.left;
                },
                icon: const Icon(Icons.arrow_circle_left_outlined),
                iconSize: 50,
              ),
              const SizedBox(width: 80),
              IconButton(
                onPressed: () {
                  if (direction != Direction.left) direction = Direction.right;
                },
                icon: const Icon(Icons.arrow_circle_right_outlined),
                iconSize: 50,
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              if (direction != Direction.up) direction = Direction.down;
            },
            icon: const Icon(Icons.arrow_circle_down_outlined),
            iconSize: 50,
          ),
        ],
      ),
    );
  }

  Color fillBoxColor(int index) {
    if (borderList.contains(index)) {
      return AppColors.black; // Border color
    } else {
      if (snakePosition.contains(index)) {
        return snakeHead == index ? Colors.green : Colors.white.withOpacity(0.9); // Snake body and head
      } else {
        return const Color.fromARGB(255, 38, 38, 38).withOpacity(0.05); // Empty spaces
      }
    }
  }

  void makeBorder() {
    // Adding the borders to the grid
    for (int i = 0; i < column; i++) {
      borderList.add(i);
    }
    for (int i = 0; i < row * column; i += column) {
      borderList.add(i);
    }
    for (int i = column - 1; i < row * column; i += column) {
      borderList.add(i);
    }
    for (int i = (row * column) - column; i < row * column; i++) {
      borderList.add(i);
    }
  }
}
