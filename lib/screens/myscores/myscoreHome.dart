import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_quiz/backEnd/database.dart';
import 'package:mobile_quiz/constants/widgets.dart';
import 'package:mobile_quiz/screens/myscores/IndividualScore.dart';
import 'package:mobile_quiz/widgets/loadingGeneral.dart';


class MyScoreHome extends StatefulWidget {
  @override
  _MyScoreHomeState createState() => _MyScoreHomeState();
}

class _MyScoreHomeState extends State<MyScoreHome> {

  MyDatabaseServices myDatabaseServices = MyDatabaseServices();
  FirebaseAuth auth = FirebaseAuth.instance;
  Stream getCourse;
  String name;
  String courseNameFromCard;


  userCourseMethod(){
    myDatabaseServices.getUserScoreCourse(uid: auth.currentUser.uid).then((value) {
      setState(() {
        getCourse = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    userCourseMethod();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBarColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0.0,
        title: Text("My Scores", style: TextStyle(fontSize: 18, color: buttonColor1, fontWeight: FontWeight.w500),
        ),
        iconTheme: IconThemeData(color: buttonColor1),
      ),
      body: Container(
        child: StreamBuilder(
            stream: getCourse,
            builder: (context, snap){
              return !snap.hasData ? Center(child: LoadingGeneral()):
              Container(
                decoration: BoxDecoration(
                    color: buttonColor1,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                      physics: BouncingScrollPhysics(),
                      itemCount: snap.data.docs.length,
                      itemBuilder: (context, index){
                      // ====================================NEEDS CHECKING =================================
                        return snap.data.docs.isEmpty ? Center(child: Text("No course available", style: TextStyle(color: Colors.white),)): GestureDetector(
                          onTap: (){
                            setState(() {
                             //=============================================
                              courseNameFromCard = snap.data.docs[index].data()["courseTitle"];
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return IndividualScore(courseName: courseNameFromCard,);
                              }));
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Container(
                            //  width: 175,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     Flexible(
                                       child: Text(snap.data.docs[index].data()["courseTitle"],style: TextStyle(fontWeight: FontWeight.bold),
                                       overflow: TextOverflow.ellipsis, maxLines: 2, textAlign: TextAlign.center,),
                                     ),
                                     SizedBox(height: 4,),
                                     Flexible(child: Text(snap.data.docs[index].data()["courseCode"],style: TextStyle(fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,),
                                     ),
                                   ],
                                 ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              );
            }),

      ),
    );
  }
}
