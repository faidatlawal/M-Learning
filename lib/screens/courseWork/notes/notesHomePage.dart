import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_quiz/constants/widgets.dart';
import 'package:mobile_quiz/screens/courseWork/notes/courseNotes.dart';

class NoteHomePage extends StatefulWidget {
  final String levelIDs;
  final Stream noteStream;


  const NoteHomePage({this.levelIDs, this.noteStream,});

  @override
  _NoteHomePageState createState() => _NoteHomePageState();
}

class _NoteHomePageState extends State<NoteHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      appBar: AppBar(
        elevation: 0.0,
        title: Text("NOTES", style: TextStyle(color: buttonColor1),),
        iconTheme: IconTheme.of(context).copyWith(color: buttonColor1),
        backgroundColor: appB,
      ),

    body: Container(
      margin: EdgeInsets.only(top: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: StreamBuilder(
            stream: widget.noteStream,
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
                        color: Colors.white,
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              //=============================================
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return CourseNotes(courseId: snapshot.data.docs[index].data()['courseId'], levelIdGet: widget.levelIDs,);
                              }),);
                            });
                          },
                          child: ListTile(
                            title: Center(
                              child: Text(snapshot.data.docs[index].data()['courseCode'], style: TextStyle(color: buttonColor1, fontSize: 21, fontWeight: FontWeight.w500),
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
