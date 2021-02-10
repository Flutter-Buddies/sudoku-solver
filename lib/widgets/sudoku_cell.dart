import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudoku_solver/constants/enums.dart';
import 'package:sudoku_solver/models/board_square.dart';
import 'package:sudoku_solver/models/sudoku_grid.dart';

class SudokuCell extends StatelessWidget {
  // We are using the value of 0 to mean blank, therefore if the value of the board square is 0 we need to show nothing
  String getCellValue(int cellValue) {
    if (cellValue == 0) {
      return '';
    } else {
      return cellValue.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Update the value of the board square based on the current selected number from the keypad
        Provider.of<BoardSquare>(context, listen: false).updateValue(
            Provider.of<SudokuGrid>(context, listen: false).selectedNumber);
        Provider.of<SudokuGrid>(context, listen: false).boardErrors =
            BoardErrors.None;
        Provider.of<SudokuGrid>(context, listen: false).solveScreenStates =
            SolveScreenStates.Idle;
      },
      child: Container(
        height: 40,
        width: 30,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            // Right and bottom border to be thicker for 2nd and 5th index
            // Along with the table outer border this creates the inner and outer grids
            // Todo: Figure out a way to not have a border on bottom and right side of table
            right: BorderSide(
              width: (Provider.of<BoardSquare>(context, listen: false)
                              .position
                              .y ==
                          2 ||
                      Provider.of<BoardSquare>(context, listen: false)
                              .position
                              .y ==
                          5)
                  ? 1.5
                  : 0.5,
              color: Colors.blueAccent,
            ),
            bottom: BorderSide(
              width: (Provider.of<BoardSquare>(context, listen: false)
                              .position
                              .x ==
                          2 ||
                      Provider.of<BoardSquare>(context, listen: false)
                              .position
                              .x ==
                          5)
                  ? 1.5
                  : 0.5,
              color: Colors.blueAccent,
            ),
          ),
        ),
        child: Center(
          child: Text(
            getCellValue(Provider.of<BoardSquare>(context).value),
            style: TextStyle(
                fontSize: 18,
                color: context.watch<BoardSquare>().hasError
                    ? Colors.red
                    : Colors.blue[900],
                fontWeight: context.watch<BoardSquare>().userInputted
                    ? FontWeight.w900
                    : FontWeight.normal),
          ),
        ),
      ),
    );
  }
}
