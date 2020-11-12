import 'package:flutter/material.dart';
import 'package:sudoku_solver/models/board_square.dart';
import 'package:sudoku_solver/widgets/sudoku_cell.dart';
import 'package:provider/provider.dart';
import 'package:sudoku_solver/models/sudoku_grid.dart';

class SudokuTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder(
        left: BorderSide(
          width: 3,
          color: Colors.black,
        ),
        top: BorderSide(
          width: 3,
          color: Colors.black,
        ),
      ),
      children: List.generate(
        Provider.of<SudokuGrid>(context).height,
        (int rowNumber) => TableRow(
          children: List.generate(
            Provider.of<SudokuGrid>(context).width,
            (int columnNumber) => ChangeNotifierProvider<BoardSquare>.value(
              value: Provider.of<SudokuGrid>(context).userBoard[rowNumber][columnNumber],
              child: SudokuCell(),
            ),
          ),
        ),
      ),
    );
  }
}
