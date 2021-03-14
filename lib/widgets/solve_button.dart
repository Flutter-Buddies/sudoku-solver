import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudoku_solver/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import '../constants/enums.dart';
import '../models/sudoku_grid.dart';

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
          LocaleKeys.invalid_puzzle_unsolvable.tr(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        );
        _buttonColor = Colors.red;
      });
    } else if (context.watch<SudokuGrid>().boardErrors ==
        BoardErrors.Duplicate) {
      setState(() {
        _buttonWidget = Text(
          LocaleKeys.invalid_puzzle_duplicate_number.tr(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
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
          LocaleKeys.solved.tr(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        );
        _buttonColor = Colors.green;
      });
    } else {
      setState(() {
        _buttonWidget = Text(
          LocaleKeys.solve.tr(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
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
          '${LocaleKeys.solve.tr()}!',
          style: TextStyle(color: Colors.white, fontSize: 20),
        );
      } else if (Provider.of<SudokuGrid>(context).boardErrors ==
          BoardErrors.Duplicate) {
        return Text(
          LocaleKeys.invalid_board.tr(),
          style: TextStyle(color: Colors.red, fontSize: 20),
        );
      } else if (Provider.of<SudokuGrid>(context).boardErrors ==
          BoardErrors.UnSolvable) {
        return Text(
          LocaleKeys.this_board_connot_be_solved.tr(),
          style: TextStyle(color: Colors.red, fontSize: 20),
        );
      } else if (Provider.of<SudokuGrid>(context).solveScreenStates ==
          SolveScreenStates.Solved) {
        return Text(
          LocaleKeys.solved.tr(),
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
          content: Text(
            LocaleKeys.there_is_an_error_on_the_board.tr(),
          ),
        );

        Provider.of<SudokuGrid>(context, listen: false).solveButtonPress(
            Provider.of<SudokuGrid>(context, listen: false).userBoard);
      },
      child: buttonContent(),
    );
  }
}
