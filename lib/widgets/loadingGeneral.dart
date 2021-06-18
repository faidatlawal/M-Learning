
import 'package:flutter/material.dart';
import 'package:mobile_quiz/constants/widgets.dart';
class LoadingGeneral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Center(
    child: CircularProgressIndicator(
backgroundColor: buttonColor1, valueColor: AlwaysStoppedAnimation<Color>(appB),
strokeWidth: 6,), ), color: backgroundColor1,
);
  }
}
