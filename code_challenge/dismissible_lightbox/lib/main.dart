import 'package:flutter/material.dart';
import 'fade_transition_route.dart';
import 'lightbox.dart';

void main() {
  runApp(const MyApp());
}

const String heroTag = 'cat';
final Uri imageUrl = Uri.parse('https://placekitten.com/1000/1000');

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 100.0,
          height: 100.0,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                FadeTransitionRoute(builder: (BuildContext context) {
                  return LightBox(imageUrl: imageUrl, heroTag: heroTag);
                }),
              );
            },
            child: Hero(
              tag: heroTag,
              child: Image.network(
                imageUrl.toString(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
