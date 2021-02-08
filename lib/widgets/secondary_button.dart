import 'dart:ui';

import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final Function onTap;
  final String label;
  final IconData icon;
  SecondaryButton(
      {@required this.onTap, @required this.label, @required this.icon});
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: Colors.white.withOpacity(0.7),
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                label,
                style: TextStyle(color: Colors.white.withOpacity(0.7)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
