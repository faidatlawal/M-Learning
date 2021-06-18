import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:mobile_quiz/backEnd/database.dart';
import 'package:mobile_quiz/constants/widgets.dart';
import 'package:mobile_quiz/screens/courseWork/assignments/assignmentHomeScreen.dart';
import 'package:mobile_quiz/screens/courseWork/notes/notesHomePage.dart';
import 'package:mobile_quiz/screens/courseWork/notification/noticationScreen.dart';
import 'package:mobile_quiz/screens/courseWork/pastQ/pastQHomeScreen.dart';
import 'package:mobile_quiz/screens/quizQuestionPage.dart';
enum Page {records, services}

class CoursesWorkFirstPage extends StatefulWidget {
  final String levelsId;
  final String docName;
  final String levelName;
  CoursesWorkFirstPage({this.levelsId, this.docName, this.levelName});
  @override
  _CoursesWorkFirstPageState createState() => _CoursesWorkFirstPageState();
}

class _CoursesWorkFirstPageState extends State<CoursesWorkFirstPage> {
  MyDatabaseServices myDatabaseServices = MyDatabaseServices();
  Stream allCourses;
  Page _selectedPage = Page.records;
  Color active = appB;
  MaterialColor notActive = Colors.grey;
  String courseId;
  String courseCode;
  String courseTitle;

  @override
  void initState() {
    super.initState();
    myDatabaseServices.getCourseList(levelIdL: widget.levelsId).then((value) {
      setState(() {
        allCourses = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      appBar: AppBar(
        iconTheme: IconTheme.of(context).copyWith(color: appB),
        title: Row(
          children: <Widget>[
            Expanded(
                child: FlatButton.icon(
                    onPressed: () {
                      setState(() => _selectedPage = Page.records);
                    },
                    icon: Icon(
                      Icons.dashboard,
                      color: _selectedPage == Page.records ? active : notActive,
                    ),
                    label: Text('QUIZ', style: TextStyle(color:  _selectedPage == Page.records ? active : notActive, fontWeight: FontWeight.bold),))),
            Expanded(
                child: FlatButton.icon(
                    onPressed: () {
                      setState(() => _selectedPage = Page.services);
                    },
                    icon: Icon(
                      Icons.sort,
                      color:
                      _selectedPage == Page.services ? active : notActive,
                    ),
                    label: Text('NOTES', style: TextStyle(color: _selectedPage == Page.services ? active : notActive, fontWeight: FontWeight.bold),),
                ),
            ),
          ],
        ),
        elevation: 0.0,
        backgroundColor: buttonColor1,
      ),
      body: _loadScreen()
    );
  }


  Widget _loadScreen() {
    switch (_selectedPage) {
      case Page.records:
        return Container(
          margin: EdgeInsets.only(top: 10),
          child: StreamBuilder(
              stream: allCourses,
              builder: (context, snapshot){
                return snapshot.data == null ? Container(
                  child: Center(child: CircularProgressIndicator(  valueColor: AlwaysStoppedAnimation<Color>(appBarColor2),
                    strokeWidth: 6,
                    backgroundColor: buttonColor1,),),
                ): ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index){
                      return CourseCard(title:snapshot.data.docs[index].data()['courseTitle'], code: snapshot.data.docs[index].data()['courseCode'], levelIdGet: widget.levelsId, docIdGet: snapshot.data.docs[index].id, levelTitle: widget.docName, timeTaken: snapshot.data.docs[index].data()['timeTaken'],
                      );
                    });
              }),
        );
        break;
      case Page.services :
        return Column(
          children: <Widget>[
           Padding(
             padding: const EdgeInsets.all(10.0,),
             child: Container(
               height: 22,
               child: Marquee(text: "${widget.levelName} COURSE ACTIVITIES", style: TextStyle(color: buttonColor1, fontSize: 20),
                 scrollAxis: Axis.horizontal,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 blankSpace: 20,
               ),
             ),
           ),
            SizedBox(height: 30,),
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: <Widget>[

                  CourseActivitiesCard(context: context, levelID: widget.levelsId, allCourses: allCourses, textString: "LECTURE NOTES",
                  onPressedFunction: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return NoteHomePage(levelIDs: widget.levelsId, noteStream: allCourses,);
                    }));
                  },),

                  CourseActivitiesCard(context: context, levelID: widget.levelsId, allCourses: allCourses, textString: "ASSIGNMENTS",
                  onPressedFunction:  (){Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return AssignmentHomeScreen(levelIDs: widget.levelsId, assignmentStream: allCourses,);
                      }),);},
                  ),

                  CourseActivitiesCard(context: context, levelID: widget.levelsId, allCourses: allCourses, textString: "PAST QUESTIONS",
                    onPressedFunction:  (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return PastQHomeScreen(levelIDs: widget.levelsId, pastQStream: allCourses,);
                      }));
                    },),

                  CourseActivitiesCard(context: context, levelID: widget.levelsId, allCourses: allCourses, textString: "NOTIFICATIONS",
                  onPressedFunction: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return NotificationScreen(levelIDs: widget.levelsId, notificationStream: allCourses,);
                    }));
                  },),

                ],
              ),
            ),
          ],
        );
        break;
      default:
        return Container();
    }
  }
}

class CourseActivitiesCard extends StatelessWidget {
  final BuildContext context;
  final levelID;
  final Stream allCourses;
  final Function onPressedFunction;
  final String textString;
  const CourseActivitiesCard({@required this.context, @required this.levelID, @required this.allCourses, @required this.onPressedFunction, @required this.textString});



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius:BorderRadius.circular(10) ),
          color: buttonColor1,
          child:  FlatButton(
                  onPressed: onPressedFunction,
                  child: Text(textString, style: TextStyle(color: appB, fontWeight: FontWeight.bold),)),
              ),
      ),
    );
  }
}

class CourseCard extends StatefulWidget {
  final String title;
  final  String code;
  final String levelIdGet;
  final String docIdGet;
  final String levelTitle;
  final int timeTaken;


  CourseCard({this.title, this.code, this.levelIdGet, this.docIdGet, this.levelTitle, this.timeTaken});
  @override
  _CourseCardState createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor1,
      child: GestureDetector(
        onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return QuizQuestionPage(levId: widget.levelIdGet, courId: widget.docIdGet, courseTitle: widget.title, levelTitle: widget.levelTitle, courseCode: widget.code, timeGiven: widget.timeTaken,);
              }));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: ListTile(
            leading: CircleAvatar(
              radius: 24,
              child: Text(widget.title[0].toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w500),
              ),
              backgroundColor: iconC1,
            ),
            title: Text(widget.title, style: TextStyle(color: buttonColor1, fontSize: 21, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(widget.code, style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}



