import 'package:flutter/material.dart';
import 'package:sudoku_solver/widgets/keypad_cell.dart';

class KeyPad extends StatelessWidget {
  final int rows = 2;
  final int columns = 5;
  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(
        width: 3,
        color: Colors.black,
      ),
      children: List.generate(
        rows,
        (int row) => TableRow(
          children: List.generate(
            columns,
            (int column) => KeyPadCell(
              numberValue: columns * row + column,
            ),
          ),
        ),
      ),
    );
  }
}
