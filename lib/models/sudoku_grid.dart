import 'package:flutter/material.dart';
import '../constants/enums.dart';
import 'board_square.dart';
import 'position_model.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'solve_fn.dart' as solve;
import 'old_solve_fn.dart' as oldSolve;

class SudokuGrid extends ChangeNotifier {
  List<List<BoardSquare>> userBoard;
  final int width = 9;
  final int height = 9;
  int selectedNumber = 0;
  SolveScreenStates solveScreenStates = SolveScreenStates.Idle;
  BoardErrors boardErrors = BoardErrors.None;

  // Generic constructor
  SudokuGrid({this.userBoard});

  // Named constructor to build a blank board
  SudokuGrid.blank() {
    this.userBoard = List.generate(
      width,
      (int row) => List.generate(
        height,
        (int column) =>
            BoardSquare(position: Position(x: row, y: column), value: 0),
        growable: false,
      ),
      growable: false,
    );
  }

  // Named constructor to build a board from a template (see lib/constants/example_bards.dart)
  SudokuGrid.fromTemplate(List<List<BoardSquare>> templateBoard) {
    userBoard = templateBoard;
  }

  // Cycle through each board square and set it's value to 0
  // And update any board states; selectedNumber, state, errors
  void resetBoard() {
    userBoard.forEach((row) {
      row.forEach((boardSquare) {
        boardSquare.value = 0;
        boardSquare.hasError = false;
        boardSquare.userInputted = false;
      });
    });
    this.selectedNumber = 0;
    solveScreenStates = SolveScreenStates.Idle;
    boardErrors = BoardErrors.None;
    notifyListeners();
  }

  // Setter to update the board variable
  set updateUIBoard(List<List<BoardSquare>> board) {
    this.userBoard = board;
    notifyListeners();
  }

  // 'Parent' function to call when a user selects to solve board
  // Async function as it will take time to complete
  // Returns void as the method updates the instance varable `userBoard`
  Future<void> solveButtonPress(List<List<BoardSquare>> board) async {
    // First and only once convert the board into a list of ints
    List<List<int>> intBoard = _convertBoardToInts(board);

    // Store locations of user inputted numbers
    List<Position> positions = _userInputtedNumbers(board);

    // If on first pass the board is illegal we should show which numbers
    // are the offending ones
    if (oldSolve.checkLegal(board)[0] == false) {
      // If there are errors we want to update them
      // Todo: Store result from `checklegal` call so it doesn't need to be called twice
      _updateBoardWithErrors(oldSolve.checkLegal(board)[1], board);
      solveScreenStates = SolveScreenStates.Error;
      boardErrors = BoardErrors.Duplicate;
      notifyListeners();
    } else {
      boardErrors = BoardErrors.None;
      solveScreenStates = SolveScreenStates.Loading;
      notifyListeners();

      // Run the computation
      List<List<int>> result = await compute(solve.solveBoard, intBoard);
      print('Result: $result');
      if (result != null) {
        // Convert the list of ints back to a board and set userBoard to result
        userBoard = _convertIntsToBoard(result);

        // Iterate through stored numbers and update `userBoard` so user inputted
        // numbers can be highlighted
        _updateUserInputtedNumbers(positions, userBoard);

        solveScreenStates = SolveScreenStates.Solved;
        notifyListeners();
      } else {
        // If there is no answer to a puzzle `solveBoard` will return null
        solveScreenStates = SolveScreenStates.Error;
        boardErrors = BoardErrors.UnSolvable;
        notifyListeners();
      }
    }
  }

  // Helper function to convert board to list of ints
  List<List<int>> _convertBoardToInts(List<List<BoardSquare>> board) {
    List<List<int>> intBoard = List.generate(
      9,
      (int row) => List.generate(
        9,
        (int column) => board[row][column].value,
      ),
    );
    return intBoard;
  }

  // Helper function to convert list of ints to a board
  List<List<BoardSquare>> _convertIntsToBoard(List<List<int>> board) {
    List<List<BoardSquare>> newBoard = List.generate(
      9,
      (int row) => List.generate(
        9,
        (int column) => BoardSquare(
            position: Position(x: row, y: column), value: board[row][column]),
      ),
    );
    return newBoard;
  }

  // Helper function to update board if any positions match that of error position
  void _updateBoardWithErrors(
      List<Position> positions, List<List<BoardSquare>> board) {
    // Iterate through each board square
    for (List<BoardSquare> row in board) {
      for (BoardSquare square in row) {
        // Update user inputted to true if the square's position object
        // matches a position object in the list (thanks Equatable)
        if (positions.contains(square.position)) {
          square.hasError = true;
        }
      }
    }
  }

  List<Position> _userInputtedNumbers(List<List<BoardSquare>> board) {
    List<Position> userInputtedPositions = [];
    // Iterate through rows then square to get all squares where there is a value and get it's position
    for (List<BoardSquare> row in board) {
      for (BoardSquare square in row) {
        if (square.value != 0) {
          userInputtedPositions.add(square.position);
        }
      }
    }
    return userInputtedPositions;
  }

  void _updateUserInputtedNumbers(
      List<Position> positions, List<List<BoardSquare>> board) {
    // Iterate through each board square
    for (List<BoardSquare> row in board) {
      for (BoardSquare square in row) {
        // Update user inputted to true if the square's position object
        // matches a position object in the list (thanks Equatable)
        if (positions.contains(square.position)) {
          square.userInputted = true;
        }
      }
    }
  }

  // Get a specific board square given a coordinate
  // Currently unused but thought it might be useful
  BoardSquare getBoardSquareAtPosition(int x, int y) {
    return userBoard[x][y];
  }

  void updateSelectedNumber(int newNumber) {
    this.selectedNumber = newNumber;
    solveScreenStates = SolveScreenStates.Idle;
    boardErrors = BoardErrors.None;
    notifyListeners();
  }

  String toString() {
    return userBoard[0].toString() +
        '\n' +
        userBoard[1].toString() +
        '\n' +
        userBoard[2].toString() +
        '\n' +
        userBoard[3].toString() +
        '\n' +
        userBoard[4].toString() +
        '\n' +
        userBoard[5].toString() +
        '\n' +
        userBoard[6].toString() +
        '\n' +
        userBoard[7].toString() +
        '\n' +
        userBoard[8].toString();
  }
}
