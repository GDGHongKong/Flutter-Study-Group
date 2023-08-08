import 'package:flutter/material.dart';

class Brick extends StatelessWidget {
  const Brick({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/brick_special.jpeg',
      width: size,
      height: size,
    );
  }
}
