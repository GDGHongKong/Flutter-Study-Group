import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  // TODO(keepRunning): update the onTap callback to receive a bool isHoldingTap
  //  Tips: final void Function(bool isHoldingTap) onTap;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // TODO(keepRunning): use the fields onTapDown, onTapUp and onTapCancel
      //  instead of field onTap.
      //  onTapDown should pass isHoldingTap true to the onTap callbck.
      //  onTapCancel should pass isHoldingTap false to the onTap callbck.
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(12),
          color: Colors.brown[200],
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
