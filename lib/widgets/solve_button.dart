import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudoku_solver/constants/enums.dart';
import 'package:sudoku_solver/models/sudoku_grid.dart';

class SolveButton extends StatefulWidget {
  @override
  _SolveButtonState createState() => _SolveButtonState();
}

class _SolveButtonState extends State<SolveButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<SudokuGrid>(context, listen: false).solveButtonPress(
            Provider.of<SudokuGrid>(context, listen: false).userBoard);
      },
      child: Container(
        padding: EdgeInsets.all(12.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Center(
          child: Text(
            'Solve',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

//* Old version for reference
class BottomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget buttonContent() {
      if (Provider.of<SudokuGrid>(context).solveScreenStates ==
              SolveScreenStates.Idle &&
          Provider.of<SudokuGrid>(context).boardErrors == BoardErrors.None) {
        return Text(
          'Solve!',
          style: TextStyle(color: Colors.white, fontSize: 20),
        );
      } else if (Provider.of<SudokuGrid>(context).boardErrors ==
          BoardErrors.Duplicate) {
        return Text(
          'Invalid Board',
          style: TextStyle(color: Colors.red, fontSize: 20),
        );
      } else if (Provider.of<SudokuGrid>(context).boardErrors ==
          BoardErrors.UnSolvable) {
        return Text(
          'This board cannot be solved',
          style: TextStyle(color: Colors.red, fontSize: 20),
        );
      } else if (Provider.of<SudokuGrid>(context).solveScreenStates ==
          SolveScreenStates.Solved) {
        return Text(
          'SOLVED!',
          style: TextStyle(color: Colors.green, fontSize: 20),
        );
      } else {
        return CircularProgressIndicator(
          backgroundColor: Colors.white,
        );
      }
    }

    return RaisedButton(
      color: Colors.blueAccent,
      onPressed: () {
        final snackBar = SnackBar(
            duration: Duration(seconds: 2),
            content: Text('There is an error on the board!'));

        Provider.of<SudokuGrid>(context, listen: false).solveButtonPress(
            Provider.of<SudokuGrid>(context, listen: false).userBoard);
      },
      child: buttonContent(),
    );
  }
}
