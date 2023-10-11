import 'package:dismissible_lightbox/main.dart';
import 'package:flutter/material.dart';

class LightBox extends StatefulWidget {
  final Uri imageUrl;
  final String heroTag;

  const LightBox({
    super.key,
    required this.imageUrl,
    required this.heroTag,
  });

  @override
  State<LightBox> createState() => _LightBoxState();
}

class _LightBoxState extends State<LightBox> {
  bool _isDismissed = false;
  double _dismissProgress = 0;
  DismissDirection? _dismissDirection;

  void _handleDismiss({bool dismissedBySwipe = false}) {
    if (dismissedBySwipe) {
      setState(() {
        _isDismissed = true;
      });
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    Widget child = SizedBox.fromSize(
      size: screenSize,
      child: InteractiveViewer(
        child: Hero(
          tag: widget.heroTag,
          child: Image.network(
            imageUrl.toString(),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
    if (_isDismissed) {
      child = Padding(
        padding: EdgeInsets.only(
          top: _dismissDirection == DismissDirection.down
              ? screenSize.height
              : 0,
          bottom: _dismissDirection == DismissDirection.down
              ? 0
              : screenSize.height,
        ),
        child: child,
      );
    } else {
      child = Dismissible(
        key: const ValueKey('dismissible_media_lightbox'),
        direction: DismissDirection.vertical,
        resizeDuration: null,
        onUpdate: (details) {
          setState(() {
            _dismissProgress = details.progress;
            _dismissDirection = details.direction;
          });
        },
        onDismissed: (_) {
          _handleDismiss(dismissedBySwipe: true);
        },
        child: child,
      );
    }
    final viewPadding = MediaQuery.viewPaddingOf(context);
    final showControls = _dismissProgress == 0;
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(1 - _dismissProgress),
      body: Stack(
        children: [
          child,
          if (showControls) ...[
            Positioned(
              top: viewPadding.top,
              right: 5,
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: _handleDismiss,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
