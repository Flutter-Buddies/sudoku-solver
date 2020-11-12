import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudoku_solver/models/sudoku_grid.dart';

class KeyPadCell extends StatelessWidget {
  KeyPadCell({this.numberValue});
  final int numberValue;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //print(numberValue);
        Provider.of<SudokuGrid>(context, listen: false).updateSelectedNumber(numberValue);
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: numberValue == Provider.of<SudokuGrid>(context).selectedNumber ? Colors.blue : Colors.blueGrey[200],
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
