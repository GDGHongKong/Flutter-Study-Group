import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Study Group: CustomPaint'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // === [START] solution 1: only CustomPaint ===
            CustomPaint(
              size: Size(size.width, 200),
              painter: Solution1CouponCustomPainter(),
            ),
            // === [END] solution 1: only CustomPaint ===
            const Spacer(),
            // === [START] solution 2: CustomPaint and CustomClipper ===
            CustomPaint(
              size: Size(size.width, 200),
              painter: Solution2ClipShadowPainter(
                shadow: Shadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
                clipper: Solution2CouponClipper(),
              ),
              child: ClipPath(
                clipper: Solution2CouponClipper(),
                child: Container(
                  color: Colors.lightGreen,
                  height: 200,
                ),
              ),
            ),
            // === [END] solution 2: CustomPaint and CustomClipper ===
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Solution1CouponCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.lightGreen
      ..style = PaintingStyle.fill;
    const concavePos = 0.7;
    const concaveR = 15.0;
    const cornerR = 20.0;
    final path = Path()
      ..moveTo(cornerR, 0)
      ..quadraticBezierTo(0, 0, 0, cornerR)
      ..lineTo(0, size.height - cornerR)
      ..quadraticBezierTo(0, size.height, cornerR, size.height)
      ..lineTo(size.width * concavePos, size.height)
      ..arcToPoint(
          Offset((size.width * concavePos) + (concaveR * 2), size.height),
          radius: const Radius.circular(concaveR),
          clockwise: true)
      ..lineTo(size.width - cornerR, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - cornerR)
      ..lineTo(size.width, cornerR)
      ..quadraticBezierTo(size.width, 0, size.width - cornerR, 0)
      ..lineTo((size.width * concavePos) + (concaveR * 2), 0)
      ..arcToPoint(Offset(size.width * concavePos, 0),
          radius: const Radius.circular(concaveR), clockwise: true);

    final shadow = BoxShadow(
      color: Colors.black.withOpacity(0.3),
      offset: const Offset(0, 2),
      blurRadius: 6,
      spreadRadius: 0,
    );
    // draw shadow
    canvas.drawPath(path.shift(shadow.offset), shadow.toPaint());
    // draw the shape
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class Solution2CouponClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const concavePos = 0.7;
    const concaveR = 15.0;
    const cornerR = 20.0;
    final path = Path()
      ..moveTo(cornerR, 0)
      ..quadraticBezierTo(0, 0, 0, cornerR)
      ..lineTo(0, size.height - cornerR)
      ..quadraticBezierTo(0, size.height, cornerR, size.height)
      ..lineTo(size.width * concavePos, size.height)
      ..arcToPoint(
          Offset((size.width * concavePos) + (concaveR * 2), size.height),
          radius: const Radius.circular(concaveR),
          clockwise: true)
      ..lineTo(size.width - cornerR, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - cornerR)
      ..lineTo(size.width, cornerR)
      ..quadraticBezierTo(size.width, 0, size.width - cornerR, 0)
      ..lineTo((size.width * concavePos) + (concaveR * 2), 0)
      ..arcToPoint(Offset(size.width * concavePos, 0),
          radius: const Radius.circular(concaveR), clockwise: true);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class Solution2ClipShadowPainter extends CustomPainter {
  Solution2ClipShadowPainter({required this.shadow, required this.clipper});

  final Shadow shadow;
  final CustomClipper<Path> clipper;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = shadow.toPaint();
    final clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
