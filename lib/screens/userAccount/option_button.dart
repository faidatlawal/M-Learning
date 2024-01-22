import 'package:flutter/material.dart';
class OptionButtons extends StatelessWidget {
  final String text;
  final Color color;
  final Color bColor;
  final Color textColor;
  const OptionButtons({@required this.text, @required this.color, @required this.bColor, @required this.textColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 120,
      decoration: BoxDecoration(
        color:  color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: bColor),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontFamily: "Calibri",
            fontWeight: FontWeight.w500,  color: textColor,
          ),),
      ),
    );
  }
}