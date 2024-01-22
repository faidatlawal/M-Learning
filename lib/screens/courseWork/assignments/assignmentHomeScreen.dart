import 'package:flutter/material.dart';
import 'package:mobile_quiz/constants/decoration.dart';
import 'package:mobile_quiz/screens/courseWork/assignments/assignmentList.dart';

class AssignmentHomeScreen extends StatefulWidget {
  final String levelIDs;
  final Stream assignmentStream;

  const AssignmentHomeScreen({this.levelIDs, this.assignmentStream});

  @override
  _AssignmentHomeScreenState createState() => _AssignmentHomeScreenState();
}

class _AssignmentHomeScreenState extends State<AssignmentHomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ASSIGNMENTS", style: TextStyle(color: buttonColor1),),
        iconTheme: IconThemeData(color: buttonColor1),
        backgroundColor: appBarColor,
        elevation: 0.0,
      ),

      body: Container(
        margin: EdgeInsets.only(top: 10),
        color: backgroundColor1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: StreamBuilder(
              stream: widget.assignmentStream,
              builder: (context, snapshot){
                return snapshot.data == null ? Container(
                  child: Center(child: CircularProgressIndicator(  valueColor: AlwaysStoppedAnimation<Color>(appBarColor2),
                    strokeWidth: 6,
                    backgroundColor: buttonColor1,),),
                ): GridView.builder(
                  scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                        ),
                          elevation: 2.0,
                          color: Colors.grey.shade800,
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                //=============================================
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return AssignmentList(courseId: snapshot.data.docs[index].data()['courseId'], levelIdGet: widget.levelIDs,);
                                }));
                              });
                            },
                            child: ListTile(
                              title: Center(
                                child: Text(snapshot.data.docs[index].data()['courseCode'], style: TextStyle(color: Colors.white70, fontSize: 21, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              }),
        ),
      ),
    );
  }
}
