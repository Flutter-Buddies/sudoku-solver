import 'package:flutter/material.dart';
import 'package:sudoku_solver/models/sudoku_grid.dart';
import 'package:sudoku_solver/widgets/secondary_button.dart';
import 'package:provider/provider.dart';

class OptionsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SecondaryButton(
              onTap: () => context.read<SudokuGrid>().resetBoard(),
              label: 'Reset',
              icon: Icons.refresh_outlined,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SecondaryButton(
              onTap: () {
                // ignore: deprecated_member_use
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text('Feature coming soon!')));
                // Todo: Implement image recognition functionality
              },
              label: 'Take picture',
              icon: Icons.camera,
            ),
          ),
        ),
      ],
    );
  }
}
