import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_quiz/constants/widgets.dart';
import 'package:mobile_quiz/screens/courseWork/notification/notificationDisplay.dart';

class NotificationScreen extends StatefulWidget {
  final String levelIDs;
  final Stream notificationStream;


  const NotificationScreen({this.levelIDs, this.notificationStream,});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NOTIFICATION", style: TextStyle(color: buttonColor1),),
        iconTheme: IconTheme.of(context),
        backgroundColor: appBarColor,
        elevation: 0.0,
      ),

      body: Container(
        margin: EdgeInsets.only(top: 10),
        color: backgroundColor1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: StreamBuilder(
              stream: widget.notificationStream,
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
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          color: Colors.brown,
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                //=============================================
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return NotificationList(courseId: snapshot.data.docs[index].data()['courseId'], levelIdGet: widget.levelIDs,);
                                }));
                              });
                            },
                            child: ListTile(
                              title: Center(
                                child: Text(snapshot.data.docs[index].data()['courseCode'], style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.w500),
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
