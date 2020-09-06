import 'package:flutter/material.dart';

class LearningCard extends StatelessWidget {
  const LearningCard({
    Key key,
    this.text = "Card Example",
    this.color = Colors.lightBlue,
  }) : super(key: key);
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      width: 340,

      // Warning: hard-coding values like this is a bad practice
      padding: EdgeInsets.all(38.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          width: 4.0,
          color: Colors.lightBlueAccent,
        ),
      ),

      child: Text(
        text,
        style: TextStyle(
          fontSize: 22.0,
          // color: Colors.white,
          color: Colors.white.withOpacity(0.8),
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
