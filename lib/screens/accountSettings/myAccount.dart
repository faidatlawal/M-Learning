import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_quiz/backEnd/authentication.dart';
import 'package:mobile_quiz/backEnd/database.dart';
import 'package:mobile_quiz/constants/widgets.dart';
import 'package:flutter/services.dart';

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


  getUS(){
    myDatabaseServices.getUserData(userId: auth.currentUser.uid).then((value) {
      setState(() {
        name =  value.data()['name'].toString().toUpperCase();
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

     return  Scaffold(
        backgroundColor: backgroundColor1,

        body: SafeArea(
           child: Column(
             children: [
               Expanded(
                 child: Container(
                   width: MediaQuery.of(context).size.width,
                   color: buttonColor1,
                   child:  Column(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                     children: [
                       Padding(
                         padding: const EdgeInsets.only(top:8.0),
                         child: Text(name.toString(), style: TextStyle(
                           fontSize: 16,
                           fontWeight: FontWeight.bold,
                           color: Colors.white,
                         ),
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(top:3.0),
                         child: Container(
                             child: CircleAvatar(
                               radius: 40,
                               backgroundColor: Colors.white,
                               child: Icon(Icons.person, color: Colors.red, size: 30,),
                             ),

                         ),
                       ),
                     ],
                   ),
                 ),
               ),
               ListTile(title: Text("Joined on: ${ date == null ? "" : date.toString()}", style: TextStyle(color: buttonColor1, fontSize: 17), ), subtitle: Text(time == null ? "" : time.toString(), style: TextStyle(color: buttonColor1, fontWeight: FontWeight.w500),),),
             Expanded(
               flex: 3,
               child: Column(children: [
                 CardExpanded(iconCard: Icons.class_, name: "${matric == null ? emp : matric.toString().toUpperCase()}"),
                 CardExpanded(iconCard: Icons.school, name: "${level == null ? emp : level.toString().toUpperCase()}"),
                 CardExpanded(iconCard: Icons.email, name: "${email == null ? emp : email.toString()}"),
                 CardExpanded(iconCard: Icons.person, name: "${gender == null ? emp: gender.toString().toUpperCase()}"),

                 GestureDetector(
                   onTap: (){
                     //===============================================
                   },
                   child: Padding(
                     padding: const EdgeInsets.symmetric(horizontal:10.0, vertical: 10),
                     child: button(context: context, textTitle: "Edit Profile"),
                   ),
                 ),
      ],)



             )
             ],
           ),
         ),
      );

  }
}

class CardExpanded extends StatelessWidget {
  final String name;
  final IconData iconCard;
  const CardExpanded({this.name, this.iconCard}) ;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        //color: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: <Widget>[
              Icon(iconCard,
                color: appB,
                size: 35,
              ),
              SizedBox(
                width: 25,
              ),
              Text(name.toString(),
                style: TextStyle(
                    color: appB,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
