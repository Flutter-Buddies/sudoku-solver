import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      },
      child: Container(
        height: 40,
        width: 30,
        decoration: BoxDecoration(
          // color: Colors.blue[200],
          border: Border(
            right: BorderSide(
              width:
                  (Provider.of<BoardSquare>(context, listen: false).position.y %
                              3 ==
                          2)
                      ? 2
                      : 0.5,
              color: Colors.blueAccent,
            ),
            bottom: BorderSide(
              width:
                  (Provider.of<BoardSquare>(context, listen: false).position.x %
                              3 ==
                          2)
                      ? 2
                      : 0.5,
              color: Colors.blueAccent,
            ),
          ),
        ),
        child: Center(
          child: Text(
            getCellValue(Provider.of<BoardSquare>(context).value),
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
