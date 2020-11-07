import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudoku_solver/models/sudoku_grid.dart';

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

class KeyPadCell extends StatelessWidget {
  KeyPadCell({this.numberValue});
  final int numberValue;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(numberValue);
        Provider.of<SudokuGrid>(context, listen: false).selectedNumber = numberValue;
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: Center(
          child: Text(
            // Instead of showing the number 0, we want the user to be able to a blank space
            numberValue == 0 ? 'Blank' : numberValue.toString(),
          ),
        ),
      ),
    );
  }
}
