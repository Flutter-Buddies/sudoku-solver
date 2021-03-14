import 'package:flutter/material.dart';
import '../models/board_square.dart';
import 'sudoku_cell.dart';
import 'package:provider/provider.dart';
import '../models/sudoku_grid.dart';

class SudokuTable extends StatelessWidget {
  static const _borderRadius = 15.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.all(
          Radius.circular(_borderRadius),
        ),
        // border: Border.all(color: Colors.blueAccent, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.blue[900].withOpacity(0.3),
            offset: Offset(0, 12),
            blurRadius: 12,
            spreadRadius: 5,
          ),
        ],
      ),
      // [ClipRRect] so that the border of Container isn't cut off
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(_borderRadius),
        ),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: List.generate(
              9,
              (int rowNumber) => TableRow(
                children: List.generate(
                  9,
                  (int columnNumber) =>
                      ChangeNotifierProvider<BoardSquare>.value(
                    value: context.watch<SudokuGrid>().userBoard[rowNumber]
                        [columnNumber],
                    child: SudokuCell(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
