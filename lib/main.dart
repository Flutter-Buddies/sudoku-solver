import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/solve_screen.dart';
import 'screens/history_screen.dart';
import 'models/sudoku_grid.dart';
import 'constants/example_boards.dart';
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
      create: (context) => SudokuGrid.blank(9, 9),
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
