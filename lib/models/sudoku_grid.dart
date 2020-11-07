import 'package:flutter/material.dart';
import 'package:sudoku_solver/models/board_square.dart';
import 'package:sudoku_solver/models/position_model.dart';

class SudokuGrid extends ChangeNotifier {
  List<List<BoardSquare>> board;
  int width;
  int height;
  int selectedNumber = 0;

  SudokuGrid({this.board, this.width, this.height});

  SudokuGrid.blank(int rowCount, int columnCount) {
    this.board = List.generate(
      rowCount,
      (int row) => List.generate(
        columnCount,
        (int column) => BoardSquare(position: Position(x: row, y: column), value: 0),
      ),
    );
    this.width = rowCount;
    this.height = columnCount;
  }

  String toString() {
    return board[0].toString() +
        '\n' +
        board[1].toString() +
        '\n' +
        board[2].toString() +
        '\n' +
        board[3].toString() +
        '\n' +
        board[4].toString() +
        '\n' +
        board[5].toString() +
        '\n' +
        board[6].toString() +
        '\n' +
        board[7].toString() +
        '\n' +
        board[8].toString();
  }
}
