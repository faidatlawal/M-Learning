import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_quiz/backEnd/database.dart';
import 'package:mobile_quiz/constants/decoration.dart';
import 'package:mobile_quiz/widgets/loadingGeneral.dart';


class IndividualScore extends StatefulWidget {

  final String courseName;
  const IndividualScore({this.courseName});
  @override
  _IndividualScoreState createState() => _IndividualScoreState();
}

class _IndividualScoreState extends State<IndividualScore> {
  Stream userScoreGet;
  MyDatabaseServices myDatabaseServices = MyDatabaseServices();
  FirebaseAuth auth = FirebaseAuth.instance;

  userScore(){
    myDatabaseServices.getUserScore(uid: auth.currentUser.uid, courseName:widget.courseName).then((value) {
      setState(() {
        userScoreGet = value;
      });
    });
  }



  @override
  void initState() {
    super.initState();
    userScore();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0.0,
        title: Text(widget.courseName.isEmpty || widget.courseName == "" ? "" : widget.courseName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: buttonColor1),),
        iconTheme: IconThemeData(color: buttonColor1),
      ),
        body: SafeArea(
          child: Container(
            child: StreamBuilder(
                stream: userScoreGet,
                builder: (context, snap){
                  return !snap.hasData ? Center(child: Container(child: LoadingGeneral(),)):ListView.builder(
                      itemCount: snap.data.docs.length,
                      itemBuilder: (context, index){
                        return Card(
                          color: buttonColor1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                          ),
                          child: Column(
                            children: [
                              Container(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5, right: 5),
                                    child: Text("Score", style: TextStyle(color: Colors.white54, fontSize: 16, fontWeight: FontWeight.w500),),
                                  ),
                              ),
                              ListTile(
                                title: Text(snap.data.docs[index].data()['date'].toString(), style: TextStyle(color: Colors.white54),),
                                subtitle: Text(snap.data.docs[index].data()['time'].toString(), style: TextStyle(color: Colors.white54),),
                                trailing: Text("${snap.data.docs[index].data()['score'].toString()}", style: TextStyle(fontSize: 20, color: appBarColor, fontWeight: FontWeight.bold),),
                              ),
                            ],
                          ),
                        );
                      });
                }),
          ),
        ));
  }
}
