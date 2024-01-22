
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_quiz/constants/decoration.dart';
class LoadingGeneral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
backgroundColor: buttonColor1, valueColor: AlwaysStoppedAnimation<Color>(appB),
strokeWidth: 6,
        ),
        SizedBox(height: 10,),
        Text("Please wait...", style: TextStyle(color: Colors.black, fontSize: 18),),
      ],
    ), ), color: backgroundColor1,
);
  }
}
