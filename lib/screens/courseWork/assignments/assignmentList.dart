import 'package:flutter/material.dart';
import 'package:mobile_quiz/backEnd/database.dart';
import 'package:mobile_quiz/constants/widgets.dart';
import 'package:mobile_quiz/widgets/loadingGeneral.dart';

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
  void initState() {
    // TODO: implement initState
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
      body: Container(
          width: MediaQuery.of(context).size.width,
          child: StreamBuilder(
            stream: assignSnap,
            builder: (context, snaps){
              return  !snaps.hasData ? Center(child: LoadingGeneral()): ListView.builder(
                  itemCount: snaps.data.docs.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      title: Text(snaps.data.docs[index].data()['assignDoc']),
                      subtitle: Column(
                        children: [
                          Text(snaps.data.docs[index].data()['timePosted'].toString()),
                          Text(snaps.data.docs[index].data()['time'].toString()),
                          Text("submit on ${snaps.data.docs[index].data()['submitDate'].toString()}"),

                        ],
                      ),
                    );
                  });
            },
          )
      ),
    );
  }
}
