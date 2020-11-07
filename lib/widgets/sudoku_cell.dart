import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudoku_solver/models/board_square.dart';
import 'package:sudoku_solver/models/sudoku_grid.dart';

class SudokuCell extends StatelessWidget {
  SudokuCell({this.row, this.column});
  final int row;
  final int column;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('Cell row: $row, Cell column: $column');
        Provider.of<BoardSquare>(context, listen: false)
            .updateValue(Provider.of<SudokuGrid>(context, listen: false).selectedNumber);
      },
      child: Container(
        height: 40,
        width: 30,
        decoration: BoxDecoration(
          color: Colors.green,
          border: Border(
            right: BorderSide(
              width: (column % 3 == 2) ? 3 : 1,
              color: Colors.black,
            ),
            bottom: BorderSide(
              width: (row % 3 == 2) ? 3 : 1,
              color: Colors.black,
            ),
          ),
        ),
        child: Center(
          child: Text(Provider.of<BoardSquare>(context).value.toString()),
        ),
      ),
    );
  }
}
