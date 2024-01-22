
import 'package:flutter/material.dart';

const Color buttonColor1 = Color(0xff3a2c3b);
const Color textColor2 = Colors.white;
const Color backgroundColor1 = Color(0xfffef9f6);
const Color backgroundColor2 = Color(0xfffde8d7);
const Color appBarColor = Color(0xfff8b17b);
const Color appBarColor2 = Color(0xfffa9f5e);
const Color iconColor1 = Color(0xfff4d4d2);
const Color iconColor2 = Color(0xffeca090);
const Color appB = Color(0xfff79f59);
const Color iconC1 = Color(0xffee5542);
const Color icon2 = Color(0xffd2706e);
const Color extraColor2 = Color(0xff452951);
const Color extraColor1 = Color(0xff424b5e);
const Color extraColor3 = Color(0xff4a2a51);
const Color extraColor4appB = Color(0xff452951);
const Color extraColor5body = Color(0xff533051);



Widget button({BuildContext context, String textTitle, double buttonSize}){
  return  Container(
    padding: EdgeInsets.symmetric(vertical: 12),
    child: Text(textTitle, style: TextStyle(color: textColor2, fontSize: 23),),
    decoration: BoxDecoration(
      color: buttonColor1,
      borderRadius: BorderRadius.circular(30),
    ),
    width: buttonSize ?? MediaQuery.of(context).size.width,
    alignment: Alignment.center,
  );
}

InputDecoration formFieldDecoration  = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 11.0),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: buttonColor1, width: 1),
      borderRadius: BorderRadius.circular(15),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: buttonColor1, width: 1),
      borderRadius: BorderRadius.circular(15),
    ),
    hintStyle: TextStyle(color: buttonColor1),
    hintText: "Email",
    filled: true,
    fillColor: Colors.white,

    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(15),
    ),

    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(15),
    ),

);

