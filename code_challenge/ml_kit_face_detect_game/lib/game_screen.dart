import 'package:flutter/material.dart';
import 'package:ml_kit_face_detect_game/constants/constants.dart';
import 'package:ml_kit_face_detect_game/face_detector_view.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        FaceDetectorView(),
        GameView(),
      ],
    );
  }
}

class GameView extends StatelessWidget {
  const GameView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: Text(
            'Level: 1',
            style: TextStyle(
              color: MyColor.gameTextColor,
              fontSize: MyFontSize.gameTextFontSize,
            ),
          ),
        ),
      ],
    );
  }
}
