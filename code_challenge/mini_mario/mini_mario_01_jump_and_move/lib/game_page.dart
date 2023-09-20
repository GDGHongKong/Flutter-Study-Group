import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mini_mario/mario.dart';
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
  // TODO(mushroom): define mushroomX, mushrromY. Can use random aligment X
  //  to make the mushroom every time restart evey time different position.

  // TODO(brick): add brickX, brickY, brickAboveY(the top aligment Y of the brick)
  //  tips: our solution is using Aligment X,Y(-1 to 1). If using Aligment X,Y,
  //  the The calculation of comparing brick XY with mario XY and the brick's
  //  top Y of the brick will be quite tricky. Because the XY draing point of
  //  the widget seems to be different according to the widget size.
  //  You may consider using Positioned widget instead, but the XY of mario
  //  mushroom may also need to use Positioned.
  double time = 0;
  double height = 0;
  double initialHeight = marioY;
  Direction direction = Direction.right;
  bool isJumping = false;
  bool isIdle = true;
  // TODO(movementImage): add bool isRunning which is used to indicate the Mario widget to show run1 image and run2 iamge
  // TODO(mushroom): add a bool isBigMario to record if Mario turns bigger after ate mushroom
  // TODO(brick): you may need a bool isMarioAboveBrick
  // TODO(keepRunning): add "Timer? runningTimer;""

  // TODO(mushroom): add a function to check if Mario ate the mushroom while
  //  mario is moving left/right or right after jump.
  //  Tips: void checkEatMushRoom()
  //  To determine, if Mario ate the mushroom, use this formula
  //  (marioX - mushroomX).abs() < 0.05 && (marioY - mushroomY).abs() < 0.05
  //  If Mario do eat the mushroom, turn Mario bigger, and dismiss the mushroom
  //  (the simplest way is to move mushrrom out of the screen, e.g AligmentX < -1 or > 1)

  // TODO(brick): you may need a function to check if the Mario new XY will
  //  touch the brick while jump/move left/move right. If touched, you should
  //  not set that new XY for mario, otherwise Mario will walk/jump through the wall.
  //  Tips: bool checkTouchBrick(double newMarioX, double newMarioY)

  // TODO(brick): you may need a function to check if the Mario is walking
  //  outside the brick while Mario is is above the brick (standing or jumping).
  //  Set MarioY to 1(back to the ground) when it does.
  //  Tips: void checkLeaveBrick(double newMarioX, double newMarioY)

  // TODO(mushroom): may need a function if you want to have randoam aligment X for the mushroom
  //  Tips: the calcuated double should be between -1 and 1
  //  double upper = 1;
  //  double lower = -1;
  //  double r = Random().nextDouble();
  //  double result = r * (upper - lower) + lower; // result is the double

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
      // TODO(brick): check If Mario is going to land on the brick.
      //  If yes, let Mario stand on the brick by setting MarioY to be
      //  the top Aligment Y of the brick and stop falling.
      if (initialHeight - height > 1) {
        setState(() {
          isJumping = false;
          marioY = 1;
        });
        timer.cancel();
      } else {
        setState(() {
          marioY = initialHeight - height;
        });
      }
    });
  }

  // TODO(keepRunning): update moveLeft func to receive bool isHoldingTap
  //  Tips: void moveLeft(bool isHoldingTap)
  void moveLeft() {
    // TODO(keepRunning):
    //  if isHoldingTap true, set the state(direction, isIdle) and start a
    //  Timer.periodic if the timer is not yet started, and store the timer in runningTimer.
    //  runningTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {...});
    //  Inside the Timer.periodic update the state isRunning and marioX.
    //  if isHoldingTap false, cancel the timer and set isIdle = true
    setState(() {
      direction = Direction.left;
      // TODO(movementImage): update bool isRunning
      //  which is used to indicate the Mario widget to show run1 image and run2 iamge
      //  Tops: "isRunning = !isRunning;"
      isIdle = false;
      marioX -= 0.02;
    });
  }

  void moveRight() {
    // TODO(keepRunning):
    //  if isHoldingTap true, set the state(direction, isIdle) and start a
    //  Timer.periodic if the timer is not yet started, and store the timer in runningTimer.
    //  runningTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {...});
    //  Inside the Timer.periodic update the state isRunning and marioX.
    //  if isHoldingTap false, cancel the timer and set isIdle = true
    setState(() {
      direction = Direction.right;
      // TODO(movementImage): update bool isRunning
      //  which is used to indicate the Mario widget to show run1 image and run2 iamge
      //  Tops: "isRunning = !isRunning;"
      isIdle = false;
      marioX += 0.02;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO(brick): if you need to calcuate the brick size according
    //  to screen hegiht, do it here.
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
                      // TODO(movementImage): pass isJumping, isRunning, isIdle into Mario widget
                      // TODO(mushroom): pass isBigMario to Mario and change to bigger size in Mario widget
                    ),
                  ),
                ),
                // TODO(mushroom): define a Mushroom widget that contains an Image
                //  assets/images/mushroom.png , and add the Mushroom here with
                //  random aligment X.
                // TODO(brick): define a Brick widget that contains an Image
                //  assets/images/brick_special.jpeg.
                //  Tips: our solution is using Aligment X,Y which is the scaled
                //  relative position(-1 to 1) inside the blue Container. And the Container
                //  is 80% height of the screen (blue Container flex 4, brown
                //  Container flex 1, so the blue one is 4/5). So hardcord a
                //  static width height e.g. 30, may make the brick looks bigger/smaller in
                //  different screen height, it maybe difficult to find the top Aligment Y of
                //  the brick for Mario to stand above. So, consider calculate
                //  the brick height using exact screen height * sclae, then you
                //  can calcuate the top Aligment Y of the brick using the same scale.
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
                    // TODO(keepRunning): After update the onTap callback in MyButton,
                    //  you can recieve to callback bool isHoldingTap and pass to moveLeft func
                    onTap: moveLeft,
                  ),
                  const SizedBox(width: 8),
                  MyButton(
                    icon: Icons.arrow_upward,
                    // TODO(keepRunning): NO need to pass the callback bool
                    //  isHoldingTap to jump func.
                    //  Tips: onTap: (_) => jump()
                    onTap: jump,
                  ),
                  const SizedBox(width: 8),
                  MyButton(
                    icon: Icons.arrow_forward,
                    // TODO(keepRunning): After update the onTap callback in MyButton,
                    //  you can recieve to callback bool isHoldingTap and pass to moveRight func
                    onTap: moveRight,
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
