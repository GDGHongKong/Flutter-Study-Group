import 'package:flutter/material.dart';

// prevents the child being overlapped by the keyboard
class DodgeKeyboard extends StatelessWidget {
  final Widget child;

  const DodgeKeyboard({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: child,
    );
  }
}
