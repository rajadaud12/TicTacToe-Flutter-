import 'package:flutter/material.dart';

class GameCell extends StatelessWidget {
  late String value;

  GameCell({required this.value});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Container(
        margin: EdgeInsets.all(2.0), // Adjust the margin as needed
        decoration: BoxDecoration(
          color: Colors.brown[800],
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border(
            top: BorderSide(color: Colors.black, width: 2.0),
            left: BorderSide(color: Colors.black, width: 2.0),

          ),
        ),
        child: Center(
          child: Text(
            value,
            style:  TextStyle(
              fontFamily: 'CombackHome',
              fontSize: 50,
              color: (value=='X')?Colors.green:Colors.yellow,
            ),
          ),
        ),
      ),
    );
  }
}
