import 'package:flutter/material.dart';
import 'package:mobile_quiz/backEnd/database.dart';
import 'package:mobile_quiz/constants/decoration.dart';
import 'package:mobile_quiz/widgets/loadingGeneral.dart';
import '../displayPDF.dart';

class AssignmentList extends StatefulWidget {

  final String levelIdGet;
  final String courseId;
  AssignmentList({this.levelIdGet, this.courseId});

  @override
  _AssignmentListState createState() => _AssignmentListState();
}

class _AssignmentListState extends State<AssignmentList> {
  MyDatabaseServices myDatabaseServices = MyDatabaseServices();

  Stream assignSnap;
  @override
  void initState(){
    super.initState();
    myDatabaseServices.loadAssignments(levelCid: widget.levelIdGet, courseId: widget.courseId).then((value) {
      setState(() {
        assignSnap = value;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      appBar: AppBar(
        title: Text("Assignments", style: TextStyle(color: buttonColor1),),
        backgroundColor: backgroundColor2,
        elevation: 0.0,
        iconTheme: IconThemeData(color: buttonColor1),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          child: StreamBuilder(
            stream: assignSnap,
            builder: (context, snaps){
              return  !snaps.hasData ? Center(child: LoadingGeneral()): ListView.builder(
                  itemCount: snaps.data.docs.length,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: buttonColor1,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return DisplayPdf(fileUrl: snaps.data.docs[index].data()['assignPdf'], courseCode: snaps.data.docs[index].data()['courseCode']);
                            }));
                          },
                          child: ListTile(
                            title: Text("Submit on: ${snaps.data.docs[index].data()['submitDate']}", style: TextStyle(color: Colors.white), maxLines: 1, overflow: TextOverflow.ellipsis,),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(snaps.data.docs[index].data()['timePosted'].toString(), style: TextStyle(color: Colors.white),),
                                Text(snaps.data.docs[index].data()['time'].toString(), style: TextStyle(color: Colors.white),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            },
          )
      ),
    );
  }
}
