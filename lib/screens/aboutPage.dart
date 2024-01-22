import 'package:flutter/material.dart';
import 'package:mobile_quiz/constants/decoration.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      body: Container(
        child: Center(child: Text("Coming Soon...", style: TextStyle(color: Colors.redAccent),)),
      ),
    );
  }
}
