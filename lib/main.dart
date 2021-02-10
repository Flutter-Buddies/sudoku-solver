import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudoku_solver/screens/solve_screen.dart';
import 'package:sudoku_solver/screens/history_screen.dart';
import 'package:sudoku_solver/models/sudoku_grid.dart';
import 'package:sudoku_solver/constants/example_boards.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.blueAccent));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SudokuGrid>(
      create: (context) => SudokuGrid.fromTemplate(hardBoard),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sudoku Solver',
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: 'solve',
        routes: {
          'solve': (context) => SolveScreen(),
          'history': (context) => HistoryScreen(),
        },
      ),
    );
  }
}
