import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:mobile_quiz/backEnd/database.dart';

class TimerScoreKeeper{
  MyDatabaseServices myDatabaseServices = MyDatabaseServices();
  MyDataBaseMini myDataBaseMini = MyDataBaseMini();
  FirebaseAuth auth = FirebaseAuth.instance;
  void keepScore({String levelTitle, String courseTitle, String userMatric, int correct, String username, String level, String courseCode})async{




// ================================ADMIN SAVING SCORE==========================
// var time = TimeOfDay.now();
    final now  = DateTime.now();

    DateTime datetime = DateTime.now();
//            int miLi = datetime.millisecondsSinceEpoch;
//            var date = DateTime.fromMillisecondsSinceEpoch(miLi);
    var formattedDate = DateFormat("EEEE, MMM d, y").format(datetime).toString();
    var newTime = DateFormat.jm().format(datetime);


//======================================ADMIN USERLEVEL DATA  HERE=================================
    await myDataBaseMini.setAdminScoreLevelData(levelName: levelTitle, mapData: <String, dynamic>{
      "level": levelTitle,
    });
    await myDataBaseMini.setAdminForCourse(levelName: levelTitle, courseName: courseTitle, courseData: <String, dynamic>{"courseTitle":courseTitle});
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
        "score": correct,
        "date": formattedDate.toString(),
        "name": username,
        "level": level,
        "time": newTime.toString(),
      },
      levelName: levelTitle, courseName: courseTitle,
    );
//===================================User saving score =============================
    await myDatabaseServices.storeUserScore(userScores: <String, dynamic>{
      "courseTitle": courseTitle,
      "score": correct,
      "time": newTime.toString(),
      "date":formattedDate.toString(),
    }, courseName: courseTitle, userId: auth.currentUser.uid);
// set UserCourseName====================
    await myDatabaseServices.setUserCourseName(uid: auth.currentUser.uid, courseName: courseTitle,
        courseData: <String, dynamic>{
          "courseTitle": courseTitle,
          "courseID": auth.currentUser.uid,
          "courseCode": courseCode,
        });
  }

}