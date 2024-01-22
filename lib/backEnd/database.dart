import 'package:cloud_firestore/cloud_firestore.dart';


class MyDatabaseServices{
  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;


Future getCourseList({String levelIdL})async{
    return firebaseFireStore.collection('Levels').doc(levelIdL).collection('Courses').snapshots();
}

Future displayLevels({String userLevelName})async{
    return  firebaseFireStore.collection('Levels').where("levelName", isEqualTo: userLevelName).snapshots();
  }

  Future questionUserTesting({String levelCid, String courseId, })async{
    return  firebaseFireStore.collection('Levels').doc(levelCid).collection('Courses').doc(courseId).collection('Questions').snapshots();
  }



  Future <void> setUserData({Map docData, String userId})async{
    firebaseFireStore.collection('Users').doc(userId).set(docData).catchError((error) => print(error.toString()));
  }

  Future getLevelListFromDb()async{
    return await firebaseFireStore.collection('Levels').get();
  }

  //used in three places and to be removed
  Future getUserData({String userId})async{
    return await firebaseFireStore.collection('Users').doc(userId).get();
  }




  Future storeUserByLevel({String levelName, String userID, Map userDoc})async{
     firebaseFireStore.collection("UserByLevel").doc(levelName).collection("Users").doc(userID).set(userDoc);
  }

  Future storeScoreAdmin({Map scoreMap, String levelName, String courseName, String thirdID})async{
    firebaseFireStore.collection("AdminScores").doc(levelName).collection("Course").doc(courseName).collection("Scores").add(scoreMap);
  }

  Future storeUserScore({Map userScores, String courseName, String userId})async{
    firebaseFireStore.collection('UserScores').doc(userId).collection("Course").doc(courseName).collection("Scores").add(userScores);
  }

  Future setUserCourseName({String uid, String courseName, Map courseData})async{
    firebaseFireStore.collection("UserScores").doc(uid).collection("Course").doc(courseName).set(courseData);
  }

  Future getUserScoreCourse({String uid})async{
    return  firebaseFireStore.collection("UserScores").doc(uid).collection("Course").snapshots();
  }

  Future getUserScore({String uid, String courseName,})async{
    return  firebaseFireStore.collection("UserScores").doc(uid).collection("Course").doc(courseName).collection("Scores").orderBy("dateOrder", descending: true).snapshots();
  }

  Future loadLectureNotes({String levelCid, String courseId, })async{
    return  firebaseFireStore.collection('Levels').doc(levelCid).collection('Courses').doc(courseId).collection('lectureNotes').snapshots();
  }

  Future loadAssignments({String levelCid, String courseId, })async{
    return  firebaseFireStore.collection('Levels').doc(levelCid).collection('Courses').doc(courseId).collection('Assignments').snapshots();
  }

  Future loadPastQ({String levelCid, String courseId, })async{
    return  firebaseFireStore.collection('Levels').doc(levelCid).collection('Courses').doc(courseId).collection('pastQuestions').snapshots();
  }

  Future loadNotification({String levelCid, String courseId, })async{
    return  firebaseFireStore.collection('Levels').doc(levelCid).collection('Courses').doc(courseId).collection('Notifications').snapshots();
  }

}


//=======================================================================

class MyDataBaseMini{
  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

  Future setAdminScoreLevelData({String levelName, Map mapData})async{
    firebaseFireStore.collection("AdminScores").doc(levelName).set(mapData);
  }
  Future setAdminForCourse({String levelName, String courseName, Map courseData})async{
    firebaseFireStore.collection("AdminScores").doc(levelName).collection("Course").doc(courseName).set(courseData);
  }

  Future userByLevelData({String levelName, Map levelMap})async{
    firebaseFireStore.collection("UserByLevel").doc(levelName).set(levelMap);
  }

  Future storeUserScoreData({String uid, Map userData})async{
    firebaseFireStore.collection("UserScores").doc(uid).set(userData);
  }
}