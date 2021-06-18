import 'package:flutter/material.dart';
import 'package:mobile_quiz/constants/widgets.dart';
import 'package:mobile_quiz/userAuthentication/login.dart';
import 'package:mobile_quiz/userAuthentication/register.dart';

class AuthenticationPage extends StatefulWidget {
  static const String id = "home";
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height/6,),
            Padding(
              padding: const EdgeInsets.only(top:8.0, bottom: 35),
              child: Image.asset("assets/images/ml.png", height: 130, width: 130, color: buttonColor1,),
            ),
           GestureDetector(
               onTap: (){
                 Navigator.pushNamed(context, Login.id);
               },
               child: button(context: context, textTitle: "Login",)
           ),
        SizedBox(height: 20,),
        GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, Register.id);
            },
            child: button(context: context, textTitle: "Register")),
          ],
        ),
      ),
    );
  }
}
