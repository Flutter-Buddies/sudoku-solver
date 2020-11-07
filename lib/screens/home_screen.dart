import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sudoku Solver'),
        ),
        body: Center(
          child: Column(
            children: [
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'solve');
                },
                child: Text('Solve a puzzle'),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'history');
                },
                child: Text('History'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
