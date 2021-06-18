import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_quiz/backEnd/database.dart';
import 'package:mobile_quiz/backEnd/question_model.dart';
import 'package:mobile_quiz/constants/timerScoreKeeper.dart';
import 'package:mobile_quiz/constants/widgets.dart';
import 'package:mobile_quiz/screens/finalResult.dart';
import 'package:intl/intl.dart';


class QuizQuestionPage extends StatefulWidget {
  final String levId;
  final String courId;
  final String courseTitle;
  final String levelTitle;
  final String courseCode;
  final int timeGiven;


  QuizQuestionPage({this.levId, this.courId, this.courseTitle, this.levelTitle, this.courseCode, this.timeGiven});
  @override
  _QuizQuestionPageState createState() => _QuizQuestionPageState();
}

int _correct;
int _incorrect;
int _total;
int _counter = 0;


class _QuizQuestionPageState extends State<QuizQuestionPage> {

  String username;
  String userMatric;
  String level;
  Timer _timer;
  int quizCounter;

  void timerCounter()async{
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if(quizCounter > 0){
          quizCounter --;
         if(quizCounter==0){
           timerScoreKeeper.keepScore(levelTitle: widget.levelTitle, correct: _correct, courseCode: widget.courseCode, courseTitle: widget.courseTitle, level: level,username: username, userMatric: userMatric);
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
             return FinalResults(correct: _correct, incorrect: _incorrect, total: _total,);
           }));
         }
        }else{
          _timer.cancel();
        }
      });
    });
  }


  MyDatabaseServices myDatabaseServices = MyDatabaseServices();
  MyDataBaseMini myDataBaseMini = MyDataBaseMini();
  TimerScoreKeeper timerScoreKeeper = TimerScoreKeeper();
  FirebaseAuth auth = FirebaseAuth.instance;

  QuestionModel getQuestionsModels ({DocumentSnapshot documentSnapshot}){
    QuestionModel questionModel = QuestionModel();
    questionModel.questM = documentSnapshot.data()['question'];
    List<String>optionList = [
      documentSnapshot.data()['option1'],
      documentSnapshot.data()['option2'],
      documentSnapshot.data()['option3'],
      documentSnapshot.data()['option4'],
    ];
  //  optionList.shuffle(); //=====================

    questionModel.option1M = optionList[0];
    questionModel.option2M = optionList[1];
    questionModel.option3M = optionList[2];
    questionModel.option4M = optionList[3];
    questionModel.correctAnsM = documentSnapshot.data()['option1'];
    questionModel.answeredM = false;
    return questionModel;
  }
  Stream testing;



  @override
  void initState() {
    super.initState();
     _correct = 0;
     _incorrect = 0;
     _total = 0;
     quizCounter = widget.timeGiven;
     timerCounter();


    myDatabaseServices.questionUserTesting(levelCid: widget.levId, courseId: widget.courId).then((value){
      setState(() {
        testing = value;
      });
    });

    myDatabaseServices.getUserData(userId: auth.currentUser.uid).then((value) {
      setState(() {
        username = value.data()['name'].toString();
        userMatric = value.data()['matric no'].toString();
        level = value.data()['level'].toString();
      });
    });
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: backgroundColor2,
      appBar: AppBar(
        title: Text("${widget.courseTitle} Questions".toUpperCase(), style: TextStyle(color: buttonColor1, fontWeight: FontWeight.w600, fontSize: 16),),
        centerTitle: true,
        backgroundColor: backgroundColor2,
        elevation: 0.0,
        iconTheme: IconThemeData(color: buttonColor1),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right:10.0),
              child: Container(
                width: 40,
                decoration: BoxDecoration(
                  color: buttonColor1,
                  shape: BoxShape.circle,
                ),
                child: Center(child: Text("${quizCounter == null ? 0 : quizCounter}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center,)),
              ),
            ),
        ],
          // leading

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          if(_correct + _incorrect < _total){
           _showAlertD();
          }else{
            // ================================ADMIN SAVING SCORE==========================
         // var time = TimeOfDay.now();
          final now  = DateTime.now();

            DateTime datetime = DateTime.now();
//            int miLi = datetime.millisecondsSinceEpoch;
//            var date = DateTime.fromMillisecondsSinceEpoch(miLi);
            var formattedDate = DateFormat("EEEE, MMM d, y").format(datetime).toString();
            var newTime = DateFormat.jm().format(datetime);


            //======================================ADMIN USERLEVEL DATA  HERE=================================
            await myDataBaseMini.setAdminScoreLevelData(levelName: widget.levelTitle, mapData: <String, dynamic>{
              "level": widget.levelTitle,
            });
            await myDataBaseMini.setAdminForCourse(levelName: widget.levelTitle, courseName: widget.courseTitle, courseData: <String, dynamic>{"courseTitle": widget.courseTitle});
            //======================================ADMIN USER LEVEL  ENDS HERE=================================

            //=================UserSaving scores Data===================================
            await myDataBaseMini.storeUserScoreData(uid: auth.currentUser.uid, userData: <String, dynamic>{
              "UserId": auth.currentUser.uid,
            });
            //============================UserSaving scores Data ENDS HERE ================

            await myDatabaseServices.storeScoreAdmin(
              scoreMap: <String, dynamic>{
                "email": auth.currentUser.email,
                "matric_No": userMatric,
                "score": _correct,
                "date": formattedDate.toString(),
                "name": username,
                "level": level,
                "time": newTime.toString(),
              },
              levelName: widget.levelTitle, courseName: widget.courseTitle,
            );
            //===================================User saving score =============================
            await myDatabaseServices.storeUserScore(userScores: <String, dynamic>{
              "courseTitle": widget.courseTitle,
              "score": _correct,
              "time": newTime.toString(),
              "date":formattedDate.toString(),
            }, courseName: widget.courseTitle, userId: auth.currentUser.uid);
                  // set UserCourseName====================
            await myDatabaseServices.setUserCourseName(uid: auth.currentUser.uid, courseName: widget.courseTitle,
                courseData: <String, dynamic>{
              "courseTitle": widget.courseTitle,
               "courseID": auth.currentUser.uid,
                  "courseCode": widget.courseCode,
            });

            //=============================User ends here====================================
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
              return FinalResults(correct: _correct, incorrect: _incorrect, total: _total,);

            }));
          }
        },
        backgroundColor: buttonColor1,
        child: Icon(FontAwesomeIcons.marker, color: Colors.white,),
      ),
      body: Container(

      child: StreamBuilder(
          stream: testing,
          builder: (context, snaps){
            return !snaps.hasData ? Container(child: Center(child: CircularProgressIndicator( valueColor: AlwaysStoppedAnimation<Color>(appBarColor2),
              strokeWidth: 6,
              backgroundColor: buttonColor1,),),):
              ListView.builder(
            itemCount: snaps.data.docs.length,
            itemBuilder: (context, index){
              return StreamReturn(streamModel: getQuestionsModels(documentSnapshot: snaps.data.docs[index]), qIndex: index, totalQ: snaps.data.docs.length,);
            });
          }),
      ),
    );
  }
  _showAlertD(){
    return showDialog(
        barrierDismissible: false,
        context: context, builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text("Confirm Request", style: TextStyle(fontSize: 20),),
        content: Text("you have ${_total - (_correct + _incorrect)} Questions unanswered, do you want to proceed ? ", style: TextStyle(fontSize: 18),),
        actions: [
          InkWell(
              onTap: ()async{

                //=================Admin scores===================================
                DateTime datetime = DateTime.now();
//                int miLi = datetime.millisecondsSinceEpoch;
//                var date = DateTime.fromMillisecondsSinceEpoch(miLi);
                var formattedDate = DateFormat("EEEE, MMM d, y").format(datetime).toString();
                var newTime = DateFormat.jm().format(datetime);

                // ========================== set AminScoreLevel Data=======================
                await myDataBaseMini.setAdminScoreLevelData(levelName: widget.levelTitle, mapData: <String, dynamic>{
                  "level": widget.levelTitle,
                });
                await myDataBaseMini.setAdminForCourse(levelName: widget.levelTitle, courseName: widget.courseTitle, courseData: <String, dynamic>{"courseTitle": widget.courseTitle});
                //======================================ADMIN USERLEVEL DATA ENDS HERE=================================

                await myDatabaseServices.storeScoreAdmin(
                  scoreMap: <String, dynamic>{
                    "email": auth.currentUser.email,
                    "matric_No": userMatric,
                    "score": _correct,
                    "date": formattedDate,
                    "name": username,
                    "level": level,
                    "time": newTime.toString(),
                  },
                  levelName: widget.levelTitle, courseName: widget.courseTitle,
                );

                //=================UserSaving scores Data===================================
                await myDataBaseMini.storeUserScoreData(uid: auth.currentUser.uid, userData: <String, dynamic>{
                  "UserId": auth.currentUser.uid,
                });
                //============================UserSaving scores Data ENDS HERE ================

                //===================================User saving score =============================
                await myDatabaseServices.storeUserScore(userScores: <String, dynamic>{
                  "courseTitle": widget.courseTitle,
                  "score": _correct,
                  "time": newTime.toString(),
                  "date":formattedDate.toString(),
                }, courseName: widget.courseTitle, userId: auth.currentUser.uid);

                //=============================User ends here====================================

                    //Saving userCourse name===================================
                await myDatabaseServices.setUserCourseName(uid: auth.currentUser.uid, courseName: widget.courseTitle,
                    courseData: <String, dynamic>{
                      "courseTitle": widget.courseTitle,
                      "courseID": auth.currentUser.uid,
                      "courseCode": widget.courseCode,
                    });

                Navigator.pop(context);
                Navigator.pop(context);

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                  return FinalResults(correct: _correct, incorrect: _incorrect, total: _total,);
                }));
              },
              child: Text("Yes", style: TextStyle( fontSize: 23, fontWeight: FontWeight.w500),)),
          SizedBox(width: 40,),
          InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Text("No", style: TextStyle( fontSize: 23, fontWeight: FontWeight.w500),)),
        ],
      );
    });
  }

}

class StreamReturn extends StatefulWidget {
  final QuestionModel streamModel;
  final int qIndex;
  final int totalQ;
  StreamReturn({this.streamModel, this.qIndex, this.totalQ});
  @override
  _StreamReturnState createState() => _StreamReturnState();
}
class _StreamReturnState extends State<StreamReturn> {
  String optionToSelect = '';
  @override
  void setState(fn) {
    super.setState(fn);
    if(_counter ==_total){
      //===============================================================
    }
  }

@override
  void initState() {
    super.initState();
    _total = widget.totalQ;
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Text("Q${widget.qIndex + 1} ${widget.streamModel.questM}", style: TextStyle(
            color: Colors.black, fontSize: 18,
            wordSpacing: 3
          ),
            textAlign: TextAlign.start,
            softWrap: true,
          ),
          SizedBox(height: 14,),
        GestureDetector(
          onTap: (){
            if(widget.streamModel.answeredM == false){
              if(widget.streamModel.option1M == widget.streamModel.correctAnsM){
                setState(() {
                  optionToSelect = widget.streamModel.option1M;
                  widget.streamModel.answeredM = true;
                  _correct = _correct + 1;
                  _counter = _counter + 1;
                });
              }else{
                setState(() {
                  optionToSelect = widget.streamModel.option1M;
                  widget.streamModel.answeredM = true;
                  _incorrect = _incorrect + 1;
                  _counter = _counter + 1;
                });
              }
            }
          },
          child: optionGuide(
            option: 'A',
            optionSelected: optionToSelect,
            correctAnswer: widget.streamModel.correctAnsM,
            optionText: widget.streamModel.option1M,
          ),
        ),

          SizedBox(height: 17,),
          GestureDetector(
            onTap: (){
              if(widget.streamModel.answeredM==false){
                if(widget.streamModel.option2M == widget.streamModel.correctAnsM){
                  setState(() {
                    optionToSelect = widget.streamModel.option2M;
                    widget.streamModel.answeredM = true;
                    _correct = _correct + 1;
                    _counter = _counter + 1;

                  });
                }else{
                  setState(() {
                    optionToSelect = widget.streamModel.option2M;
                    widget.streamModel.answeredM = true;
                    _incorrect = _incorrect + 1;
                    _counter = _counter + 1;
                  });
                }
              }
            },
            child: optionGuide(
              option: 'B',
              optionSelected: optionToSelect,
              correctAnswer: widget.streamModel.correctAnsM,
              optionText: widget.streamModel.option2M,
            ),
          ),
          SizedBox(height: 17,),
          GestureDetector(
            onTap: (){
              if(widget.streamModel.answeredM==false){
                // check for correct answer
                if(widget.streamModel.option3M == widget.streamModel.correctAnsM){
                  setState(() {
                    optionToSelect = widget.streamModel.option3M;
                    widget.streamModel.answeredM = true;
                    _correct = _correct + 1;
                    _counter = _counter + 1;
                  });
                }else{
                  setState(() {
                    optionToSelect = widget.streamModel.option3M;
                    widget.streamModel.answeredM = true;
                    _incorrect = _incorrect + 1;
                    _counter = _counter + 1;
                  });
                }
              }
            },
            child: optionGuide(
              option: 'C',
              optionSelected: optionToSelect,
              correctAnswer: widget.streamModel.correctAnsM,
              optionText: widget.streamModel.option3M,
            ),
          ),
          SizedBox(height: 17,),
          GestureDetector(
            onTap: (){
              if(widget.streamModel.answeredM==false){
                if(widget.streamModel.option4M == widget.streamModel.correctAnsM){
                  setState(() {
                    optionToSelect = widget.streamModel.option4M;
                    widget.streamModel.answeredM = true;
                    _correct = _correct + 1;
                    _counter = _counter + 1;
                  });
                }else{

                  setState(() {
                    optionToSelect = widget.streamModel.option4M;
                    widget.streamModel.answeredM = true;
                    _incorrect = _incorrect + 1;
                    _counter = _counter + 1;
                  });
                }
              }
            },
            child: optionGuide(
              option: 'D',
              optionSelected: optionToSelect,
              correctAnswer: widget.streamModel.correctAnsM,
              optionText: widget.streamModel.option4M,
            ),
          ),
          SizedBox(height: 17,),
        ],
      ),
    );
  }
  Widget optionGuide({String option, final String optionSelected, final String optionText, final String correctAnswer}){
    return Container(
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            height: 25,
            width: 25,
            decoration: BoxDecoration(
                color: optionText == optionSelected ? optionSelected == correctAnswer ? Colors.green : Colors.red : Colors.grey,

                borderRadius: BorderRadius.circular(12),
                border: Border.all(width: 2,
                  color: optionText == optionSelected ? optionSelected == correctAnswer ? Colors.green : Colors.red : Colors.grey,
                  )),
            child: Text(option, style: TextStyle(
              color: optionText == optionSelected ? optionSelected == correctAnswer ? Colors.white : Colors.white : Colors.black,
//              color:  widget.streamModel.answeredM == true ? Colors.green : Colors.red,
            ),),
          ),
          SizedBox(width: 12,),
          Flexible(child: Text(optionText, textAlign: TextAlign.start,)),
        ],
      ),
    );
  }
}




