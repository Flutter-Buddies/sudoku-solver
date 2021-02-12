import 'position_model.dart';

import 'check_legal_fn.dart' as legal;

// Assume `solveBoard` is passed a legal board with an empty space
List<List<int>> solveBoard(List<List<int>> board) {
  // 1. First we need to find the Position in the board where there is an empty square
  var position = _nextEmptySquare(board);

  // 2. Next we want to create 9 new boards with the empty space filled with [1-9]
  var newBoards = _createNewBoards(position, board);

  // 3. Iterate through the list of new boards
  for (List<List<int>> board in newBoards) {
    // 4. Check if new board is legal
    if (legal.checkLegal(board)) {
      // 5. See if the board has any blank spaces
      if (_hasBlanks(board) == false) {
        // 6a. If there are no blanks, the puzzle is solved and board can be returned
        return board;
      } else {
        // 6b. If there are blanks, then it needs to be passed to the next recursion
        // Board could be null because null could be returned from some branches or recursion
        // and need to be dropped (not returned)
        List<List<int>> unsolvedBoard = solveBoard(board);
        if (unsolvedBoard != null) {
          return unsolvedBoard;
        }
      }
    } else {
      // Drop the board because it is not legal
    }
  }
  return null;
}

// Helper function to `solveBoard` that finds the [Position] of the next empty (0) square
Position _nextEmptySquare(List<List<int>> board) {
  Position position;
  // Nested for loop to generate a 9 x 9 matrix
  for (int i = 0; i < 9; i++) {
    for (int j = 0; j < 9; j++) {
      if (board[i][j] == 0) {
        position = Position(x: i, y: j);
        // Break the inner for loop
        break;
      }
    }
    // Break the outer for loop if a position has been found
    if (position != null) {
      break;
    }
  }
  return position;
}

// Return a list of new boards given a board and a position
List<List<List<int>>> _createNewBoards(
    Position position, List<List<int>> board) {
  List<List<List<int>>> newBoards = [];
  // Generate numbers [1-9]
  for (int i = 1; i < 10; i++) {
    List<List<int>> newBoard = _copyBoard(board);
    newBoard[position.x][position.y] = i;
    // print('createNewBoards: New Board: $newBoard');
    newBoards.add(newBoard);
  }

  return newBoards;
}

// Helper function to `_createNewBoards`
// To duplicate the board we need to use .from method and on each row
List<List<int>> _copyBoard(List<List<int>> board) {
  List<List<int>> newBoard = [];
  for (List<int> row in board) {
    // newBoard.add(List<int>.from(row));
    List<int> newRow = row.map((e) => e).toList();
    newBoard.add(newRow);
  }
  // print('Copy Board: new board = $newBoard');
  return newBoard;
}

// Helper function to see if there are any blank spaces (i.e. int's == 0)
// Iterates through a row and returns true if there are blanks
bool _hasBlanks(List<List<int>> board) {
  // Iterate through the board to see if any value is equal to 0
  // If a 0 is found, it means there is still blank spaces
  for (List<int> row in board) {
    for (int square in row) {
      if (square == 0) {
        return true;
      }
    }
  }
  return false;
}
