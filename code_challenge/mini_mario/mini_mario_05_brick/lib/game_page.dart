import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mini_mario/brick.dart';
import 'package:mini_mario/mario.dart';
import 'package:mini_mario/mushroom.dart';
import 'package:mini_mario/my_button.dart';

enum Direction { left, right }

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static double marioX = 0;
  static double marioY = 1;
  double mushroomX = randomNegativeOrPositve();
  double mushroomY = 1;
  double brickX = -0.5;
  static double brickY = 0.5;
  double brickAboveY = brickY - 0.3;
  double time = 0;
  double height = 0;
  double initialHeight = marioY;
  Direction direction = Direction.right;
  bool isJumping = false;
  bool isIdle = true;
  bool isRunning = false;
  bool isBigMario = false;
  bool isMarioAboveBrick = false;
  Timer? runningTimer;

  void checkEatMushRoom() {
    if ((marioX - mushroomX).abs() < 0.05 &&
        (marioY - mushroomY).abs() < 0.05) {
      setState(() {
        mushroomX = 2;
        isBigMario = true;
      });
    }
  }

  bool checkTouchBrick(double newMarioX, double newMarioY) {
    return ((newMarioX - brickX).abs() < 0.05 &&
        (newMarioY - brickY).abs() < 0.05);
  }

  void checkLeaveBrick(double newMarioX, double newMarioY) {
    if (isMarioAboveBrick && !((newMarioX - brickX).abs() < 0.05)) {
      setState(() {
        isMarioAboveBrick = false;
        marioY = 1;
      });
    }
  }

  static double randomNegativeOrPositve() {
    double upper = 1;
    double lower = -1;
    double r = Random().nextDouble();
    double result = r * (upper - lower) + lower;
    return result;
  }

  void jump() {
    if (isJumping) {
      return;
    }
    isJumping = true;
    time = 0;
    initialHeight = marioY;
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 5 * time;
      if ((checkTouchBrick(marioX, initialHeight - height) &&
          initialHeight - height <= brickY)) {
        setState(() {
          isJumping = false;
          marioY = brickAboveY;
          isMarioAboveBrick = true;
        });
        timer.cancel();
        return;
      }
      if (initialHeight - height > 1) {
        setState(() {
          isJumping = false;
          marioY = 1;
        });
        checkEatMushRoom();
        timer.cancel();
      } else {
        setState(() {
          final newMarioY = initialHeight - height;
          if (!checkTouchBrick(marioX, newMarioY)) {
            marioY = newMarioY;
          } else {
            isJumping = false;
            marioY = 1;
            timer.cancel();
          }
        });
      }
    });
  }

  void moveLeft(bool isHoldingTap) {
    // setState(() {
    //   direction = Direction.left;
    //   isRunning = !isRunning;
    //   marioX -= 0.02;
    // });
    if (!isHoldingTap) {
      runningTimer?.cancel();
      setState(() {
        isIdle = true;
      });
    } else {
      if (runningTimer?.isActive ?? false) {
        return;
      }
      isIdle = false;
      direction = Direction.left;
      runningTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
        setState(() {
          isRunning = !isRunning;
          if (!checkTouchBrick(marioX - 0.02, marioY)) {
            marioX -= 0.02;
            checkLeaveBrick(marioX, marioY);
          }
        });
        checkEatMushRoom();
      });
    }
  }

  void moveRight(bool isHoldingTap) {
    // setState(() {
    //   direction = Direction.right;
    //   isRunning = !isRunning;
    //   marioX += 0.02;
    // });

    if (!isHoldingTap) {
      runningTimer?.cancel();
      setState(() {
        isIdle = true;
      });
    } else {
      if (runningTimer?.isActive ?? false) {
        return;
      }
      isIdle = false;
      direction = Direction.right;
      runningTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
        setState(() {
          isRunning = !isRunning;
          if (!checkTouchBrick(marioX + 0.02, marioY)) {
            marioX += 0.02;
            checkLeaveBrick(marioX, marioY);
          }
        });
        checkEatMushRoom();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenH = MediaQuery.of(context).size.height;
    double brickSize = screenH * 0.1;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                Container(
                  color: Colors.blue,
                  child: AnimatedContainer(
                    alignment: Alignment(marioX, marioY),
                    duration: const Duration(milliseconds: 50),
                    child: Mario(
                      direction: direction,
                      isJumping: isJumping,
                      isRunning: isRunning,
                      isIdle: isIdle,
                      isBigMario: isBigMario,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment(mushroomX, mushroomY),
                  child: const Mushroom(),
                ),
                Container(
                  alignment: Alignment(brickX, brickY),
                  child: Brick(size: brickSize),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          _GameDataText('MARIO'),
                          _GameDataText('0000')
                        ],
                      ),
                      Column(
                        children: [
                          _GameDataText('WORLD'),
                          _GameDataText('1-1')
                        ],
                      ),
                      Column(
                        children: [
                          _GameDataText('TIME'),
                          _GameDataText('9999')
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.brown,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyButton(
                    icon: Icons.arrow_back,
                    // onTap: moveLeft,
                    onTap: (isHoldingTap) => moveLeft(isHoldingTap),
                  ),
                  const SizedBox(width: 8),
                  MyButton(
                    icon: Icons.arrow_upward,
                    // onTap: jump,
                    onTap: (_) => jump(),
                  ),
                  const SizedBox(width: 8),
                  MyButton(
                    icon: Icons.arrow_forward,
                    // onTap: moveRight,
                    onTap: (isHoldingTap) => moveRight(isHoldingTap),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GameDataText extends StatelessWidget {
  const _GameDataText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 22),
    );
  }
}
