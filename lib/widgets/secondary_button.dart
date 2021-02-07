import 'dart:ui';

import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final Function onTap;
  final String label;
  SecondaryButton({@required this.onTap, @required this.label});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.white.withOpacity(0.7)),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: Colors.white.withOpacity(0.7)),
          ),
        ),
      ),
    );
  }
}
