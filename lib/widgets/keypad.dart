import 'package:flutter/material.dart';
import 'package:sudoku_solver/widgets/keypad_cell.dart';

class KeyPad extends StatelessWidget {
  static const int rows = 2;
  static const int columns = 5;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 16.0,
      runSpacing: 16.0,
      children: List.generate(
        rows * columns,
        (index) => KeyPadCell(
          numberValue: index,
        ),
      ),
    );
  }
}
