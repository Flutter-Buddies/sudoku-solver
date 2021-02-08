import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
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
        // Need to resize the key cells if the screen is too small
        height: MediaQuery.of(context).size.height < 620 ? 35 : 40,
        width: MediaQuery.of(context).size.height < 620 ? 35 : 40,
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
                  Entypo.eraser,
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
