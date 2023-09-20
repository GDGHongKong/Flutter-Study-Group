import 'package:flutter/material.dart';
import 'package:mini_mario/game_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(fontFamily: 'PressStart2P', textTheme: const TextTheme()),
      home: const GamePage(),
    );
  }
}
