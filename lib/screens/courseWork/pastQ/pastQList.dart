import 'package:flutter/material.dart';
import 'package:mobile_quiz/backEnd/database.dart';
import 'package:mobile_quiz/constants/widgets.dart';
import 'package:mobile_quiz/widgets/loadingGeneral.dart';

class PastQList extends StatefulWidget {

  final String levelIdGet;
  final String courseId;
  PastQList({this.levelIdGet, this.courseId});

  @override
  _PastQListState createState() => _PastQListState();
}

class _PastQListState extends State<PastQList> {
  MyDatabaseServices myDatabaseServices = MyDatabaseServices();

  Stream getPastSnaps;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myDatabaseServices..loadPastQ(levelCid: widget.levelIdGet, courseId: widget.courseId).then((value) {
      setState(() {
        getPastSnaps = value;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          child: StreamBuilder(
            stream: getPastSnaps,
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
