# draggable_bottom_sheet

This is the solution of the Flutter coding challenge on Aug 22 2023, in the Flutter study group organized by GDG Hong Kong and the Flutter Hong Kong User Group.

![](image.gif)

## Challenge Requirements

Write a Flutter application, which has a button, clicking the button will open a bottom sheet.

i. The header of the bottom sheet is draggable, which is used to adjust the height of the sheet.

ii. The header of the sheet contains a text field.

iii. The bottom sheet's middle part is a ListView that can be scrolled independently.

iv. The bottom sheet has a fixed footer, which contains a button.

v. The keyboard pops out when focused on the text field in the header. The fixed footer avoids the keyboard and remains visible.

## Limitations Of The Solution

The bottom sheet is only draggable on mobile platforms. However, there is a [proposal](https://github.com/flutter/flutter/issues/101903) suggesting that users should be able to adjust the height of a DraggableScrollableSheet using the mouse scroll wheel.

## Disclaimer

This is just an example of how to build the required UI in Flutter. It may not be the only solution, nor the best solution.

This solution works on Flutter version 3.10.6. It may or may not work on future versions of Flutter.
