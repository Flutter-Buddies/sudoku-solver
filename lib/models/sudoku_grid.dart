import 'package:flutter/material.dart';
import 'package:sudoku_solver/models/board_square.dart';
import 'package:sudoku_solver/models/position_model.dart';

class SudokuGrid extends ChangeNotifier {
  List<List<BoardSquare>> board;
  List<List<BoardSquare>> subsets = [];
  int width;
  int height;
  int selectedNumber = 0;

  // Generic constructor
  SudokuGrid({this.board, this.width, this.height});

  // Named constructor to build a blank board
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

  // Need a set of functions to:
  // - Check that the board is 'legal'
  // - Create a list of all 'sets' (3 x 3 grid, columns and rows) and make sure they don't contain any duplicate values

  // Get a specific board square given a coordinate
  // Currently unused but thought it might be useful
  BoardSquare getBoardSquareAtPosition(int x, int y) {
    return board[x][y];
  }

  // Function to get a list of Rows. This is easy.
  List<List<BoardSquare>> getSublistOfRows() {
    List<List<BoardSquare>> _listOfRows = [];
    for (int i = 0; i < width; i++) {
      _listOfRows.add(board[i]);
    }
    return _listOfRows;
  }

  // Function to get a list of Columns. This was harder because it required nested for loops
  List<List<BoardSquare>> getSublistOfColumns() {
    List<List<BoardSquare>> _listOfColumns = [];
    for (int i = 0; i < height; i++) {
      List<BoardSquare> _listOfBoardSquares = [];
      for (int j = 0; j < width; j++) {
        _listOfBoardSquares.add(board[j][i]);
      }
      _listOfColumns.add(_listOfBoardSquares);
    }
    return _listOfColumns;
  }

  // Function to create list of the small 3x3 grids
  List<List<BoardSquare>> getSublistThreeXThree() {
    List<List<BoardSquare>> _listOfThreeXThree = [];
    for (int i = 0; i < height; i += 3) {
      for (int j = 0; j < width; j += 3) {
        List<BoardSquare> _subListOfBoardSquares = [];
        _subListOfBoardSquares.add(board[i][j]);
        _subListOfBoardSquares.add(board[i][j + 1]);
        _subListOfBoardSquares.add(board[i][j + 2]);
        _subListOfBoardSquares.add(board[i + 1][j]);
        _subListOfBoardSquares.add(board[i + 1][j + 1]);
        _subListOfBoardSquares.add(board[i + 1][j + 2]);
        _subListOfBoardSquares.add(board[i + 2][j]);
        _subListOfBoardSquares.add(board[i + 2][j + 1]);
        _subListOfBoardSquares.add(board[i + 2][j + 2]);
        _listOfThreeXThree.add(_subListOfBoardSquares);
      }
    }
    return _listOfThreeXThree;
  }

  // Function to join all sub lists into one big list which can iterated over to check for duplicate numbers
  void createFullSublist() {
    List<List<BoardSquare>> rows = getSublistOfRows();
    List<List<BoardSquare>> columns = getSublistOfColumns();
    List<List<BoardSquare>> threeXThree = getSublistThreeXThree();
    // print('These are the rows:');
    // print(rows);
    // print('These are the columns:');
    // print(columns);
    // print('These are the 3x3');
    // print(threeXThree);
    subsets = rows + columns + threeXThree;
    // print(subsets);
  }

  // Function to check that each sublist has a unique number
  bool checkUnique() {
    bool isUnique = true;
    for (List<BoardSquare> boardList in subsets) {
      List<int> set = [];
      // Check if values are unique in a given sublist
      // Todo: It would be helpful if the function could highlight the offending square
      for (BoardSquare square in boardList) {
        if (set.contains(square.value) == true && square.value != 0) {
          isUnique = false;
          print('Offending square is x: ' + square.position.x.toString() + ' y: ' + square.position.y.toString());
          break;
        } else {
          set.add(square.value);
        }
      }
    }
    return isUnique;
  }

  void updateSelectedNumber(int newNumber) {
    this.selectedNumber = newNumber;
    notifyListeners();
  }

  // Cycle through each board square and set it's value to 0
  void resetBoard() {
    board.forEach((row) {
      row.forEach((boardSquare) {
        boardSquare.value = 0;
      });
    });
    this.selectedNumber = 0;
    notifyListeners();
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
