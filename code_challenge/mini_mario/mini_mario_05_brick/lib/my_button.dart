import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  // final VoidCallback onTap;
  final void Function(bool isHoldingTap) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: onTap,
      onTapDown: (_) => onTap(true),
      onTapUp: (_) => onTap(false),
      onTapCancel: () => onTap(false),
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
