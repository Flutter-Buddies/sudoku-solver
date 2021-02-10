bool checkLegal(List<List<int>> board) {
  // 1. Create a list of rows, columns and 3x3 grids
  List<List<int>> subsets = _createRowSubSet(board) +
      _createColumnSubSet(board) +
      _createThreeXThreeSubSet(board);

  // 2. Iterate through each subset and make sure there are no duplicate values (except for 0's)
  var isUnique = true; // Variable to hold if there are duplicates.
  for (List<int> list in subsets) {
    // Compare a single value in a list against the other values
    List<int> set = [];
    for (int square in list) {
      // If square value is in set then it means there is a duplicate
      // If it is not, add the square to set
      // Wanted to do list.contains(square) but it obviously will
      if (set.contains(square) && square != 0) {
        isUnique = false;
        // break used because there's no point carrying on the loop
        break;
      } else {
        set.add(square);
      }
    }
    // Todo: Test this
    // If at any point isUnique is equal to false the loop should be broken
    if (isUnique == false) {
      break;
    }
  }
  return isUnique;
}

//* Helper functions to generate sublists
// Create a list of rows. Rows are of type List<int>
// board[0] is the first row of a sudoku board
List<List<int>> _createRowSubSet(List<List<int>> board) {
  List<List<int>> listOfRows = [];
  for (int i = 0; i < 9; i++) {
    listOfRows.add(board[i]);
  }
  return listOfRows;
}

// Create a list of columns. Columns are of type List<int>
// This is harder because it requires accessing each row then column
// board[0][0] + board[0][1] + ... + board[0][n] is the first column
List<List<int>> _createColumnSubSet(List<List<int>> board) {
  List<List<int>> listOfColumns = [];
  for (int i = 0; i < 9; i++) {
    List<int> listOfSquares = [];
    for (int j = 0; j < 9; j++) {
      listOfSquares.add(board[j][i]);
    }
    listOfColumns.add(listOfSquares);
  }
  return listOfColumns;
}

// Create a list of 3x3 grids. 3x3 grids are of type List<int>
// board[0][0] + board[0][1] + board[0][2] +
// board[1][0] + board[1][1] + board[1][2] +
// board[2][0] + board[2][1] + board[2][2] is the top left 3x3 grid
List<List<int>> _createThreeXThreeSubSet(List<List<int>> board) {
  List<List<int>> listOfThreeXThree = [];
  for (int i = 0; i < 9; i += 3) {
    for (int j = 0; j < 9; j += 3) {
      List<int> subListOfSquares = [];
      subListOfSquares.add(board[i][j]);
      subListOfSquares.add(board[i][j + 1]);
      subListOfSquares.add(board[i][j + 2]);
      subListOfSquares.add(board[i + 1][j]);
      subListOfSquares.add(board[i + 1][j + 1]);
      subListOfSquares.add(board[i + 1][j + 2]);
      subListOfSquares.add(board[i + 2][j]);
      subListOfSquares.add(board[i + 2][j + 1]);
      subListOfSquares.add(board[i + 2][j + 2]);
      listOfThreeXThree.add(subListOfSquares);
    }
  }
  return listOfThreeXThree;
}
