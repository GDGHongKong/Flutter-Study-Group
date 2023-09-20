import 'package:flutter/material.dart';
import 'package:mini_mario/game_page.dart';

class Mario extends StatelessWidget {
  const Mario({
    super.key,
    required this.direction,
    // TODO(movementImage): add required param this.isJumping, this.isRunning, this.isIdle
  });

  final Direction direction;
  // TODO(movementImage): add bool field isJumping, isRunning, isIdle

  @override
  Widget build(BuildContext context) {
    const marioSize = 50.0;

    late final String imgPath;
    final leftOrRight = direction == Direction.left ? 'l' : 'r';
    // TODO(movementImage): assign differnt path to imgPath according to isJumping, isIdle, isRunning
    //  For Jumping true
    //  'assets/images/mario_jump_l.png'
    //  'assets/images/mario_jump_r.png'
    //  For Idle true
    //  'assets/images/mario_idle_l.png'
    //  'assets/images/mario_idle_r.png'
    //  For Idle false and isRunning true
    //  'assets/images/mario_run1_l.png'
    //  'assets/images/mario_run1_r.png'
    //  For Idle false and isRunning false
    //  'assets/images/mario_run2_l.png'
    //  'assets/images/mario_run2_r.png'
    imgPath = 'assets/images/mario_idle_$leftOrRight.png';

    return Image.asset(
      imgPath,
      width: marioSize,
      height: marioSize,
    );
  }
}
