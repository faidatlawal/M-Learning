import 'package:flutter/material.dart';
import 'package:mobile_quiz/backEnd/database.dart';
import 'package:mobile_quiz/constants/decoration.dart';
import 'package:mobile_quiz/widgets/loadingGeneral.dart';
import '../displayPDF.dart';

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
      appBar: AppBar(
        title: Text("Past Questions", style: TextStyle(color: buttonColor1),),
        backgroundColor: backgroundColor2,
        elevation: 0.0,
        iconTheme: IconThemeData(color: buttonColor1),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          child: StreamBuilder(
            stream: getPastSnaps,
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
                              return DisplayPdf(fileUrl: snaps.data.docs[index].data()['noteDoc'], courseCode: snaps.data.docs[index].data()['courseCode']);
                            }));
                          },
                          child: ListTile(
                            title: Text(snaps.data.docs[index].data()['comment'], style: TextStyle(color: Colors.white), maxLines: 1, overflow: TextOverflow.ellipsis,),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(snaps.data.docs[index].data()['datePosted'].toString(), style: TextStyle(color: Colors.white),),
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
