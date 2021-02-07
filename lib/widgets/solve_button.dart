import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudoku_solver/constants/enums.dart';
import 'package:sudoku_solver/models/sudoku_grid.dart';

class SolveButton extends StatefulWidget {
  @override
  _SolveButtonState createState() => _SolveButtonState();
}

class _SolveButtonState extends State<SolveButton> {
  Widget _buttonWidget;
  Color _buttonColor;

  @override
  Widget build(BuildContext context) {
    if (context.watch<SudokuGrid>().boardErrors == BoardErrors.UnSolvable) {
      setState(() {
        _buttonWidget = Text(
          'Invalid Puzzle - Unsolvable',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        );
        _buttonColor = Colors.red;
      });
    } else if (context.watch<SudokuGrid>().boardErrors ==
        BoardErrors.Duplicate) {
      setState(() {
        _buttonWidget = Text(
          'Invalid Puzzle - Duplicate Number',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        );
        _buttonColor = Colors.red;
      });
    } else if (context.watch<SudokuGrid>().solveScreenStates ==
        SolveScreenStates.Loading) {
      setState(() {
        _buttonWidget = SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            backgroundColor: Colors.white,
          ),
        );
      });
    } else if (context.watch<SudokuGrid>().solveScreenStates ==
        SolveScreenStates.Solved) {
      setState(() {
        _buttonWidget = Text(
          'Solved',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        );
        _buttonColor = Colors.green;
      });
    } else {
      setState(() {
        _buttonWidget = Text(
          'Solve',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        );
        _buttonColor = Colors.blueAccent;
      });
    }
    return GestureDetector(
      onTap: () {
        context
            .read<SudokuGrid>()
            .solveButtonPress(context.read<SudokuGrid>().userBoard);
      },
      child: Container(
        padding: EdgeInsets.all(12.0),
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          color: _buttonColor,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Center(child: _buttonWidget),
      ),
    );
  }
}
// Todo: Need a way of resetting state when the board is edited

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
