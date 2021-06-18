import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_quiz/backEnd/authentication.dart';
import 'package:mobile_quiz/backEnd/database.dart';
import 'package:mobile_quiz/constants/widgets.dart';
import 'package:mobile_quiz/screens/aboutPage.dart';
import 'package:mobile_quiz/screens/accountSettings/myAccount.dart';
import 'package:mobile_quiz/screens/courseWork/coursesWorkFirstPage.dart';
import 'package:mobile_quiz/screens/myscores/myscoreHome.dart';
import 'package:mobile_quiz/sharedPrefs/userSharedPrefs.dart';
import 'package:mobile_quiz/userAuthentication/authenticationPage.dart';


class HomeScreen extends StatefulWidget {
  static const String id = "levelScreen";


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  MyAuthServices myAuthServices = MyAuthServices();
  MyDatabaseServices myDatabaseServices = MyDatabaseServices();
  Stream snapshotDetails;
  FirebaseAuth auth = FirebaseAuth.instance;

  String currentLevel;
  String userName;
  String userMatricNo;

  getUserLevel()async{
    String userLevel = await UserPreference.getUserLoggedLevel();

    myDatabaseServices.displayLevels(userLevelName: "$userLevel").then((value) {
      setState(() {
        snapshotDetails = value;
      });
    });
    currentLevel = await UserPreference.getUserLoggedLevel();
    userName = await UserPreference.getUserLoggedName();
    userMatricNo = await UserPreference.getUserLoggedMatricNo();

    setState(() {

    });
  }

  @override
  void initState(){
    super.initState();
    getUserLevel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appB,
        appBar: AppBar(
          backgroundColor: appB,
          elevation: 0.0,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: GestureDetector(
                  onTap: (){
                    _showDialog();
                  },
                  child: Icon(Icons.logout, color: buttonColor1, size: 25,)),
            ),
          ],
        ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.5,
              alignment: Alignment.topLeft,
              color: appB,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: buttonColor1,
                      ),
                    ),
                    SizedBox(height: 8,),
                    Flexible(child: Text("${userName == "" || userName == null ? "" : userName.toUpperCase()}", style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: buttonColor1), overflow: TextOverflow.ellipsis, maxLines: 1, )),
                    SizedBox(height: 10,),
                    Flexible(child: Text("${userMatricNo == "" || userMatricNo == null ? "" : userMatricNo}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: buttonColor1),)),
                    SizedBox(height: 10,),
                    Flexible(child: Text("${currentLevel == "" || currentLevel == null ? "" : currentLevel}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: buttonColor1),)),

                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: backgroundColor2,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(25), topLeft: Radius.circular(25))
                ),
                child: Column(
                  children: [
                    Expanded(child:
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: StreamBuilder(
                                  stream: snapshotDetails,
                                  builder: (context, snapshot){
                                    return snapshot.data == null ? Container(
                                      child: Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(appBarColor2),
                                        strokeWidth: 6,
                                        backgroundColor: buttonColor1,)),
                                    ):

                                    Snaps(quizName: "${snapshot.data.docs[0].data()['levelName']} Course Work", dId: snapshot.data.docs[0].id,
                                    levelName: snapshot.data.docs[0].data()['levelName'],);

                                  }),
                            ),
                          ),

                          NewContainer(title: "My Scores", icon: FontAwesomeIcons.check, onTapFunc: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return MyScoreHome();
                            }));
                          },),

                        ],
                      ),
                    )),
                    Expanded(child:
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          NewContainer(title: "Account Settings", icon: Icons.settings, onTapFunc: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return MyAccount();
                            }));
                          },),
                          NewContainer(title: "About", icon: Icons.info, onTapFunc: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return AboutPage();
                            }));
                          },),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),

    );

  }
  _showDialog(){
    return showDialog(
        barrierDismissible: false,
        context: context, builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text("Confirm Request", style: TextStyle(fontSize: 20),),
        content: Text("Are you sure you want to logout? ", style: TextStyle(fontSize: 18),),
        actions: [
          InkWell(
              onTap: ()async{
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AuthenticationPage()), (route) => false);
                await  myAuthServices.signInOut();
                await UserPreference.setUserLoggedPreference(logPrefs: false);
              },
              child: Text("Yes", style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),)),
          SizedBox(width: 40,),
          InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Text("No", style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),)),
        ],
      );
    });
  }
  }


class NewContainer extends StatelessWidget {
  final String title;
  final Function onTapFunc;
  final IconData icon;
  NewContainer({this.title, this.onTapFunc, this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: GestureDetector(
      onTap: onTapFunc,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          child: Center(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white54, size: 25,),
                SizedBox(height: 10,),
                Flexible(child: Text("$title", style: TextStyle(color: Colors.white54, fontSize: 15, fontWeight: FontWeight.w500,), textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, maxLines: 2,)),
              ],
            ),
          )),
          decoration: BoxDecoration(
            color: buttonColor1,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    )
    );
  }
}




class Snaps extends StatelessWidget {
  final String quizName;
  final String dId;
  final String levelName;

  Snaps({@required this.quizName, this.dId, this.levelName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return CoursesWorkFirstPage(levelsId: dId, docName: quizName,levelName: levelName, );
        }));
      },
      child: Container(
        padding: const EdgeInsets.all(6.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: buttonColor1,
          ),
          alignment: Alignment.center,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(FontAwesomeIcons.book, color: Colors.white54, size: 25,),
              SizedBox(height: 10,),
              Flexible(child: Text("$quizName", style: TextStyle(color: Colors.white54, fontSize: 15, fontWeight: FontWeight.w500,), textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, maxLines: 2,)),
            ],
          ),
        ),
      ),
    );
  }
}