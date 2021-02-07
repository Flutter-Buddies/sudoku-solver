import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudoku_solver/models/sudoku_grid.dart';

class KeyPadCell extends StatelessWidget {
  KeyPadCell({@required this.numberValue}) : assert(numberValue >= 0);
  final int numberValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //print(numberValue);
        Provider.of<SudokuGrid>(context, listen: false)
            .updateSelectedNumber(numberValue);
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            color:
                numberValue == Provider.of<SudokuGrid>(context).selectedNumber
                    ? Colors.blueAccent
                    : Colors.transparent,
            border: Border.all(color: Colors.blueAccent[400], width: 1),
            borderRadius: BorderRadius.circular(8.0)),
        child: Center(
          child: numberValue == 0
              ? Icon(
                  Icons.auto_fix_normal,
                  color: numberValue ==
                          Provider.of<SudokuGrid>(context).selectedNumber
                      ? Colors.white
                      : Colors.blue[900],
                )
              : Text(
                  // Instead of showing the number 0, we want the user to be able to a blank space
                  numberValue.toString(),
                  style: TextStyle(
                    color: numberValue ==
                            Provider.of<SudokuGrid>(context).selectedNumber
                        ? Colors.white
                        : Colors.blue[900],
                    fontSize: 18,
                  ),
                ),
        ),
      ),
    );
  }
}
