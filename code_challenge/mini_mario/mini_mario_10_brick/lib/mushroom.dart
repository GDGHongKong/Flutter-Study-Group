import 'package:flutter/material.dart';

class Mushroom extends StatelessWidget {
  const Mushroom({super.key});

  @override
  Widget build(BuildContext context) {
    const size = 30.0;
    return Image.asset(
      'assets/images/mushroom.png',
      width: size,
      height: size,
    );
  }
}
