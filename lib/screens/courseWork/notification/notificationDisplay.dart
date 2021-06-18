import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_quiz/backEnd/database.dart';
import 'package:mobile_quiz/constants/widgets.dart';
import 'package:mobile_quiz/widgets/loadingGeneral.dart';

class NotificationList extends StatefulWidget {

  final String levelIdGet;
  final String courseId;
  NotificationList({this.levelIdGet, this.courseId});

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  MyDatabaseServices myDatabaseServices = MyDatabaseServices();

  Stream getNotificationSnaps;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myDatabaseServices.loadNotification(levelCid: widget.levelIdGet, courseId: widget.courseId).then((value) {
      setState(() {
        getNotificationSnaps = value;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          child: StreamBuilder(
            stream: getNotificationSnaps,
            builder: (context, snaps){
              return  !snaps.hasData ? Center(child: LoadingGeneral()): ListView.builder(
                  itemCount: snaps.data.docs.length,
                  itemBuilder: (context, index){
                    return snaps.data.docs.length == 0 ? Center(child: Text("Empty")):Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${index + 1}.", style: TextStyle(color: Colors.black, fontSize: 22),),
                          Text(snaps.data.docs[index].data()['notification'], style: TextStyle(fontSize: 19),),
                          Text("Date posted: ${snaps.data.docs[index].data()['datePosted'].toString()}"),
                          Text("Time posted: ${snaps.data.docs[index].data()['timePosted'].toString()}")
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
