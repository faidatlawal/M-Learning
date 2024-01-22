import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_quiz/backEnd/authentication.dart';
import 'package:mobile_quiz/backEnd/database.dart';
import 'package:mobile_quiz/constants/decoration.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  MyAuthServices myAuthServices = MyAuthServices();
  FirebaseAuth auth = FirebaseAuth.instance;
  MyDatabaseServices myDatabaseServices = MyDatabaseServices();
  String name;
  String matric;
  String gender;
  String level;
  String registerDate;
  String email;
  String date;
  String emp = " ";
  String time;

  getUS() {
    myDatabaseServices.getUserData(userId: auth.currentUser.uid).then((value) {
      setState(() {
        name = value.data()['name'].toString().toUpperCase();
        matric = value.data()["matric no"].toString();
        level = value.data()["level"].toString();
        email = value.data()["email"].toString();
        gender = value.data()["gender"].toString();
        date = value.data()["register_date"].toString();
        time = value.data()["time"].toString();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUS();
    //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.brown.shade500));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appB,
      appBar: AppBar(
        backgroundColor: appB,
        elevation: 0.0,
        iconTheme: IconThemeData(color: buttonColor1),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${name == "" || name == null ? "" : name.toUpperCase()}",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: buttonColor1),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              matric == null ? "" : matric.toString(),
              style: TextStyle(color: buttonColor1, fontSize: 10),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "Joined on: ${date == null ? "" : date.toString()}",
              style: TextStyle(color: buttonColor1, fontSize: 17),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(time == null ? "" : time.toString()),
          ),
          SizedBox(
            height: 10,
          ),
          CardExpanded(
              iconCard: Icons.class_,
              name:
                  "${matric == null ? emp : matric.toString().toUpperCase()}"),
          CardExpanded(
              iconCard: Icons.school,
              name: "${level == null ? emp : level.toString().toUpperCase()}"),
          CardExpanded(
              iconCard: Icons.email,
              name: "${email == null ? emp : email.toString()}"),
          CardExpanded(
              iconCard: Icons.person,
              name:
                  "${gender == null ? emp : gender.toString().toUpperCase()}"),
        ],
      ),
    );
  }
}

class CardExpanded extends StatelessWidget {
  final String name;
  final IconData iconCard;
  const CardExpanded({this.name, this.iconCard});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      child: Card(
        //color: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: <Widget>[
              Icon(
                iconCard,
                color: buttonColor1,
                size: 35,
              ),
              SizedBox(
                width: 25,
              ),
              Flexible(
                child: Text(
                  name.toString(),
                  style: TextStyle(
                    color: buttonColor1,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
