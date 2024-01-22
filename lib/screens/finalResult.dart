import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_quiz/constants/decoration.dart';
import 'package:mobile_quiz/screens/homeS/homescreen.dart';

class FinalResults extends StatefulWidget {
  final int correct;
  final int incorrect;
  final int total;
  FinalResults({@required this.correct, @required this.incorrect, @required this.total});

  @override
  _FinalResultsState createState() => _FinalResultsState();
}

class _FinalResultsState extends State<FinalResults> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:appBarColor2,
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(" ${widget.correct}/${widget.total}", style: TextStyle(fontSize: 25, color: Colors.white),),
                SizedBox(height: 8,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("you answered ${widget.correct <= 1 ? "${widget.correct} question" : "${widget.correct} questions"} correctly, ${widget.incorrect <= 1 ? "${widget.incorrect} question" : "${widget.incorrect} questions"} incorrectly and ${widget.total-(widget.correct+ widget.incorrect) <= 1 ? "${widget.total-(widget.correct+ widget.incorrect)} question": "${widget.total-(widget.correct+ widget.incorrect)} questions"} unanswered"
                    ,style: TextStyle(fontSize: 20, color: Colors.white),textAlign: TextAlign.center,),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 6),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamedAndRemoveUntil(context, HomeScreen.id, (route) => false);
                  },
                  child: button(context: context, textTitle: "GO TO HOME")),
              ],
            )
        ),
      ),
    );
  }
}
