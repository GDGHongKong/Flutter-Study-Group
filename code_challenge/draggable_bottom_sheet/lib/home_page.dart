import 'package:draggable_bottom_sheet/dodge_keyboard.dart';
import 'package:flutter/material.dart';
import 'bottom_sheet.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              builder: (BuildContext context) {
                return DodgeKeyboard(
                  child: DraggableScrollableSheet(
                    expand: false,
                    builder: (
                      BuildContext context,
                      ScrollController controller,
                    ) {
                      return MyBottomSheet(
                        scrollController: controller,
                      );
                    },
                  ),
                );
              },
            );
          },
          child: const Text('Open'),
        ),
      ),
    );
  }
}
