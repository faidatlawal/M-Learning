//
//import 'package:flutter/material.dart';
//class OptionGuide extends StatefulWidget {
//  final String option;
//  final String optionText;
//  final String correctAnswer;
//  final String optionSelected;
//  OptionGuide({this.option, this.optionSelected, this.optionText, this.correctAnswer});
//  @override
//  _OptionGuideState createState() => _OptionGuideState();
//}
//
//class _OptionGuideState extends State<OptionGuide> {
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: Row(
//        children: [
//          Container(
//            alignment: Alignment.center,
//            height: 25,
//            width: 25,
//            decoration: BoxDecoration(
//                color: widget.optionText == widget.optionSelected ? widget.optionSelected == widget.correctAnswer ? Colors.green : Colors.red : Colors.grey,
//                borderRadius: BorderRadius.circular(30),
//            border: Border.all(width: 2, color: widget.optionText == widget.optionSelected ? widget.optionSelected == widget.correctAnswer ? Colors.green : Colors.red : Colors.grey,)),
//            child: Text(widget.option, style: TextStyle(color: widget.optionText == widget.optionSelected ? widget.optionSelected == widget.correctAnswer ? Colors.white : Colors.white : Colors.black,),),
//          ),
//          SizedBox(width: 12,),
//          Text(widget.optionText),
//        ],
//      ),
//    );
//  }
//}
//
