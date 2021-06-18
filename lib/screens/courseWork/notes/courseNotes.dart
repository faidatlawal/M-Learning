import 'package:flutter/material.dart';
import 'package:mobile_quiz/backEnd/database.dart';
import 'package:mobile_quiz/constants/widgets.dart';
import 'package:mobile_quiz/widgets/loadingGeneral.dart';

class CourseNotes extends StatefulWidget {

  final String levelIdGet;
  final String courseId;
  CourseNotes({this.levelIdGet, this.courseId});

  @override
  _CourseNotesState createState() => _CourseNotesState();
}

class _CourseNotesState extends State<CourseNotes> {
  MyDatabaseServices myDatabaseServices = MyDatabaseServices();

  Stream getNotesSnaps;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myDatabaseServices.loadLectureNotes(levelCid: widget.levelIdGet, courseId: widget.courseId).then((value) {
      setState(() {
        getNotesSnaps = value;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(
          stream: getNotesSnaps,
          builder: (context, snaps){
            return  !snaps.hasData ? Center(child: LoadingGeneral()): ListView.builder(
                itemCount: snaps.data.docs.length,
                itemBuilder: (context, index){
              return ListTile(
                title: Text(snaps.data.docs[index].data()['assignDoc']),
                subtitle: Text(snaps.data.docs[index].data()['timePosted'].toString()),
              );
            });
          },
        )
      ),
    );
  }
}
