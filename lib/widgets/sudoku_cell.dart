import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/enums.dart';
import '../models/board_square.dart';
import '../models/sudoku_grid.dart';

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
        context
            .read<BoardSquare>()
            .updateValue(context.read<SudokuGrid>().selectedNumber);
        context.read<SudokuGrid>().boardErrors = BoardErrors.None;
        context.read<SudokuGrid>().solveScreenStates = SolveScreenStates.Idle;
      },
      child: AspectRatio(
        // Find this aspect ratio looks a little better than 1.00
        aspectRatio: 1.05,
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              // Right and bottom border to be thicker for 2nd and 5th index
              // Along with the table outer border this creates the inner and outer grids
              // Todo: Figure out a way to not have a border on bottom and right side of table
              right: BorderSide(
                width: (context.watch<BoardSquare>().position.y == 2 ||
                        context.watch<BoardSquare>().position.y == 5)
                    ? 1.5
                    : 0.5,
                color: Colors.blueAccent,
              ),
              bottom: BorderSide(
                width: (context.watch<BoardSquare>().position.x == 2 ||
                        context.watch<BoardSquare>().position.x == 5)
                    ? 1.5
                    : 0.5,
                color: Colors.blueAccent,
              ),
            ),
          ),
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: Center(
              child: Text(
                getCellValue(context.watch<BoardSquare>().value),
                style: TextStyle(
                    // fontSize: 18,
                    color: context.watch<BoardSquare>().hasError
                        ? Colors.red
                        : Colors.blue[900],
                    fontWeight: context.watch<BoardSquare>().userInputted
                        ? FontWeight.w900
                        : FontWeight.normal),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
