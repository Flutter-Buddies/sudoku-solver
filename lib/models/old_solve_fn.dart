// Function to fill a given square with numbers 1 - 9 and produce a list of boards
import 'package:sudoku_solver/models/position_model.dart';

import 'board_square.dart';

List<List<BoardSquare>> solveBoard(List<List<int>> simpleBoard) {
  // Convert int board into list of board squares
  List<List<BoardSquare>> board = convertIntToBoard(simpleBoard);

  // Flatten the board
  List<BoardSquare> flatBoard = board.expand((element) => element).toList();

  // Get the position of the next blank space
  Position position = getNextEmptySquare(flatBoard);

  // Pass the position and board to create new boards
  List<List<List<BoardSquare>>> newBoards = createNewBoards(position, board);

  // If board is valid add to valid boards, if not, do recursion
  for (List<List<BoardSquare>> board in newBoards) {
    // First need to make sure they're a legal board
    // If legal continue, if not, stop
    if (checkLegal(board) == true) {
      // See if board is empty
      // If empty, iterate. If not the board is complete
      if (hasBlanks(board) == false) {
        return board;
      } else {
        List<List<BoardSquare>> unsolvedBoard = solveBoard(
          List.generate(
            9,
            (int row) => List.generate(
              9,
              (int column) => board[row][column].value,
            ),
          ),
        );
        if (unsolvedBoard != null) {
          return unsolvedBoard;
        }
      }
    }
  }
}

// Helper function to find the position of the next empty square
Position getNextEmptySquare(List<BoardSquare> flatBoard) {
  BoardSquare square = flatBoard.firstWhere((element) => element.value == 0);
  return square.position;
}

// Helper function to fill a given position with the numbers 1 - 9 and return the list of Boards
List<List<List<BoardSquare>>> createNewBoards(
    Position position, List<List<BoardSquare>> board) {
  // Variable to hold new boards
  List<List<List<BoardSquare>>> updatedBoards = [];

  // Use position to replace list at given index
  for (int i = 1; i < 10; i++) {
    // Duplicate board
    List<List<BoardSquare>> newBoard = createNewBoard(board);
    // Update value of new board
    newBoard[position.x][position.y].value = i;
    // Add new board to list
    updatedBoards.add(newBoard);
  }
  return updatedBoards;
}

// Function to check if the board has any blanks. Used to check if board is solved.
bool hasBlanks(List<List<BoardSquare>> board) {
  bool noBlanks = true;
  // Iterate through the board to see if any value is equal to 0
  // If a 0 is found, it means there is still blank spaces
  for (List<BoardSquare> row in board) {
    noBlanks = row.any((element) => element.value == 0);
  }
  return noBlanks;
}

// Function to check that each sublist has a unique number
// Returns a List where the 0th element is a bool and the 1st element is
// a list of Position objects
List<dynamic> checkLegal(List<List<BoardSquare>> board) {
  List<List<BoardSquare>> subsets = createFullSublist(board);
  var isUnique = [
    true,
    [Position(), Position()]
  ];
  for (List<BoardSquare> boardList in subsets) {
    List<int> set = [];
    List<BoardSquare> newSet = [];
    // Check if values are unique in a given sublist
    for (BoardSquare square in boardList) {
      for (BoardSquare square1 in newSet) {
        if (square.value == square1.value && square.value != 0) {
          isUnique[0] = false;
          isUnique[1] = [square.position, square1.position];
          break;
        }
      }
      // if (set.contains(square.value) == true && square.value != 0) {
      //   isUnique[0] = false;
      //   isUnique[1] = [square.position];
      //   break;
      // } else {
      //   set.add(square.value);
      // }
      newSet.add(square);
    }
  }
  return isUnique;
}

// Function to join all sub lists into one big list which can iterated over to check for duplicate numbers
List<List<BoardSquare>> createFullSublist(List<List<BoardSquare>> board) {
  List<List<BoardSquare>> combinedList = [];
  List<List<BoardSquare>> rows = getSublistOfRows(board);
  List<List<BoardSquare>> columns = getSublistOfColumns(board);
  List<List<BoardSquare>> threeXThree = getSublistThreeXThree(board);
  combinedList = rows + columns + threeXThree;
  return combinedList;
}

// Function to get a list of Rows. This is easy.
List<List<BoardSquare>> getSublistOfRows(List<List<BoardSquare>> board) {
  List<List<BoardSquare>> _listOfRows = [];
  for (int i = 0; i < 9; i++) {
    _listOfRows.add(board[i]);
  }
  return _listOfRows;
}

// Function to get a list of Columns. This was harder because it required nested for loops
List<List<BoardSquare>> getSublistOfColumns(List<List<BoardSquare>> board) {
  List<List<BoardSquare>> _listOfColumns = [];
  for (int i = 0; i < 9; i++) {
    List<BoardSquare> _listOfBoardSquares = [];
    for (int j = 0; j < 9; j++) {
      _listOfBoardSquares.add(board[j][i]);
    }
    _listOfColumns.add(_listOfBoardSquares);
  }
  return _listOfColumns;
}

// Function to create list of the small 3x3 grids
List<List<BoardSquare>> getSublistThreeXThree(List<List<BoardSquare>> board) {
  List<List<BoardSquare>> _listOfThreeXThree = [];
  for (int i = 0; i < 9; i += 3) {
    for (int j = 0; j < 9; j += 3) {
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

// Helper function to create a new board from existing board
List<List<BoardSquare>> createNewBoard(List<List<BoardSquare>> oldBoard) {
  List<List<BoardSquare>> newBoard = List.generate(
    9,
    (int row) => List.generate(
      9,
      (int column) => BoardSquare(
          position: Position(x: row, y: column),
          value: oldBoard[row][column].value),
    ),
  );
  return newBoard;
}

// Helper function to convert an ordered list of numbers into a Board
List<List<BoardSquare>> convertIntToBoard(List<List<int>> simpleBoard) {
  List<List<BoardSquare>> newBoard = List.generate(
    9,
    (int row) => List.generate(
      9,
      (int column) => BoardSquare(
          position: Position(x: row, y: column),
          value: simpleBoard[row][column]),
    ),
  );
  return newBoard;
}
