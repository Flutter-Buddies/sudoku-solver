import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudoku_solver/screens/solve_screen.dart';
import 'package:sudoku_solver/screens/history_screen.dart';
import 'package:sudoku_solver/screens/home_screen.dart';
import 'package:sudoku_solver/models/sudoku_grid.dart';
import 'package:sudoku_solver/constants/example_boards.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SudokuGrid>(
      create: (context) => SudokuGrid.fromTemplate(mediumBoard),
      child: MaterialApp(
        title: 'Sudoku Solver',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: 'home',
        routes: {
          'home': (context) => MyHomePage(),
          'solve': (context) => SolveScreen(),
          'history': (context) => HistoryScreen(),
        },
      ),
    );
  }
}
